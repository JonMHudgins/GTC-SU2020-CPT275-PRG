using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

public partial class Placeholdmodal : System.Web.UI.Page
{
    TableBase BaseItem; //Tablebase used for the item/top gridview
    //TableBase BaseOrder; //Tablebased used for the purchaseorder/bottom gridview

    DataTable dt;

    string[] itemSKU = new string[4]; //Used to store the selected item
    string orderSKU;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack) //Detects if this is the first page load or refresh
        {




            //Creates default TableBase object based on target view/table and Default sorting column
            BaseItem = new TableBase("AddItem", "SKU");
            
            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["ItemTable"] = BaseItem;

            //New Mepty datatable is created to store data of temporary purchase order
            dt = new DataTable();
            //Columns are added to new datatable with appropriate names
            dt.Columns.AddRange(new DataColumn[5] { new DataColumn("SKU", typeof(string)), new DataColumn("ItemName", typeof(string)), new DataColumn("SupplierID", typeof(string)), new DataColumn("Quantity", typeof(int)), new DataColumn("Price", typeof(decimal)) });
            
            
            ViewState["ordertable"] = dt;

            //Initial binding and loading of data onto table
            GridViewItem.DataSource = BaseItem.BindGrid();
            GridViewItem.DataBind();
            OrderBinding();


        }
        else //All consecutive refreshes/postbacks will update the ViewState key with new recurring data.
        {
            BaseItem = (TableBase)ViewState["ItemTable"];
            //BaseOrder = (TableBase)ViewState["OrderTable"];
            dt = ViewState["ordertable"] as DataTable;
            OrderBinding();
            
            if(GridViewItem.SelectedRow != null) //Checks to see if there are any selected rows during a postback
            {
                AddItemButton.Enabled = true;

            }
            else
            {
                AddItemButton.Enabled = false;
            }


            
        }

        TotalPrice();
    }


    //Method used when one of the events on the page is updating the table and query 
    private void ItemBinding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        GridViewItem.DataSource = view;
        GridViewItem.DataBind(); //Calls for the page to be updated and a postback
        
    }

    private void OrderBinding()
    {
        
        GridViewOrder.DataSource = dt;
        GridViewOrder.DataBind();
    }



    //Activated when using the select button on a column and will store the SKU of the row also changes the selected row's style to light blue
    protected void GridViewItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemSKU[0] = GridViewItem.SelectedRow.Cells[1].Text;
        itemSKU[1] = GridViewItem.SelectedRow.Cells[2].Text;
        itemSKU[2] = GridViewItem.SelectedRow.Cells[3].Text;
        itemSKU[3] = GridViewItem.SelectedRow.Cells[5].Text;

        ViewState["selectedrow"] = itemSKU;
        AddItemButton.Enabled = true;

    }

    protected void GridViewItem_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewItem.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        this.ItemBinding(BaseItem.Paging());  //Calls for the table source to be refreshed with new paging data
    }

    protected void GridViewItem_Sorting(object sender, GridViewSortEventArgs e)
    {
        this.ItemBinding(BaseItem.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
    }

    //Search for item with either SKU or Name
    protected void Search_Click(object sender, EventArgs e)
    {
        if (SearchText.Text != "") //Checks to see if the itemnametxt textbox is an empty string
        {
            if(SearchText.Text.Contains("I-"))
            {
                this.ItemBinding(BaseItem.Search("SKU = '" + SearchText.Text + "'"));
            }
            else
            {
                this.ItemBinding(BaseItem.Search("ItemName LIKE '%" + SearchText.Text + "%'")); //if string is not empty it will create a new statement to append to the where clause using the itemname column and call for a datasource refresh from the TableBase object
            }
            
        }
        else
        {
            this.ItemBinding(BaseItem.Search()); //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
        }
    }
    //Adds selected item to purchase order table along with quantity
    protected void AddItemButton_Click(object sender, EventArgs e)
    {
        DataTable dt = ViewState["ordertable"] as DataTable;
        itemSKU = ViewState["selectedrow"] as string[];

        if (QuantityText.Text != "" && QuantityText.Text.All(char.IsDigit) && QuantityText.Text != "0") //Checks to make sure the quantity text is not empty or not a int
        {
            DataRow newrow = dt.NewRow();
            newrow[0] = itemSKU[0];
            newrow[1] = itemSKU[1];
            newrow[2] = itemSKU[2];
            newrow[3] = Int32.Parse(QuantityText.Text);
            newrow[4] = Decimal.Parse(itemSKU[3]);
            dt.Rows.Add(newrow);

            ViewState["ordertable"] = dt;

            GridViewItem.SelectedIndex = -1;
            OrderBinding();
            AddItemButton.Enabled = false;
            OrderButtons();
            TotalPrice();
        }
        

        
    }

    


    //Section for PurchaseOrder (bottom)
    


    
    

    //Used to pass the data from the selected column
    protected void GridViewOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        orderSKU = GridViewOrder.SelectedRow.Cells[1].Text;

        ViewState["selectedorder"] = orderSKU;


        OrderButtons();
    }

    //Used for paging
    protected void GridViewOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewOrder.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        //this.OrderBinding(BaseOrder.Paging());  //Calls for the table source to be refreshed with new paging data
    }



    

    protected void GridViewOrder_Sorting(object sender, GridViewSortEventArgs e)
    {

        dt = ViewState["ordertable"] as DataTable;
        DataView dv = dt.DefaultView;

        string strSortOrder = "";
        if (ViewState["SortOrder"] == null)
        {
            ViewState["SortOrder"] = "asc";
        }
        if (ViewState["SortOrder"].ToString() == "asc")
        {
            ViewState["SortOrder"] = "desc";
            strSortOrder = "desc";
        }
        else if (ViewState["SortOrder"].ToString() == "desc")
        {
            ViewState["SortOrder"] = "asc";
            strSortOrder = "asc";
        }

        dv.Sort = e.SortExpression + " " + strSortOrder;
        dt = dv.ToTable();
        ViewState["ordertable"] = dt;

        OrderBinding();

    }

    //Deletes individual selected item
    protected void DeleteBtn_Click(object sender, EventArgs e)
    {
        orderSKU = ViewState["selectedorder"].ToString();

        foreach(DataRow row in dt.Rows)
        {
            if (row["SKU"].ToString().Equals(orderSKU))
            {
                dt.Rows.Remove(row);
                break;
            }
        }

        ViewState["ordertable"] = dt;
        GridViewOrder.SelectedIndex = -1; //Clears selected row once completed
        OrderBinding();
        TotalPrice();
        OrderButtons();
    }

    //Clears entire bottom table
    protected void DeleteAllBtn_Click(object sender, EventArgs e)
    {
        
        dt.Rows.Clear();
        ViewState["ordertable"] = dt;
        OrderBinding();
        TotalPrice();
        OrderButtons();
        GridViewOrder.SelectedIndex = -1; //Clears selected row once completed
    }

    protected void CreateButton_Click(object sender, EventArgs e)
    {

        //Transaction scope here
    }

    //Used to calculate the rough total price
    protected void TotalPrice()
    {
        

        if (dt.Rows.Count != 0)
        {


            TotalLabel.Text = "Total Price: " + (Convert.ToDecimal(dt.Compute("SUM(Price)", string.Empty))  * Convert.ToDecimal(dt.Compute("SUM(Quantity)", string.Empty))).ToString();
        }
        else
        {
            TotalLabel.Text = "Total Price: 0.0";
        }
        
    }

    protected void OrderButtons()
    {
        if (dt != null && dt.Rows.Count > 0 && GridViewOrder.SelectedIndex != -1) //checks to see if the bottom grid has any rows or is empty
        {
            DeleteBtn.Enabled = true;
            
            CreateButton.Enabled = true;
            
        }
        else
        {
            DeleteBtn.Enabled = false;
            CreateButton.Enabled = false;
        }

        if (dt != null && dt.Rows.Count > 0) 
        {
            DeleteAllBtn.Enabled = true;
        }
        else
        {
            DeleteAllBtn.Enabled = false;
        }

        TotalPrice();

    }

}