using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public partial class index : System.Web.UI.Page
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
      //Creates default TableBase object based on target view/table and Default sorting column
      Base = new TableBase("RecentPurchaseOrders", "DateOrdered");
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
    IndexGridView.DataSource = Base.BindGrid();
    IndexGridView.DataBind();  //Calls for the page to be updated and a postback
  }

  //Used and called when details button is pressed on the gridview
  protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
  {
    if (e.CommandName != "Details") return;  //Checks to make sure command name matches

    int index = Convert.ToInt32(e.CommandArgument.ToString()); //converts retrieved command argument to int for index
    GridViewRow row = IndexGridView.Rows[index];

    string[] squery = new string[4]; //temporary array to store all needed strings for string query 
    SqlConnection dbConnection = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr")); //Creates new database connection to retrieve extra information not provided in view
    try
    {
      dbConnection.Open();
      dbConnection.ChangeDatabase("jhudgins6768_SeniorProject");
      string SQLString = "SELECT * FROM PurchaseOrderWithEmployees WHERE purchid = '" + row.Cells[1].Text + "'"; //select statement that will be sent to database
      SqlCommand logCommand = new SqlCommand(SQLString, dbConnection);
      SqlDataReader empRecord = logCommand.ExecuteReader(); //Reads the generated table with given purchaseid
      if (empRecord.Read())
      {
        //Fills in string array with retrieved data
        squery[0] = (string)empRecord["PurchID"];
        squery[1] = (string)empRecord["Name"];
        squery[2] = Convert.ToDateTime(empRecord["DateOrdered"]).ToString("MM/dd/yyyy");
        squery[3] = Convert.ToDateTime(empRecord["DateDelivered"]).ToString("MM/dd/yyyy");
      }
      dbConnection.Close();
    }
    catch (Exception ex)
    {
      Console.WriteLine(ex.ToString());
    }

    string qstring = "/purchaseorderlines.aspx?purchid=" + squery[0] + "&name=" + squery[1] + "&odate=" + squery[2] + "&ddate=" + squery[3];  //appends array strings to be sent to response redirect


    Response.Redirect(qstring);  //Redirects and attaches purchid of purchase order to query string
  }

  protected void logoutLink_Click(object sender, EventArgs e)
  {

    if (Request.Cookies["userInfo"] != null)
    {
      Response.Cookies["userInfo"].Expires = DateTime.Now.AddDays(-1);
    }
    Response.Redirect("login.aspx", false);
  }

  protected void createItemButton_Click(object sender, EventArgs e)
  {
    Console.WriteLine("Testing");
  }

  protected void cancelItemButton_Click(object sender, EventArgs e)
  {
    Console.WriteLine("Testing");
  }

  protected void createDepartmentButton_Click(object sender, EventArgs e)
  {
    Console.WriteLine("Testing");
  }

  protected void cancelDepartmentButton_Click(object sender, EventArgs e)
  {
    Console.WriteLine("Testing");
  }
}