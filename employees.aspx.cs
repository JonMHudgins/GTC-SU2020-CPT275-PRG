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
    TableBase Base;  //Empty TableBase class called for built in methods to be avaliable
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

            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("EmployeesWithDeptName", "ID");
            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["Table"] = Base;
            //Initial binding and loading of data onto table
           
            //calls the show data method to fill table


            if (Request.QueryString["departmentid"] != null)  //On the event that there is a query string coming from the departments page it will instead load the table with a where clause
            {
                this.Binding(Base.Search("DepartmentID = '" + Request.QueryString["departmentid"] + "' "));
                
                departidtxt.Text = Request.QueryString["departmentid"].Trim( new Char[] { ' ', 'D', '-' });  //Places department id redirect query string in the search textbox for visual cue
            }
            else
            {
                this.Binding();  //The default cause on the event there is no query string and the user goes directly to the page
            }
        }
        else
        {
            Base = (TableBase)ViewState["Table"];
        }

        EmployeeGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
        EmployeeGridView.HeaderRow.ControlStyle.CssClass = "thead-dark";

    }


    //Method used when the page is intially called and loaded
    private void Binding()
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned DataView
        EmployeeGridView.DataSource = Base.BindGrid();
        EmployeeGridView.DataBind();  //Calls for the page to be updated and a postback
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        EmployeeGridView.DataSource = view;
        EmployeeGridView.DataBind(); //Calls for the page to be updated and a postback
    }


    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  //Called when trying to sort columns on page.
    {
        this.Binding(Base.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  //Called when making use of paging on table when more than about 10 items by default
    {
        EmployeeGridView.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        this.Binding(Base.Paging());  //Calls for the table source to be refreshed with new paging data
    }

    //Method called when searching with a name for an employee
    protected void EmployeeNameSearch(object sender, EventArgs e)
    {
        if (employeenametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search(" Name LIKE '%" + employeenametxt.Text + "%'"));
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with an id for an employee
    protected void EmployeeIDSearch(object sender, EventArgs e)
    {
        if (employeeidtxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search("ID= 'E-" + employeeidtxt.Text + "'"));  //Automatically will have the characters E- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with a department name
    protected void DepartNameSearch(object sender, EventArgs e)
    {
        if (departnametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search(" DepartmentName LIKE '%" + departnametxt.Text + "%'"));
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {
            this.Binding(Base.Search());
        }
    }

    //Method called when searching for id of a department
    protected void DepartIDSearch(object sender, EventArgs e)
    {
        if (departidtxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search("DepartmentID= 'D-" + departidtxt.Text + "'"));  //Automatically will have the characters D- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            this.Binding(Base.Search());
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
        this.Binding(Base.FilterClear());
    }

    protected void RadAdmin_CheckedChanged(object sender, EventArgs e) //Will refresh the table and set the admin status filter to only admins
    {
        this.Binding(Base.FilterActive("Admin = 'YES'"));
    }

    protected void RadNonAdmin_CheckedChanged(object sender, EventArgs e) //Will refresh the table and set the admin status filter to only nonadmins
    {
        this.Binding(Base.FilterActive("Admin = 'NO'"));
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