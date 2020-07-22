using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class purchaseorders : System.Web.UI.Page
{
    TableBase Base;  //Empty TableBase class called for built in methods to be avaliable
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("PurchaseOrderWithEmployees", "PurchID");
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
        PurchaseOrdersGridView.DataSource = Base.BindGrid();
        PurchaseOrdersGridView.DataBind();  //Calls for the page to be updated and a postback
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        PurchaseOrdersGridView.DataSource = view;
        PurchaseOrdersGridView.DataBind(); //Calls for the page to be updated and a postback
    }



    

    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)  //Called when trying to sort columns on page.
    {
        this.Binding(Base.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  //Called when making use of paging on table when more than about 10 items by default
    {
        PurchaseOrdersGridView.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        this.Binding(Base.Paging());  //Calls for the table source to be refreshed with new paging data
    }

    //Method called when searching for given employee name
    protected void NameSearch(object sender, EventArgs e)
    {
        if (employeenametxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search("Name LIKE '%" + employeenametxt.Text + "%'")); 
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting
        {
            this.Binding(Base.Search()); //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
        }
    }

    //Method called when searching with an id of an order
    protected void OrderIDSearch(object sender, EventArgs e)
    {
        if (orderidxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search("PurchID= 'P-" + orderidxt.Text + "'"));  //Automatically will have the characters P- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            this.Binding(Base.Search()); //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
        }
    }

    //Method called when using an employee id to search for orders
    protected void EmployeeIDSearch(object sender, EventArgs e)
    {
        if (employeeidtxt.Text != "")  //If condition on the case that the textbox being based on isnt empty
        {
            this.Binding(Base.Search("PurchaseOrder.EmployeeID= 'E-" + employeeidtxt.Text + "'"));  //Automatically will have the characters E- for convience
        }
        else  //If the textbox is empty and the submit button is pressed it just refreshes the table. also sends true statement in order to prevent sorting.
        {
            this.Binding(Base.Search()); //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object

        }
    }




    //Used and called when details button is pressed on the gridview
    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Details") return;  //Checks to make sure command name matches

        int index = Convert.ToInt32(e.CommandArgument.ToString()); //converts retrieved command argument to int for index
        GridViewRow row = PurchaseOrdersGridView.Rows[index];


        string[] squery = { row.Cells[0].Text, row.Cells[2].Text, row.Cells[3].Text, row.Cells[4].Text };  //temporary array to store all needed strings for string query 

        string qstring = "/purchaseorderlines.aspx?purchid=" + squery[0] + "&name=" + squery[1] + "&odate=" + squery[2] + "&ddate=" + squery[3];  //appends array strings to be sent to response redirect


        Response.Redirect(qstring);  //Redirects and attaches purchid of purchase order to query string
    }

    //radio button check section
    protected void RadBoth_CheckedChanged(object sender, EventArgs e) //Clears radio button filter and shows both delivered and undelivered
    {
        this.Binding(Base.FilterClear());
    }

    protected void RadDel_CheckedChanged(object sender, EventArgs e) //Activates filter to show only delivered orders
    {
        this.Binding(Base.FilterActive("DateDelivered IS NOT NULL"));
    }

    protected void RadNotDel_CheckedChanged(object sender, EventArgs e) //Activates filter to show only orders not delivered
    {
        this.Binding(Base.FilterActive("DateDelivered IS NULL"));
    }
}