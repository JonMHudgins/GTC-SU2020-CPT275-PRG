using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class purchaseorderlines : System.Web.UI.Page
{
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
            Response.Cookies.Set(cookie);
        }
        if (!IsPostBack)
        {

            this.PurchID = Request.QueryString["purchid"];  //Grabs the id attached to query string after redirect from purchaseorders page

            //Labels give basic overall information of purchase order using query string
            LabOrdedID.Text = "Purchase ID: " + this.PurchID;
            LabOrderer.Text = "Order Creator: " + Request.QueryString["name"];
            LabODate.Text = "Date Ordered: " + Request.QueryString["odate"];
            LabDDate.Text = "Date Delievered: " + Request.QueryString["ddate"];

            this.BindGrid();
        }

    }

    private string PurchID //Stores the purchas id to filter for only the currently selected purchase order items
    {
        get { return ViewState["PurchID"] != null ? ViewState["PurchID"].ToString() : ""; }  //On the event that somehow the page is loaded without a purchase id query stirng the purch id string will be empty
        set { ViewState["PurchID"] = value; }
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


    private void BindGrid(string sortExpression = null, bool sort = false, bool where = false, string searchquery = null)  //Called to initially bind and display table on webpage with no sorting string by default || Search string is used to look for specific items with where clause statement
    {
        string constr = ConfigurationManager.ConnectionStrings["invDBConStr"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))  //Binds connection string to sql connection
        {

            string sqlquery = "SELECT * FROM PurchasePriceLine WHERE PurchID = " + "'" + this.PurchID + "' ";  //The default query statement

            if (where != false && searchquery != null) //Checks to see if a search is requested or not before sending statement and if it does a where clause is appended along with search string
            {
                sqlquery += "AND " + searchquery;
                this.WhereClause = searchquery;
            }
            else if (this.WhereClause != null)  //Second check to see if the sorting method or new page index was called and if so will append the sotred wherecluase statement
            {
                sqlquery += "AND " + this.WhereClause;

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

                            PurchaseOrderLinesGridView.DataSource = dv;
                        }
                        else   //The initial load of the page calls this if statement to give a default sort
                        {
                            PurchaseOrderLinesGridView.DataSource = dt;
                        }
                        PurchaseOrderLinesGridView.DataBind();
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
        PurchaseOrderLinesGridView.PageIndex = e.NewPageIndex;
        this.BindGrid(this.SortColumn);  //sends stored sorting column to reserve current sorting
    }

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

    protected void logoutLink_Click(object sender, EventArgs e)
    {

        if (Request.Cookies["userInfo"] != null)
        {
            Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(-1);
        }
        Response.Redirect("login.aspx", false);
    }

}