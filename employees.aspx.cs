using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class employees : System.Web.UI.Page
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

        if (!Page.IsPostBack)
        {


            foreach (ListItem item in ColumnCheckBoxList.Items)
            {
                item.Selected = true;  //makes all of the checkboxlist items selected by default
            }


            //calls the show data method to fill table


            if (Request.QueryString["departmentid"] != null)  //On the event that there is a query string coming from the departments page it will instead load the table with a where clause
            {
                this.BindGrid(null, false, true, "DepartmentID = '" + Request.QueryString["departmentid"] + "' ");
                
                departidtxt.Text = Request.QueryString["departmentid"].Trim( new Char[] { ' ', 'D', '-' });  //Places department id redirect query string in the search textbox for visual cue
            }
            else
            {
                this.BindGrid();  //The default cause on the event there is no query string and the user goes directly to the page
            }

        }

        EmployeeGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
        EmployeeGridView.HeaderRow.ControlStyle.CssClass = "thead-dark";


    }

    private string SortColumn //Private string keeps track of current preferred column for sorting with EmployeeID as the default
    {
        get { return ViewState["SortColumn"] != null ? ViewState["SortColumn"].ToString() : "ID"; }
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

            string sqlquery = "SELECT * FROM EmployeesWithDeptName ";  //The default query statement

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

                            EmployeeGridView.DataSource = dv;
                        }
                        else   //The initial load of the page calls this if statement to give a default sort
                        {
                            EmployeeGridView.DataSource = dt;
                        }
                        EmployeeGridView.DataBind();
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
        EmployeeGridView.PageIndex = e.NewPageIndex;
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




    //Method called when searching with a name for an employee
    protected void EmployeeNameSearch(object sender, EventArgs e)
    {
        if (employeenametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(this.SortColumn, false, true, " Name LIKE '%" + employeenametxt.Text + "%'");
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {
            this.WhereClause = null;
            this.RefreshTable("where");


        }
    }

    //Method called when searching with an id for an employee
    protected void EmployeeIDSearch(object sender, EventArgs e)
    {
        if (employeeidtxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(this.SortColumn, false, true, "ID= 'E-" + employeeidtxt.Text + "'");  //Automatically will have the characters E- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            this.WhereClause = null;
            this.RefreshTable("where");

        }
    }

    //Method called when searching with a department name
    protected void DepartNameSearch(object sender, EventArgs e)
    {
        if (departnametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(this.SortColumn, false, true, " DepartmentName LIKE '%" + departnametxt.Text + "%'");
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {
            this.RefreshTable("where");


        }
    }

    //Method called when searching for id of a department
    protected void DepartIDSearch(object sender, EventArgs e)
    {
        if (departidtxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.BindGrid(this.SortColumn, false, true, "DepartmentID= 'D-" + departidtxt.Text + "'");  //Automatically will have the characters D- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            this.RefreshTable("where");

        }
    }








    protected void Check_Clicked(object sender, EventArgs e)  //Method called when any member of the checkboxlist is updated and will refresh the table to see if any columns need to be hidden or shown.
    {
        foreach (ListItem item in ColumnCheckBoxList.Items)
        {
            

            if(Int32.Parse(item.Value) == 3)  //If statement checks if the department info ground was selected and will either hide or show all department related columns
            {
                EmployeeGridView.Columns[3].Visible = item.Selected;
                EmployeeGridView.Columns[4].Visible = item.Selected;
            }
            else  //The default checker in the event a special group was not chosen and will hide or show column based on the checklist
            {
                EmployeeGridView.Columns[Int32.Parse(item.Value)].Visible = item.Selected;
            }
            
        }
    }

    protected void RadBoth_CheckedChanged(object sender, EventArgs e) //Will refresh the table and set the admin status filter to null
    {
        this.StatusFilter = null;
        this.RefreshTable();
    }

    protected void RadAdmin_CheckedChanged(object sender, EventArgs e) //Will refresh the table and set the admin status filter to only admins
    {
        this.StatusFilter = "Admin = 'YES'";
        this.RefreshTable();
    }

    protected void RadNonAdmin_CheckedChanged(object sender, EventArgs e) //Will refresh the table and set the admin status filter to only nonadmins
    {
        this.StatusFilter = "Admin = 'NO'";
        this.RefreshTable();
    }


    protected void RefreshTable(string element = null)  //Method called when refreshing a table without needing to completely remake a statement
    {

        if (element == "where")  //When refreshing a where clause it will also make the where clause null
        {
            this.WhereClause = null;
        }


        this.BindGrid(this.SortColumn, false);
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