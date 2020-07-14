using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ItemLookup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!Page.IsPostBack)
        {

            //calls the show data method to fill table


            this.BindGrid();
            
        }

        
    }


    private string SortDirection  //Private string keeps track of current preferred sorting direction with ascending as the default
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }



    private void BindGrid(string sortExpression = null, bool where = false, string searchquery = null)  //Called to initially bind and display table on webpage with no sorting string by default || Search string is used to look for specific items with where clause statement
    {
        string constr = ConfigurationManager.ConnectionStrings["invDBConStr"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))  //Binds connection string to sql connection
        {

            string sqlquery = "SELECT SKU, ItemName, Quantity, Price, LastOrderDate FROM Items ";  //The default query statement

            if (where != false && searchquery != null)  //Checks to see if a search is requested or not before sending statement and if it does a where clause is appended along with search string
            {
                sqlquery += "WHERE " + searchquery;
            }





            using (SqlCommand cmd = new SqlCommand(sqlquery))  //The query string sent to database
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())  
                {
                    cmd.Connection = con;
                    
                    sda.SelectCommand = cmd;
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);  //Fills the table with bound data
                        if (sortExpression != null)  //Any future column sorts are sent here after initial load and appends the desired sort direction to the query string.
                        {
                            DataView dv = dt.AsDataView();
                            this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";

                            dv.Sort = sortExpression + " " + this.SortDirection;
                            ItemLookUpGridView.DataSource = dv;
                        }
                        else   //The initial load of the page calls this if statement to give a default sort
                        {
                            ItemLookUpGridView.DataSource = dt;
                        }
                        ItemLookUpGridView.DataBind();
                    }
                }
            }
        }
    }

    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  //Called when trying to sort columns on page.    ISSUE: Undoes the search query need to fix
    {
        this.BindGrid(e.SortExpression);  //Sends sort expression to refresh datatable
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  //Called when making use of paging on table when more than about 10 items by default
    {
        ItemLookUpGridView.PageIndex = e.NewPageIndex;
        this.BindGrid();
    }


    /*  Needs sort direction img

    // This is a helper method used to add a sort direction
    // image to the header of the column being sorted.
    protected void AddSortImage(int columnIndex, GridViewRow headerRow)
    {

        // Create the sorting image based on the sort direction.
        Image sortImage = new Image();
        if (ItemLookUpGridView.SortDirection == SortDirection.Ascending)
        {
            sortImage.ImageUrl = "~/Images/Ascending.jpg";
            sortImage.AlternateText = "Ascending Order";
        }
        else
        {
            sortImage.ImageUrl = "~/Images/Descending.jpg";
            sortImage.AlternateText = "Descending Order";
        }

        // Add the image to the appropriate header cell.
        headerRow.Cells[columnIndex].Controls.Add(sortImage);

    }
    */




        //Method called when searching for given item name
    protected void NameSearch(object sender, EventArgs e)
    {
        if (itemnametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(null, true, "ItemName LIKE '%" + itemnametxt.Text + "%'");
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table.
        {
            this.BindGrid();
        }
    }

    //Method called when searching for SKU of item
    protected void SKUSearch(object sender, EventArgs e)
    {
        if (skutxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(null, true, "SKU= 'I-" + skutxt.Text + "'");  //Automatically will have the characters I- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table.
        {
            this.BindGrid();
        }
    }
}