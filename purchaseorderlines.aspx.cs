using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class purchaseorderlines : System.Web.UI.Page
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
            Response.Cookies.Set(cookie);
        }
        //Detects if this is the first page load or refresh
        if (!Page.IsPostBack) 
        {

            //Grabs the id attached to query string after redirect from purchaseorders page
            string purchid = Request.QueryString["purchid"];  

            //Labels give basic overall information of purchase order using query string
            LabOrderID.Text = purchid;
            LabOrderer.Text = Request.QueryString["name"];
            LabODate.Text = Request.QueryString["odate"];
            LabDDate.Text = Request.QueryString["ddate"];


            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("PurchasePriceLine ", "SKU");
            this.Binding(Base.Search("PurchID = '" + purchid + "' "));
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
        PurchaseOrderLinesGridView.DataSource = Base.BindGrid();
        //Calls for the page to be updated and a postback
        PurchaseOrderLinesGridView.DataBind();  
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        PurchaseOrderLinesGridView.DataSource = view;
        //Calls for the page to be updated and a postback
        PurchaseOrderLinesGridView.DataBind(); 
    }


    //Method called when trying to sort columns on page.  
    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)   
    {
        //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
        this.Binding(Base.Sorting(e));  
    }

    //Called when making use of paging on table when more than about 10 items by default
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  
    {
        //The current paging index that has been selected gets changed to the new index
        PurchaseOrderLinesGridView.PageIndex = e.NewPageIndex;
        //Calls for the table source to be refreshed with new paging data
        this.Binding(Base.Paging());  
    }

    //Method called when searching with a name for an employee
    protected void NameSearch(object sender, EventArgs e)
    {
        //Checks to see if the itemnametxt textbox is an empty string
        if (itemnametxt.Text != "") 
        {
            //if string is not empty it will create a new statement to append to the where clause using the itemname column and call for a datasource refresh from the TableBase object
            this.Binding(Base.Search("ItemName LIKE '%" + itemnametxt.Text + "%'")); 
        }
        else
        {
            //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
            this.Binding(Base.Search()); 
        }
    }

    //Method called when searching for with an SKU of an item
    protected void SKUSearch(object sender, EventArgs e)
    {
        //Checks to see if the skutxt textbox is an empty string
        if (skutxt.Text != "") 
        {
            //if string is not empty it will create a new statement to append to the where clause using the SKU table and call for a datasource refresh from the TableBase object
            this.Binding(Base.Search("SKU= 'I-" + skutxt.Text + "'")); 
        }
        else
        {
            //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
            this.Binding(Base.Search());
        }
    }

    //Method called when pressing the logout button on the header will log out the user and send them to the login page
    protected void logoutLink_Click(object sender, EventArgs e)
    {
        //Method called when pressing the logout button on the header will log out the user and send them to the login page
        if (Request.Cookies["userInfo"] != null)
        {
            Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(-1);
        }
        Response.Redirect("login.aspx", false);
    }

}