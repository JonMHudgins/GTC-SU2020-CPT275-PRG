using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class departments : System.Web.UI.Page
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
        this.BindGrid();

        DepartmentsGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
        DepartmentsGridView.HeaderRow.ControlStyle.CssClass = "thead-dark";
        DepartmentsGridView.Columns[2].ControlStyle.CssClass = "btn btn-outline-danger";
    }

    private string SortColumn //Private string keeps track of current preferred column for sorting with DepartmentID as the default
    {
        get { return ViewState["SortColumn"] != null ? ViewState["SortColumn"].ToString() : "DepartmentID"; }
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

    private void BindGrid(string sortExpression = null, bool sort = false, bool where = false, string searchquery = null)  //Called to initially bind and display table on webpage with no sorting string by default || Search string is used to look for specific items with where clause statement
    {
        string constr = ConfigurationManager.ConnectionStrings["invDBConStr"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))  //Binds connection string to sql connection
        {

            string sqlquery = "SELECT * FROM Departments ";  //The default query statement

            if (where != false && searchquery != null) //Checks to see if a search is requested or not before sending statement and if it does a where clause is appended along with search string
            {
                sqlquery += "WHERE " + searchquery;
                this.WhereClause = searchquery;
                if (this.StatusFilter != null) //If statement checks to see if the status filter string is null and if not will append the filter to the query
                {
                    sqlquery += " AND " + this.StatusFilter;
                }
            }
            else if (this.WhereClause != null)  //Second check to see if the sorting method or new page index was called and if so will append the sotred wherecluase statement
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

                            DepartmentsGridView.DataSource = dv;
                        }
                        else   //The initial load of the page calls this if statement to give a default sort
                        {
                            DepartmentsGridView.DataSource = dt;
                        }
                        DepartmentsGridView.DataBind();
                        this.SortColumn = sortExpression;  //Sends last used column to private string

                    }
                }
            }
        }
    }

    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  //Called when trying to sort columns on page.
    {
        this.BindGrid(e.SortExpression, true);  //Sends sort expression to refresh datatable
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  //Called when making use of paging on table when more than about 10 items by default
    {
        DepartmentsGridView.PageIndex = e.NewPageIndex;
        this.BindGrid(this.SortColumn);  //sends stored sorting column to reserve current sorting
    }

    //Method called when searching with a department name
    protected void NameSearch(object sender, EventArgs e)
    {
        if (departnametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(this.SortColumn, false, true, "DepartmentName LIKE '%" + departnametxt.Text + "%'");
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {

            this.RefreshTable("where");


        }
    }

    //Method called when searching with an id of a department
    protected void DepartIDSearch(object sender, EventArgs e)
    {
        if (departidxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(this.SortColumn, false, true, "DepartmentID= 'D-" + departidxt.Text + "'");  //Automatically will have the characters P- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {

            this.RefreshTable("where");

        }
    }

    protected void RefreshTable(string element = null)  //Method called when refreshing a table without needing to completely remake a statement
    {

        if (element == "where")  //When refreshing a where clause it will also make the where clause null
        {
            this.WhereClause = null;
        }


        this.BindGrid(this.SortColumn, false);
    }

    //Used and called when details button is pressed on the gridview
    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Employees") return;  //Checks to make sure command name matches

        int index = Convert.ToInt32(e.CommandArgument.ToString()); //converts retrieved command argument to int for index
        GridViewRow row = DepartmentsGridView.Rows[index];


        string qstring = "/employees.aspx?departmentid=" + row.Cells[0].Text;  //appends array strings to be sent to response redirect


        Response.Redirect(qstring);  //Redirects to employees webpage and attaches departmentid to query string
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