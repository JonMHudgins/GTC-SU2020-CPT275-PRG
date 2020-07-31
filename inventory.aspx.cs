using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;

public partial class ItemLookup : System.Web.UI.Page
{
    TableBase Base;  //Empty TableBase class called for built in methods to be avaliable

    //Method used to load and refresh page for postbacks and initializing
    protected void Page_Load(object sender, EventArgs e)
    {
        
        HttpCookie cookie = Request.Cookies["userInfo"];
        if (Request.Cookies["userInfo"] == null)
        {
            Response.Redirect("login.aspx");
        }
        else
        {
            nameLabel.Text = Request.Cookies["userInfo"]["firstName"];
            cookie.Expires = DateTime.Now.AddMinutes(10);
            //Checks to see if the user is an admin or not and enables related department and employee items to be shown
            if (Request.Cookies["userInfo"]["admin"] == "True")  
            {
                departmentnav.Visible = true;
                employeenav.Visible = true;
                ItemLookUpGridView.Columns[1].Visible = true;

            }
                Response.Cookies.Set(cookie);
        }
        //Detects if this is the first page load or refresh
        if (!Page.IsPostBack) 
        {


            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("ItemsStatusLocation", "SKU");
            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["Table"] = Base;  
            //Initial binding and loading of data onto table
            this.Binding();
            
            
        }
        //All consecutive refreshes/postbacks will update the ViewState key with new recurring data.
        else
        {
            Base = (TableBase)ViewState["Table"];
        }

       
    }
 

    //Method used when the page is intially called and loaded
    private void Binding()
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned DataView
        ItemLookUpGridView.DataSource = Base.BindGrid();
        //Calls for the page to be updated and a postback
        ItemLookUpGridView.DataBind();  
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        ItemLookUpGridView.DataSource = view;
        //Calls for the page to be updated and a postback
        ItemLookUpGridView.DataBind(); 
    }


    //Called when trying to sort columns on page.
    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)
    { 
        this.Binding(Base.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting

    }

    //Called when making use of paging on table when more than about 10 items by default
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  
    {
        //The current paging index that has been selected gets changed to the new index
        ItemLookUpGridView.PageIndex = e.NewPageIndex;
        //Calls for the table source to be refreshed with new paging data
        this.Binding(Base.Paging()); 
    }

    //Method called when using the name search button
    protected void NameSearch(object sender, EventArgs e)
    {
        //Checks to see if the itemnametxt textbox is an empty string
        if (itemnametxt.Text != "") 
        {
            //if string is not empty it will create a new statement to append to the where clause using the itemname column and call for a datasource refresh from the TableBase object
            this.Binding(Base.Search("ItemName LIKE '%" + itemnametxt.Text + "%'")); 
        }
        else
        {
            //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
            this.Binding(Base.Search()); 
        }
    }

    //Method called when using the SKu to search for given SKU
    protected void SKUSearch(object sender, EventArgs e)
    {
        //Checks to see if the skutxt textbox is an empty string
        if (skutxt.Text != "") 
        {
            this.Binding(Base.Search("SKU= 'I-" + skutxt.Text + "'")); //if string is not empty it will create a new statement to append to the where clause using the SKU table and call for a datasource refresh from the TableBase object
        }
        else
        {
            this.Binding(Base.Search());//if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
        }
    }

    

    protected void ShowStatus_CheckedChanged(object sender, EventArgs e)
    {
        if((Active.Checked && Inactive.Checked) || (!Active.Checked && !Inactive.Checked)) //Event if both check boxes are checked or empty
        {
            this.Binding(Base.FilterClear()); //Calls the TableBase object's filter method to refresh the datasource and clear the status filter
        }
        else if(Active.Checked && !Inactive.Checked) //Event if only Active items are checked
        {
            this.Binding(Base.FilterActive("Status = 'A'"));  //Calls the TableBase object's filter method to refresh the datasource and append the status filter
        }
        else if(!Active.Checked && Inactive.Checked) //Event if only Inactive items are checked
        {
            this.Binding(Base.FilterActive("Status = 'I'")); //Calls the TableBase object's filter method to refresh the datasource and append the status filter
        }
    }


    protected void logoutLink_Click(object sender, EventArgs e)
    {

        if (Request.Cookies["userInfo"] != null)
        {
            Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(-1);
        }
        Response.Redirect("login.aspx", false);
    }


    

    protected void ColumnShow_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox checkBox = (sender as CheckBox);
        int column = Int32.Parse(checkBox.ID.Substring(checkBox.ID.Length - 1));
        ItemLookUpGridView.Columns[column + 3].Visible = checkBox.Checked;
    }

    protected void ItemLookUpGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //NewEditIndex property used to determine the index of the row being edited.
        ItemLookUpGridView.EditIndex = e.NewEditIndex;
        Binding(Base.RefreshTable());
    }

    protected void ItemLookUpGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //Finding the controls from Gridview for the row which is going to update 

        
        

        GridViewRow row = (GridViewRow)ItemLookUpGridView.Rows[e.RowIndex];

        Label textid = ItemLookUpGridView.Rows[e.RowIndex].FindControl("lbl_SKU") as Label;
        TextBox textName = (TextBox)row.Cells[3].Controls[0];
        TextBox textLocID = (TextBox)row.Cells[4].Controls[0];
        TextBox textOnH = (TextBox)row.Cells[5].Controls[0];
        TextBox textToQ = (TextBox)row.Cells[6].Controls[0];
        TextBox textPrice = (TextBox)row.Cells[7].Controls[0];
        TextBox textStatus = (TextBox)row.Cells[9].Controls[0];
        TextBox textSupID = (TextBox)row.Cells[10].Controls[0];
        TextBox textCom = (TextBox)row.Cells[11].Controls[0];

    
        ItemLookUpGridView.EditIndex = -1;
        
        if (CreateTransactionScope.MakeTransactionScope(String.Format("EXEC ItemModal @Action = 'Update', @SKU = '{0}', @Name = '{1}', @Price = '{2}', @Quantity = '{3}', @OnHand = '{4}', @SupplierID = '{5}', @Comments = '{6}', @LocationID = '{7}'",
            textid.Text, textName.Text, textPrice.Text, textToQ.Text, textOnH.Text, textSupID.Text, textCom.Text, textLocID.Text)) > 0)
        {
            itemlbl.Text = "Item was successfully edited";
            itemlbl.Visible = true;
        }
        else
        {
            itemlbl.Text = "One or more fields were invalid changes reverted";
            itemlbl.Visible = true;
        }
        
        Binding(Base.RefreshTable());


    }

    protected void ItemLookUpGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        ItemLookUpGridView.EditIndex = -1;
        Binding(Base.RefreshTable());
    }


    protected void ItemLookUpGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        Label textid = ItemLookUpGridView.Rows[e.RowIndex].FindControl("lbl_SKU") as Label;
        if(CreateTransactionScope.MakeTransactionScope("EXEC Deleteitem @SKU ='" + textid.Text + "'") > 0)
        {
            itemlbl.Text = "Item has been successfully deleted";
            itemlbl.Visible = true;
        }
        else
        {
            itemlbl.Text = "Item could not be deleted";
            itemlbl.Visible = true;
        }

        Binding(Base.RefreshTable());
    }

}