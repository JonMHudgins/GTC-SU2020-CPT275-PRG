using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            if (Request.Cookies["userInfo"]["admin"] == "True")  //Checks to see if the user is an admin or not and enables related department and employee items to be shown
            {
                departmentnav.Visible = true;
                employeenav.Visible = true;
            }
            else
            {
                Response.Redirect("index.aspx");
            }
            Response.Cookies.Set(cookie);
        }

        if (!Page.IsPostBack)
        {



            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("EmployeesWithDeptName", "ID");
            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["Table"] = Base;
            //Initial binding and loading of data onto table

            //calls the show data method to fill table


            if (Request.QueryString["departmentid"] != null)  //On the event that there is a query string coming from the departments page it will instead load the table with a where clause
            {
                this.Binding(Base.Search("DepartmentID = '" + Request.QueryString["departmentid"] + "' "));

                departidtxt.Text = Request.QueryString["departmentid"].Trim(new Char[] { ' ', 'D', '-' });  //Places department id redirect query string in the search textbox for visual cue
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



    protected void ColumnShow_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox checkBox = (sender as CheckBox);
        int column = Int32.Parse(checkBox.ID.Substring(checkBox.ID.Length - 1));

        if (column == 2)  //If statement checks if the department info ground was selected and will either hide or show all department related columns
        {
            EmployeeGridView.Columns[3].Visible = checkBox.Checked;
            EmployeeGridView.Columns[4].Visible = checkBox.Checked;
        }
        else  //The default checker in the event a special group was not chosen and will hide or show column based on the checklist
        {
            EmployeeGridView.Columns[column + 1].Visible = checkBox.Checked;
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

    protected void ShowRank_CheckedChanged(object sender, EventArgs e)
    {
        if ((Admin.Checked && Employee.Checked) || (!Admin.Checked && !Employee.Checked)) //Event if both check boxes are checked or empty
        {
            this.Binding(Base.FilterClear()); //Calls the TableBase object's filter method to refresh the datasource and clear the status filter
        }
        else if (Admin.Checked && !Employee.Checked) //Event if only Admins are checked
        {
            this.Binding(Base.FilterActive("Admin = 'YES'"));  //Calls the TableBase object's filter method to refresh the datasource and append the status filter
        }
        else if (!Admin.Checked && Employee.Checked) //Event if only Employees are checked
        {
            this.Binding(Base.FilterActive("Admin = 'NO'")); //Calls the TableBase object's filter method to refresh the datasource and append the status filter
        }
    }

    protected void EmployeeGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = (GridViewRow)EmployeeGridView.Rows[e.RowIndex];

        Label textid = EmployeeGridView.Rows[e.RowIndex].FindControl("lbl_ID") as Label;
       // TextBox textName = (TextBox)row.Cells[3].Controls[0];
        TextBox textAdmin = (TextBox)row.Cells[4].Controls[0];
        TextBox textDepID = (TextBox)row.Cells[5].Controls[0];
      //  TextBox textDepName = (TextBox)row.Cells[6].Controls[0];
        TextBox textPhone = (TextBox)row.Cells[7].Controls[0];
        TextBox textEmail = (TextBox)row.Cells[8].Controls[0];

        textAdmin.Text = textAdmin.Text == "YES" ? "1" : "0";

        EmployeeGridView.EditIndex = -1;

        if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec EmployeeModal @Action = 'Update', @EmployeeID = '{0}', @Admin = '{1}', @DepartmentID = '{2}', @Email = '{3}', @Phone = '{4}'",
            textid.Text, textAdmin.Text, textDepID.Text, textEmail.Text, textPhone.Text)) > 0)
        {
            emplbl.Text = "Employee was successfully edited";
            emplbl.Visible = true;
        }
        else
        {
            emplbl.Text = "One or more fields were invalid changes reverted";
            emplbl.Visible = true;
        }

        Binding(Base.RefreshTable());
    }

    protected void EmployeeGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        EmployeeGridView.EditIndex = -1;
        Binding(Base.RefreshTable());
    }

    protected void EmployeeGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        EmployeeGridView.EditIndex = e.NewEditIndex;
        Binding(Base.RefreshTable());
    }

    protected void EmployeeGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Label dltID = EmployeeGridView.Rows[e.RowIndex].FindControl("lbl_ID") as Label;

        if (CreateTransactionScope.MakeTransactionScope(String.Format("", dltID.Text)) > 0)
        {
            dltID.Text = "Employee was successfully deleted";
            dltID.Visible = true;
        }
        else
        {
            dltID.Text = "Employee could not be deleted";
            dltID.Visible = true;
        }

        Binding(Base.RefreshTable());
    }
}