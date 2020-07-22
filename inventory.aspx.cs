using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ItemLookup : System.Web.UI.Page
{
    TableBase Base;  //Empty TableBase class called for built in methods to be avaliable

    //Method used to load and refresh page for postbacks and initializing
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

        if (!Page.IsPostBack) //Detects if this is the first page load or refresh
        {


            foreach (ListItem item in ColumnCheckBoxList.Items)
            {
                item.Selected = true;  //makes all of the checkboxlist items selected by default
            }


            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("ItemsStatusLocation", "SKU");
            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["Table"] = Base;  
            //Initial binding and loading of data onto table
            this.Binding();
        }
        else //All consecutive refreshes/postbacks will update the ViewState key with new recurring data.
        {
            Base = (TableBase)ViewState["Table"];
        }
        ItemLookUpGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
        ItemLookUpGridView.HeaderRow.ControlStyle.CssClass = "thead-dark";

    }
 

    //Method used when the page is intially called and loaded
    private void Binding()
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned DataView
        ItemLookUpGridView.DataSource = Base.BindGrid();
        ItemLookUpGridView.DataBind();  //Calls for the page to be updated and a postback
    }

    //Method used when one of the events on the page is updating the table and query 
    private void Binding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        ItemLookUpGridView.DataSource = view;
        ItemLookUpGridView.DataBind(); //Calls for the page to be updated and a postback
    }


    //Called when trying to sort columns on page.
    protected void ItemLookUp_Sorting(object sender, GridViewSortEventArgs e)
    { 
        this.Binding(Base.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
    }

    //Called when making use of paging on table when more than about 10 items by default
    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)  
    {
        ItemLookUpGridView.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        this.Binding(Base.Paging());  //Calls for the table source to be refreshed with new paging data
    }

    //Method called when using the name search button
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

    //Method called when using the SKU search button
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


    protected void Check_Clicked(object sender, EventArgs e)  //Method called when any member of the checkboxlist is updated and will refresh the table to see if any columns need to be hidden or shown.
    {
        foreach (ListItem item in ColumnCheckBoxList.Items)
        {
            ItemLookUpGridView.Columns[Int32.Parse(item.Value)].Visible = item.Selected;
        }
    }

    //Method called when clearing any status filter
    protected void RadBoth_CheckedChanged(object sender, EventArgs e)
    {
        this.Binding(Base.FilterClear());//Calls the TableBase object's filter method to refresh the datasource and clear the status filter
    }

    //Method called when choosing status filter for active
    protected void RadActive_CheckedChanged(object sender, EventArgs e)
    {
        this.Binding(Base.FilterActive("Status = 'A'"));  //Calls the TableBase object's filter method to refresh the datasource and append the status filter
    }

    //Method called when choosing status filter for inactive
    protected void RadInactive_CheckedChanged(object sender, EventArgs e)
    {
        this.Binding(Base.FilterActive("Status = 'I'")); //Calls the TableBase object's filter method to refresh the datasource and append the status filter
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