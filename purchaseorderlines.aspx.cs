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
            Response.Cookies.Set(cookie);
        }

        if (!Page.IsPostBack) //Detects if this is the first page load or refresh
        {


            string purchid = Request.QueryString["purchid"];  //Grabs the id attached to query string after redirect from purchaseorders page

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
        else //All consecutive refreshes/postbacks will update the ViewState key with new recurring data.
        {
            Base = (TableBase)ViewState["Table"];
        }

    }


    //Method used when the page is intially called and loaded
    private void Binding()
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned DataView
        PurchaseOrderLinesGridView.DataSource = Base.BindGrid();
        PurchaseOrderLinesGridView.DataBind();  //Calls for the page to be updated and a postback
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        PurchaseOrderLinesGridView.DataSource = view;
        PurchaseOrderLinesGridView.DataBind(); //Calls for the page to be updated and a postback
    }



    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  //Called when trying to sort columns on page.    ISSUE: Undoes the search query need to fix
    {
        this.Binding(Base.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  //Called when making use of paging on table when more than about 10 items by default
    {
        PurchaseOrderLinesGridView.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        this.Binding(Base.Paging());  //Calls for the table source to be refreshed with new paging data
    }

    protected void NameSearch(object sender, EventArgs e)
    {
        if (itemnametxt.Text != "") //Checks to see if the itemnametxt textbox is an empty string
        {
            this.Binding(Base.Search("ItemName LIKE '%" + itemnametxt.Text + "%'")); //if string is not empty it will create a new statement to append to the where clause using the itemname column and call for a datasource refresh from the TableBase object
        }
        else
        {
            this.Binding(Base.Search()); //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
        }
    }

    //Method called when searching for SKU of item
    protected void SKUSearch(object sender, EventArgs e)
    {
        if (skutxt.Text != "") //Checks to see if the skutxt textbox is an empty string
        {
            this.Binding(Base.Search("SKU= 'I-" + skutxt.Text + "'")); //if string is not empty it will create a new statement to append to the where clause using the SKU table and call for a datasource refresh from the TableBase object
        }
        else
        {
            this.Binding(Base.Search());//if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
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