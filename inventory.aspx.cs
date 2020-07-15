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


            foreach (ListItem item in ColumnCheckBoxList.Items)
            {
                item.Selected = true;  //makes all of the checkboxlist items selected by default
            }


            //calls the show data method to fill table



            this.BindGrid();
            
        }

        
    }

    private string SortColumn //Private string keeps track of current preferred column for sorting with SKU as the default
    {
        get { return ViewState["SortColumn"] != null ? ViewState["SortColumn"].ToString() : "SKU"; }
        set { ViewState["SortColumn"] = value; }
    }

    private string SortDirection  //Private string keeps track of current preferred sorting direction with ascending as the default
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }  //Condition on left views whether sortdirection is null if not it will return the found direction if it is null it will be ASC by default
        set { ViewState["SortDirection"] = value; }
    }

    private string WhereClause  //Private string keeps track of last searched item to be used before sorting is null by default
    {
        get { return ViewState["WhereClause"] != null ? ViewState["WhereClause"].ToString() : null; }
        set { ViewState["WhereClause"] = value; }

    }
    
    private string StatusFilter  //Private string to keep track of current selected status filter between requests
    {
        get { return ViewState["StatusFilter"] != null ? ViewState["StatusFilter"].ToString() : null; }
        set { ViewState["StatusFilter"] = value; }
    }

    //Sort expression is the columnid being sent
    private void BindGrid(string sortExpression = null, bool sort = false, bool where = false, string searchquery = null)  //Called to initially bind and display table on webpage with no sorting string by default || Search string is used to look for specific items with where clause statement
    {
        string constr = ConfigurationManager.ConnectionStrings["invDBConStr"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))  //Binds connection string to sql connection
        {

            string sqlquery = "SELECT Items.*, Status FROM Items JOIN Status ON Status.SKU = Items.SKU ";  //The default query statement

            if (where != false && searchquery != null) //Checks to see if a search is requested or not before sending statement and if it does a where clause is appended along with search string
            {
                sqlquery += "WHERE " + searchquery;
                this.WhereClause = searchquery;
                if(this.StatusFilter != null) //If statement checks to see if the status filter string is null and if not will append the filter to the query
                {
                    sqlquery += " AND " + this.StatusFilter;
                }
            }
            else if(this.WhereClause != null)  //Second check to see if the sorting method or new page index was called and if so will append the sotred wherecluase statement
            {
                sqlquery += "WHERE " + this.WhereClause;
                if (this.StatusFilter != null)
                {
                    sqlquery += " AND " + this.StatusFilter;
                }
            }
            else if (this.StatusFilter != null) //checks to see if even in the event no other where clauses are being added that a status filter will still be appended
            {
                sqlquery += "WHERE " + this.StatusFilter;
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

                            if (sort) //checks to see if empty search was given in order to prevent sorting
                            {
                                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";  //swaps sorting direction if trying to use the same column to sort.
                            }
                            dv.Sort = sortExpression + " " + this.SortDirection;  //apends the column and sort direction to sort request.
          
                            ItemLookUpGridView.DataSource = dv;
                        }
                        else   //The initial load of the page calls this if statement to give a default sort
                        {
                            ItemLookUpGridView.DataSource = dt;
                        }
                        ItemLookUpGridView.DataBind();
                        this.SortColumn = sortExpression;  //Sends last used column to private string

                    }
                }
            }
        }
    }

    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  //Called when trying to sort columns on page.    ISSUE: Undoes the search query need to fix
    {
        this.BindGrid(e.SortExpression, true);  //Sends sort expression to refresh datatable
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  //Called when making use of paging on table when more than about 10 items by default
    {
        ItemLookUpGridView.PageIndex = e.NewPageIndex;
        this.BindGrid(this.SortColumn);  //sends stored sorting column to reserve current sorting
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
            this.BindGrid(this.SortColumn, false, true, "ItemName LIKE '%" + itemnametxt.Text + "%'");
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {
            this.WhereClause = null;
            this.BindGrid(this.SortColumn, false);
            

        }
    }

    //Method called when searching for SKU of item
    protected void SKUSearch(object sender, EventArgs e)
    {
        if (skutxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(this.SortColumn, false, true, "SKU= 'I-" + skutxt.Text + "'");  //Automatically will have the characters I- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            this.WhereClause = null;
            this.BindGrid(this.SortColumn, false);
            
        }
    }


    protected void Check_Clicked(object sender, EventArgs e)  //Method called when any member of the checkboxlist is updated and will refresh the table to see if any columns need to be hidden or shown.
    {
        foreach (ListItem item in ColumnCheckBoxList.Items)
        {
            ItemLookUpGridView.Columns[Int32.Parse(item.Value)].Visible = item.Selected;
        }
    }

    protected void RadBoth_CheckedChanged(object sender, EventArgs e)
    {
        this.StatusFilter = null;
        this.BindGrid(this.SortColumn, false);
    }

    protected void RadActive_CheckedChanged(object sender, EventArgs e)
    {
        this.StatusFilter = "Status = 'A'";
        this.BindGrid(this.SortColumn, false);
    }

    protected void RadInactive_CheckedChanged(object sender, EventArgs e)
    {
        this.StatusFilter = "Status = 'I'";
        this.BindGrid(this.SortColumn, false);
    }
}