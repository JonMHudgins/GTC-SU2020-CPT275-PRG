using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class departments : System.Web.UI.Page
{
    TableBase Base;  //Empty TableBase class called for built in methods to be avaliable
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("Departments ", "DepartmentID");
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
                //Redirects the user to the index page if they are not an admin
                Response.Redirect("index.aspx");
            }
            Response.Cookies.Set(cookie);
        }

    }

    //Method used when the page is intially called and loaded
    private void Binding()
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned DataView
        DepartmentsGridView.DataSource = Base.BindGrid();
        //Calls for the page to be updated and a postback
        DepartmentsGridView.DataBind(); 
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        DepartmentsGridView.DataSource = view;
        //Calls for the page to be updated and a postback
        DepartmentsGridView.DataBind(); 
    }

    //Method called when trying to sort columns on page.
    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  
    {
        //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
        this.Binding(Base.Sorting(e));  
    }

    //Method called when making use of paging on table when more than about 10 items by default
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  
    {
        //The current paging index that has been selected gets changed to the new index
        DepartmentsGridView.PageIndex = e.NewPageIndex;
        //Calls for the table source to be refreshed with new paging data
        this.Binding(Base.Paging()); 
    }

    //Method called when searching with a department name
    protected void NameSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (departnametxt.Text != "")  
        {
            //Search query is sent to the table base class and refreshes the table
            this.Binding(Base.Search("DepartmentName LIKE '%" + departnametxt.Text + "%'"));
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        else
        {
            //Empty search query is sent to the table base class and refreshes the table
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with an id of a department
    protected void DepartIDSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (departidxt.Text != "")  
        {
            //Search query is sent to the table base class and refreshes the table and also will append D- automatically
            this.Binding(Base.Search("DepartmentID= 'D-" + departidxt.Text + "'"));  
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        else
        {
            //Empty search query is sent to the table base class and refreshes the table
            this.Binding(Base.Search());

        }
    }

    //Used and called when details button is pressed on the gridview
    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Checks to make sure command name matches
        if (e.CommandName != "Employees") return;

        //converts retrieved command argument to int for index
        int index = Convert.ToInt32(e.CommandArgument.ToString()); 
        GridViewRow row = DepartmentsGridView.Rows[index];

        //appends array strings to be sent to response redirect
        string qstring = "/employees.aspx?departmentid=" + row.Cells[0].Text;

        //Redirects to employees webpage and attaches departmentid to query string
        Response.Redirect(qstring);  
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

    //Method called when pressing the update button
    protected void DepartmentsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //Collects info from edited lines in the table
        GridViewRow row = (GridViewRow)DepartmentsGridView.Rows[e.RowIndex];
        Label textid = DepartmentsGridView.Rows[e.RowIndex].FindControl("lbl_DID") as Label;
        TextBox textName = (TextBox)row.Cells[3].Controls[0];


        //Resets the edit index
        DepartmentsGridView.EditIndex = -1;

        //A new transactionscope is sent and returns and displays whether it is successful or not
        if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec DepartmentModal @Action = 'Update', @ID = '{0}', @Name = '{1}'", textid.Text, textName.Text)) > 0)
            
        {
            //Sets the label text to saying the transaction was successful
            deplbl.Text = "Department was successfully edited";
            deplbl.Visible = true;
        }
        else
        {
            //Sets the label text to saying the transaction was not successful
            deplbl.Text = "One or more fields were invalid changes reverted";
            deplbl.Visible = true;
        }
        //The table is refreshed
        Binding(Base.RefreshTable()); 
    }

    //Method called when pressing the cancel button when editing
    protected void DepartmentsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        DepartmentsGridView.EditIndex = -1;
        Binding(Base.RefreshTable());
    }

    //Method called when pressing the edit button
    protected void DepartmentsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        DepartmentsGridView.EditIndex = e.NewEditIndex;
        Binding(Base.RefreshTable());
    }

    //Method called when delete button is pressed and confirmed
    protected void DepartmentsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //Fetches the id of the employee in the row
        Label dltID = DepartmentsGridView.Rows[e.RowIndex].FindControl("lbl_DID") as Label;

        //Attempts to delete the selected employee
        if (CreateTransactionScope.MakeTransactionScope(String.Format("DELETE FROM Departments WHERE DepartmentID = '{0}'", dltID.Text)) > 0)
        {
            deplbl.Text = "Department was successfully deleted";
            deplbl.Visible = true;
        }
        else
        {
            deplbl.Text = "Department could not be deleted";
            deplbl.Visible = true;
        }
        //Refreshes the table
        Binding(Base.RefreshTable());
    }
}