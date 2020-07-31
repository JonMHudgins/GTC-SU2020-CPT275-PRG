using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class purchaseorders : System.Web.UI.Page
{
    TableBase Base;  //Empty TableBase class called for built in methods to be avaliable
    protected void Page_Load(object sender, EventArgs e)
    {
        //Creates default TableBase object based on target view/table and Default sorting column
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
            Response.Cookies.Set(cookie);
        }

        if (!Page.IsPostBack)
        {
            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("PurchaseOrderWithEmployees", "PurchID");
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

    }

    //Method used when the page is intially called and loaded
    private void Binding()
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned DataView
        PurchaseOrdersGridView.DataSource = Base.BindGrid();
        //Calls for the page to be updated and a postback
        PurchaseOrdersGridView.DataBind();
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        PurchaseOrdersGridView.DataSource = view;
        //Calls for the page to be updated and a postback
        PurchaseOrdersGridView.DataBind();
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
        PurchaseOrdersGridView.PageIndex = e.NewPageIndex;
        //Calls for the table source to be refreshed with new paging data
        this.Binding(Base.Paging());
    }

    //Method called when searching for given employee name
    protected void NameSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (employeenametxt.Text != "")
        {
            this.Binding(Base.Search("Name LIKE '%" + employeenametxt.Text + "%'"));
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        else
        {
            //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
            this.Binding(Base.Search());
        }
    }

    //Method called when searching with an id of an order
    protected void OrderIDSearch(object sender, EventArgs e)
    {
        //If condition on the case that the textbox being based on isnt empty
        if (orderidxt.Text != "")
        {
            //Search query is sent to the table base class and refreshes the table and also will append P- automatically
            this.Binding(Base.Search("PurchID= 'P-" + orderidxt.Text + "'"));
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        else
        {
            //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
            this.Binding(Base.Search());
        }
    }

    //Method called when using an employee id to search for orders
    protected void EmployeeIDSearch(object sender, EventArgs e)
    {
        if (employeeidtxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            //Search query is sent to the table base class and refreshes the table and also will append E- automatically
            this.Binding(Base.Search("PurchaseOrder.EmployeeID= 'E-" + employeeidtxt.Text + "'"));
        }
        //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        else
        {
            //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
            this.Binding(Base.Search());

        }
    }




    //Used and called when details button is pressed on the gridview
    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Used to see which command on the row is being called
        if (e.CommandName == "Details")
        {
            //converts retrieved command argument to int for index
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow row = PurchaseOrdersGridView.Rows[index];

            //temporary array to store all needed strings for string query 
            string[] squery = { row.Cells[0].Text, row.Cells[2].Text, row.Cells[3].Text, row.Cells[4].Text };
            //appends array strings to be sent to response redirect
            string qstring = "/purchaseorderlines.aspx?purchid=" + squery[0] + "&name=" + squery[1] + "&odate=" + squery[2] + "&ddate=" + squery[3];

            //Redirects and attaches purchid of purchase order to query string
            Response.Redirect(qstring);
        }
        else if (e.CommandName == "ConfDeliv")
        {
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            GridViewRow row = PurchaseOrdersGridView.Rows[index];

            CreateTransactionScope.MakeTransactionScope(String.Format("Update PurchaseOrder SET DateDelivered = '{0}' WHERE PurchID = '{1}'", DateTime.Now, row.Cells[0].Text));
            this.Binding(Base.RefreshTable());
        }
    }

    //Method called when filtering for delivered and/or undelivered items
    protected void ShowDeliver_CheckedChanged(object sender, EventArgs e)
    {
        //Event if both check boxes are checked or empty
        if ((Delivered.Checked && NotDelivered.Checked) || (!Delivered.Checked && !NotDelivered.Checked))
        {
            //Calls the TableBase object's filter method to refresh the datasource and clear the status filter
            this.Binding(Base.FilterClear());
        }
        //Event if only Active items are checked
        else if (Delivered.Checked && !NotDelivered.Checked)
        {
            //Calls the TableBase object's filter method to refresh the datasource and append the status filter
            this.Binding(Base.FilterActive("DateDelivered IS NOT NULL"));
        }
        //Event if only Inactive items are checked
        else if (!Delivered.Checked && NotDelivered.Checked)
        {
            //Calls the TableBase object's filter method to refresh the datasource and append the status filter
            this.Binding(Base.FilterActive("DateDelivered IS NULL"));
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



}