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
        //Grabs the cookie and checks to see if a user is logged in and if not will redirect to the login page
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
            }
            else
            {
                //The user is redirected to the index if 
                Response.Redirect("index.aspx");
            }
            Response.Cookies.Set(cookie);
        }

        if (!Page.IsPostBack) //Checks to see if the page is a refresh or initial load
        {
            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("EmployeesWithDeptName", "ID");
            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["Table"] = Base;
            //Initial binding and loading of data onto table

            //calls the show data method to fill table

            //On the event that there is a query string coming from the departments page it will instead load the table with a where clause
            if (Request.QueryString["departmentid"] != null)  
            {
                this.Binding(Base.Search("DepartmentID = '" + Request.QueryString["departmentid"] + "' "));
                //Places department id redirect query string in the search textbox for visual cue
                departidtxt.Text = Request.QueryString["departmentid"].Trim(new Char[] { ' ', 'D', '-' });  
            }
            else
            {
                //The default cause on the event there is no query string and the user goes directly to the page
                this.Binding();  
            }
        }
        
        else
        {
            //Grabs the viewstate versino of the tablebase and assigns it to the base object
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
        //Calls for the page to be updated and a postback
        EmployeeGridView.DataBind(); 
    }

    //Called when trying to sort columns on page.
    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  
    {
        //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
        this.Binding(Base.Sorting(e));  
    }

    //Called when making use of paging on table when more than about 10 items by default
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  
    {
        //The current paging index that has been selected gets changed to the new index
        EmployeeGridView.PageIndex = e.NewPageIndex;
        //Calls for the table source to be refreshed with new paging data
        this.Binding(Base.Paging());  
    }

    //Method called when searching with a name for an employee
    protected void EmployeeNameSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (employeenametxt.Text != "")  
        {
            //Search query is sent to the table base class and refreshes the table.
            this.Binding(Base.Search(" Name LIKE '%" + employeenametxt.Text + "%'"));
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        else
        {
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with an id for an employee
    protected void EmployeeIDSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (employeeidtxt.Text != "")  
        {
            //Search query is sent to the table base class and refreshes the table and also will append E- automatically
            this.Binding(Base.Search("ID= 'E-" + employeeidtxt.Text + "'"));  
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        else
        {
            //Empty search query is sent to the table base class and refreshes the table
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with a department name
    protected void DepartNameSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (departnametxt.Text != "")  
        {
            //Search query is sent to the table base class and refreshes the table
            this.Binding(Base.Search(" DepartmentName LIKE '%" + departnametxt.Text + "%'"));
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        else
        {
            //Empty search query is sent to the table base class and refreshes the table
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with id of a department
    protected void DepartIDSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (departidtxt.Text != "")  
        {
            //Search query is sent to the table base class and refreshes the table and also will append D- automatically
            this.Binding(Base.Search("DepartmentID= 'D-" + departidtxt.Text + "'")); 
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        else
        {
            //Empty search query is sent to the table base class and refreshes the table
            this.Binding(Base.Search());
        }
    }


    //Method called when choosing which columns to show
    protected void ColumnShow_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox checkBox = (sender as CheckBox);
        int column = Int32.Parse(checkBox.ID.Substring(checkBox.ID.Length - 1));

        //If statement checks if the department info ground was selected and will either hide or show all department related columns
        if (column == 2)  
        {
            EmployeeGridView.Columns[3].Visible = checkBox.Checked;
            EmployeeGridView.Columns[4].Visible = checkBox.Checked;
        }
        //The default checker in the event a special group was not chosen and will hide or show column based on the checklist
        else
        {
            EmployeeGridView.Columns[column + 1].Visible = checkBox.Checked;
        }
    }

    //Method called when pressing the logout button on the header will log out the user and send them to the login page
    protected void logoutLink_Click(object sender, EventArgs e)
    {

        if (Request.Cookies["userInfo"] != null)
        {
            Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(-1);
        }
        Response.Redirect("login.aspx", false);
    }

    //Method called when using one of the checkboxes for 
    protected void ShowRank_CheckedChanged(object sender, EventArgs e)
    {
        //Event if both check boxes are checked or empty
        if ((Admin.Checked && Employee.Checked) || (!Admin.Checked && !Employee.Checked)) 
        {
            //Calls the TableBase object's filter method to refresh the datasource and clear the status filter
            this.Binding(Base.FilterClear()); 
        }
        //Event if only Admins are checked
        else if (Admin.Checked && !Employee.Checked) 
        {
            //Calls the TableBase object's filter method to refresh the datasource and append the status filter
            this.Binding(Base.FilterActive("Admin = 'YES'"));  
        }
        //Event if only Employees are checked
        else if (!Admin.Checked && Employee.Checked) 
        {
            //Calls the TableBase object's filter method to refresh the datasource and append the status filter
            this.Binding(Base.FilterActive("Admin = 'NO'")); 
        }
    }

    //Method called when the update and confirm button has been pressed
    protected void EmployeeGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        //Collects info from edited lines in the table
        GridViewRow row = (GridViewRow)EmployeeGridView.Rows[e.RowIndex];

        Label textid = EmployeeGridView.Rows[e.RowIndex].FindControl("lbl_ID") as Label;
        TextBox textAdmin = (TextBox)row.Cells[4].Controls[0];
        TextBox textDepID = (TextBox)row.Cells[5].Controls[0];
        TextBox textPhone = (TextBox)row.Cells[7].Controls[0];
        TextBox textEmail = (TextBox)row.Cells[8].Controls[0];

        //Converts the admin text from yes or no into a 1/0 bit
        textAdmin.Text = textAdmin.Text == "YES" ? "1" : "0";

        //Resets the edit index
        EmployeeGridView.EditIndex = -1;

        //A new transactionscope is sent and returns and displays whether it is successful or not
        if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec EmployeeModal @Action = 'Update', @EmployeeID = '{0}', @Admin = '{1}', @DepartmentID = '{2}', @Email = '{3}', @Phone = '{4}'",
            textid.Text, textAdmin.Text, textDepID.Text, textEmail.Text, textPhone.Text)) > 0)
        {
            //Sets the label text to saying the transaction was successful
            emplbl.Text = "Employee was successfully edited";
            emplbl.Visible = true;
        }
        else
        {
            //Sets the label text to saying the transaction was not successful
            emplbl.Text = "One or more fields were invalid changes reverted";
            emplbl.Visible = true;
        }

        //The table is refreshed
        Binding(Base.RefreshTable());
    }

    //Method called when pressing the cancel button when editing
    protected void EmployeeGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        //Clears the edit index of the table
        EmployeeGridView.EditIndex = -1;
        Binding(Base.RefreshTable());
    }

    //Method called when pressing the edit button
    protected void EmployeeGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //Sets the edit index of the table
        EmployeeGridView.EditIndex = e.NewEditIndex;
        Binding(Base.RefreshTable());
    }

    //Method called when delete button is pressed and confirmed
    protected void EmployeeGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        //Fetches the id of the employee in the row
        Label dltID = EmployeeGridView.Rows[e.RowIndex].FindControl("lbl_ID") as Label;


        //Attempts to delete the selected employee
        if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec DeleteEmployee @ID = '{0}'", dltID.Text)) > 0)
        {
            dltID.Text = "Employee was successfully deleted";
            dltID.Visible = true;
        }
        else
        {
            dltID.Text = "Employee could not be deleted";
            dltID.Visible = true;
        }

        //Refreshes the table
        Binding(Base.RefreshTable());
    }
}