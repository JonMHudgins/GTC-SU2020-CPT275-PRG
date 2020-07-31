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
        else //All consecutive refreshes/postbacks will update the ViewState key with new recurring data.
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

    }

    //Method used when the page is intially called and loaded
    private void Binding()
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned DataView
        DepartmentsGridView.DataSource = Base.BindGrid();
        DepartmentsGridView.DataBind();  //Calls for the page to be updated and a postback
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        DepartmentsGridView.DataSource = view;
        DepartmentsGridView.DataBind(); //Calls for the page to be updated and a postback
    }

    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  //Called when trying to sort columns on page.
    {
        this.Binding(Base.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  //Called when making use of paging on table when more than about 10 items by default
    {
        DepartmentsGridView.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        this.Binding(Base.Paging());  //Calls for the table source to be refreshed with new paging data
    }

    //Method called when searching with a department name
    protected void NameSearch(object sender, EventArgs e)
    {
        if (departnametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search("DepartmentName LIKE '%" + departnametxt.Text + "%'"));
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with an id of a department
    protected void DepartIDSearch(object sender, EventArgs e)
    {
        if (departidxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search("DepartmentID= 'D-" + departidxt.Text + "'"));  //Automatically will have the characters P- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {

            this.Binding(Base.Search());

        }
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

    protected void DepartmentsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = (GridViewRow)DepartmentsGridView.Rows[e.RowIndex];
        Label textid = DepartmentsGridView.Rows[e.RowIndex].FindControl("lbl_DID") as Label;
        TextBox textName = (TextBox)row.Cells[3].Controls[0];



        DepartmentsGridView.EditIndex = -1;

        if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec DepartmentModal @Action = 'Update', @ID = '{0}', @Name = '{1}'", textid.Text, textName.Text)) > 0)
            
        {
            deplbl.Text = "Department was successfully edited";
            deplbl.Visible = true;
        }
        else
        {
            deplbl.Text = "One or more fields were invalid changes reverted";
            deplbl.Visible = true;
        }

        Binding(Base.RefreshTable()); 
    }

    protected void DepartmentsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        DepartmentsGridView.EditIndex = -1;
        Binding(Base.RefreshTable());
    }

    protected void DepartmentsGridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        DepartmentsGridView.EditIndex = e.NewEditIndex;
        Binding(Base.RefreshTable());
    }

    protected void DepartmentsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        Label dltID = DepartmentsGridView.Rows[e.RowIndex].FindControl("lbl_DID") as Label;

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

        Binding(Base.RefreshTable());
    }
}