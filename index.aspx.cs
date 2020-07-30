using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    TableBase Base;  //Empty TableBase class called for built in methods to be avaliable

    TableBase BaseItem; //Tablebase used for the item/top gridview
                        //TableBase BaseOrder; //Tablebased used for the purchaseorder/bottom gridview

    DataTable dt;

    string[] itemSKU = new string[4]; //Used to store the selected item
    string orderSKU;
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
            DropDownPop();
            //Creates default TableBase object based on target view/table and Default sorting column
            Base = new TableBase("RecentPurchaseOrders", "DateOrdered");
            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["Table"] = Base;
            //Initial binding and loading of data onto table
            this.Binding();

            //Creates default TableBase object based on target view/table and Default sorting column
            BaseItem = new TableBase("AddItem", "SKU");

            //Binds the default data to ViewState in order to keep throughout postbacks
            ViewState["ItemTable"] = BaseItem;

            //New Mepty datatable is created to store data of temporary purchase order
            dt = new DataTable();
            //Columns are added to new datatable with appropriate names
            dt.Columns.AddRange(new DataColumn[5] { new DataColumn("SKU", typeof(string)), new DataColumn("ItemName", typeof(string)), new DataColumn("SupplierID", typeof(string)), new DataColumn("Quantity", typeof(int)), new DataColumn("Price", typeof(decimal)) });


            ViewState["ordertable"] = dt;

            //Initial binding and loading of data onto table
            GridViewItem.DataSource = BaseItem.BindGrid();
            GridViewItem.DataBind();
            OrderBinding();

            ModalIDPop();
        }
        else //All consecutive refreshes/postbacks will update the ViewState key with new recurring data.
        {
            Base = (TableBase)ViewState["Table"];

            BaseItem = (TableBase)ViewState["ItemTable"];
            //BaseOrder = (TableBase)ViewState["OrderTable"];
            dt = ViewState["ordertable"] as DataTable;
            OrderBinding();

            if (GridViewItem.SelectedRow != null) //Checks to see if there are any selected rows during a postback
            {
                AddItemButton.Enabled = true;

            }
            else
            {
                AddItemButton.Enabled = false;
            }
        }
        TotalPrice();
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

        if (itemSKUTxt.Text != "" && itemNameTxt.Text != "" && itemQTYTxt.Text != "" && itemQOHTxt.Text != "" && itemPriceTxt.Text != "")
        {


            if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec ItemModal @Action = 'Insert', @SKU = 'I-{0}', @Name = '{1}', @Quantity = '{2}', @OnHand = '{3}', @Price = '{4}', @SupplierID = '{5}', @EmployeeID = '{6}', @Comments = '{7}'"
                , itemSKUTxt.Text, itemNameTxt.Text, itemQTYTxt.Text, itemQOHTxt.Text, itemPriceTxt.Text, DropDownListsupplier.SelectedValue, Request.Cookies["userInfo"]["emplID"], itemCommentsTxt.Text)) > 0) //Sends isnert statement to add new item and also checks to see if it was successfully added or not
            {
                itemstatuslabel.Text = "Item successfully added";
                itemstatuslabel.Visible = true;
            }
            else
            {
                itemstatuslabel.Text = "Item could not be added";
                itemstatuslabel.Visible = true;
            }

        }
        else
        {
            itemstatuslabel.Text = "One or more fields are incomplete or incorrect";
            itemstatuslabel.Visible = true;
        }

    }



    protected void createEmployeeButton_Click(object sender, EventArgs e)
    {

        if (efirsttxt.Text != "" && elasttxt.Text != "" && emailtxt.Text != "" && passwordtxt.Text != "" && tempassconftxt.Text != "" && (passwordtxt.Text.Equals(tempassconftxt.Text)))
        {
            string admin = "0";
            string eid = ""; //default value if no previous items are in the 
            try
            {


                SqlConnection con = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
                con.Open();

                SqlCommand com = new SqlCommand("SELECT MAX(EmployeeID) FROM Employees", con); // table name 
                SqlDataAdapter da = new SqlDataAdapter(com);
                SqlDataReader empRecord = com.ExecuteReader();
                if (empRecord.Read())
                {
                    eid = (string)empRecord[0];

                    if (eid != "")
                    {

                        int skunum = Int32.Parse(eid.Substring(eid.LastIndexOf('-') + 1)) + 1;
                        eid = "E-" + string.Format("{0:0000}", skunum);
                    }
                    else
                    {
                        eid = "E-0001";
                    }
                }
                con.Close();
            }
            catch (SqlException exception)
            {
                // errorLabel.Visible = true;
                // errorLabel.Text = "An unknown error occurred, please try again later.";
            }

            if (yesToggle.Checked)
            {
                admin = "1";
            }

            if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec EmployeeModal @Action = 'Insert', @EmployeeID = '{0}', @FirstName ='{1}', @LastName = '{2}', @Admin = '{3}', @DepartmentID = '{4}', @Pass = '{5}', @LastLogged = '{6}'"
                , eid, efirsttxt.Text, elasttxt.Text, admin, DropDownListDep.SelectedValue, ComputeSha256Hash(passwordtxt.Text), DateTime.Now)) > 0)
            {
                employeestatuslabel.Text = "Employee successfully added";
                employeestatuslabel.Visible = true;
            }
            else
            {
                employeestatuslabel.Text = "Employee could not be added";
                employeestatuslabel.Visible = true;
            }
        }
        else
        {
            employeestatuslabel.Text = "One or more fields are incomplete or incorrect";
            employeestatuslabel.Visible = true;
        }

    }



    protected void createDepartmentButton_Click(object sender, EventArgs e)
    {
        if (depIDTxt.Text != "" && depNameTxt.Text != "")
        {

            if (CreateTransactionScope.MakeTransactionScope("EXEC DepartmentModal @Action = 'Insert', @ID ='" + depIDTxt.Text + "', @Name = '" + depNameTxt + "'") > 0)
            {
                departmentstatuslabel.Text = "Department successfully added";
                departmentstatuslabel.Visible = true;
            }
            else
            {
                departmentstatuslabel.Text = "Department could not be added";
                departmentstatuslabel.Visible = true;
            }
        }
        else
        {
            departmentstatuslabel.Text = "One or more fields are incomplete or incorrect";
            departmentstatuslabel.Visible = true;
        }
    }




    //Method used when one of the events on the page is updating the table and query 
    private void ItemBinding(DataView view)
    {
        //Sets the datasource of the webpage's Gridview to the TableBase object's returned Dataview from event methods.
        GridViewItem.DataSource = view;
        GridViewItem.DataBind(); //Calls for the page to be updated and a postback

    }

    private void OrderBinding()
    {

        GridViewOrder.DataSource = dt;
        GridViewOrder.DataBind();
    }



    //Activated when using the select button on a column and will store the SKU of the row also changes the selected row's style to light blue
    protected void GridViewItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        itemSKU[0] = GridViewItem.SelectedRow.Cells[1].Text;
        itemSKU[1] = GridViewItem.SelectedRow.Cells[2].Text;
        itemSKU[2] = GridViewItem.SelectedRow.Cells[3].Text;
        itemSKU[3] = GridViewItem.SelectedRow.Cells[5].Text;

        ViewState["selectedrow"] = itemSKU;
        AddItemButton.Enabled = true;

    }

    protected void GridViewItem_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewItem.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
        this.ItemBinding(BaseItem.Paging());  //Calls for the table source to be refreshed with new paging data
    }

    protected void GridViewItem_Sorting(object sender, GridViewSortEventArgs e)
    {
        this.ItemBinding(BaseItem.Sorting(e));  //Method calls for the binding method and creates a new Datasource for the table to be based around the requested sorting
    }

    //Search for item with either SKU or Name
    protected void Search_Click(object sender, EventArgs e)
    {
        if (SearchText.Text != "") //Checks to see if the itemnametxt textbox is an empty string
        {
            if (SearchText.Text.Contains("I-"))
            {
                this.ItemBinding(BaseItem.Search("SKU = '" + SearchText.Text + "'"));
            }
            else
            {
                this.ItemBinding(BaseItem.Search("ItemName LIKE '%" + SearchText.Text + "%'")); //if string is not empty it will create a new statement to append to the where clause using the itemname column and call for a datasource refresh from the TableBase object
            }

        }
        else
        {
            this.ItemBinding(BaseItem.Search()); //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
        }
    }
    //Adds selected item to purchase order table along with quantity
    protected void AddItemButton_Click(object sender, EventArgs e)
    {
        DataTable dt = ViewState["ordertable"] as DataTable;
        itemSKU = ViewState["selectedrow"] as string[];

        if (QuantityText.Text != "" && QuantityText.Text.All(char.IsDigit) && QuantityText.Text != "0") //Checks to make sure the quantity text is not empty or not a int
        {
            DataRow newrow = dt.NewRow();
            newrow[0] = itemSKU[0];
            newrow[1] = itemSKU[1];
            newrow[2] = itemSKU[2];
            newrow[3] = Int32.Parse(QuantityText.Text);
            newrow[4] = Decimal.Parse(itemSKU[3]);
            dt.Rows.Add(newrow);

            ViewState["ordertable"] = dt;

            GridViewItem.SelectedIndex = -1;
            OrderBinding();
            AddItemButton.Enabled = false;
            OrderButtons();
            TotalPrice();
        }



    }




    //Section for PurchaseOrder (bottom)






    //Used to pass the data from the selected column
    protected void GridViewOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        orderSKU = GridViewOrder.SelectedRow.Cells[1].Text;

        ViewState["selectedorder"] = orderSKU;


        OrderButtons();
    }

    //Used for paging
    protected void GridViewOrder_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewOrder.PageIndex = e.NewPageIndex;  //The current paging index that has been selected gets changed to the new index
                                                   //this.OrderBinding(BaseOrder.Paging());  //Calls for the table source to be refreshed with new paging data
    }





    protected void GridViewOrder_Sorting(object sender, GridViewSortEventArgs e)
    {

        dt = ViewState["ordertable"] as DataTable;
        DataView dv = dt.DefaultView;

        string strSortOrder = "";
        if (ViewState["SortOrder"] == null)
        {
            ViewState["SortOrder"] = "asc";
        }
        if (ViewState["SortOrder"].ToString() == "asc")
        {
            ViewState["SortOrder"] = "desc";
            strSortOrder = "desc";
        }
        else if (ViewState["SortOrder"].ToString() == "desc")
        {
            ViewState["SortOrder"] = "asc";
            strSortOrder = "asc";
        }

        dv.Sort = e.SortExpression + " " + strSortOrder;
        dt = dv.ToTable();
        ViewState["ordertable"] = dt;

        OrderBinding();

    }

    //Deletes individual selected item
    protected void DeleteBtn_Click(object sender, EventArgs e)
    {
        orderSKU = ViewState["selectedorder"].ToString();

        foreach (DataRow row in dt.Rows)
        {
            if (row["SKU"].ToString().Equals(orderSKU))
            {
                dt.Rows.Remove(row);
                break;
            }
        }

        ViewState["ordertable"] = dt;
        GridViewOrder.SelectedIndex = -1; //Clears selected row once completed
        OrderBinding();
        TotalPrice();
        OrderButtons();
    }

    //Clears entire bottom table
    protected void DeleteAllBtn_Click(object sender, EventArgs e)
    {

        dt.Rows.Clear();
        ViewState["ordertable"] = dt;
        OrderBinding();
        TotalPrice();
        OrderButtons();
        GridViewOrder.SelectedIndex = -1; //Clears selected row once completed
    }

    protected void CreatePOButton_Click(object sender, EventArgs e)
    {

        //Transaction scope here
    }


    //Used to calculate the rough total price
    protected void TotalPrice()
    {


        if (dt.Rows.Count != 0)
        {


            TotalLabel.Text = "Total Price: " + (Convert.ToDecimal(dt.Compute("SUM(Price)", string.Empty)) * Convert.ToDecimal(dt.Compute("SUM(Quantity)", string.Empty))).ToString();
        }
        else
        {
            TotalLabel.Text = "Total Price: 0.0";
        }

    }

    protected void OrderButtons()
    {
        if (dt != null && dt.Rows.Count > 0 && GridViewOrder.SelectedIndex != -1) //checks to see if the bottom grid has any rows or is empty
        {
            DeleteBtn.Enabled = true;

            CreatePOButton.Enabled = true;

        }
        else
        {
            DeleteBtn.Enabled = false;
            CreatePOButton.Enabled = false;
        }

        if (dt != null && dt.Rows.Count > 0)
        {
            DeleteAllBtn.Enabled = true;
        }
        else
        {
            DeleteAllBtn.Enabled = false;
        }

        TotalPrice();

    }


    protected void DropDownPop()
    {

        try
        {

            SqlConnection con = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
            con.Open();

            SqlCommand com = new SqlCommand("select SupplierName, SupplierID from Suppliers", con); // table name 
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);  // fill dataset
            DropDownListsupplier.DataTextField = ds.Tables[0].Columns["SupplierName"].ToString(); // text field name of table dispalyed in dropdown
            DropDownListsupplier.DataValueField = ds.Tables[0].Columns["SupplierID"].ToString();             // to retrive specific  textfield name 
            DropDownListsupplier.DataSource = ds.Tables[0];      //assigning datasource to the dropdownlist
            DropDownListsupplier.DataBind();  //binding dropdownlist




            com = new SqlCommand("select * from Departments", con); // table name 
            da = new SqlDataAdapter(com);
            ds = new DataSet();
            da.Fill(ds);  // fill dataset
            DropDownListDep.DataTextField = ds.Tables[0].Columns["DepartmentName"].ToString(); // text field name of table dispalyed in dropdown
            DropDownListDep.DataValueField = ds.Tables[0].Columns["DepartmentID"].ToString();             // to retrive specific  textfield name 
            DropDownListDep.DataSource = ds.Tables[0];      //assigning datasource to the dropdownlist
            DropDownListDep.DataBind();  //binding dropdownlist
            con.Close();
        }
        catch (SqlException exception)
        {
            // errorLabel.Visible = true;
            // errorLabel.Text = "An unknown error occurred, please try again later.";
        }

    }

    protected void ModalIDPop()
    {
        string isku = ""; //default value if no previous items are in the 
        try
        {


            SqlConnection con = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
            con.Open();

            SqlCommand com = new SqlCommand("SELECT MAX(SKU) FROM Items", con); // table name 
            SqlDataAdapter da = new SqlDataAdapter(com);
            SqlDataReader empRecord = com.ExecuteReader();
            if (empRecord.Read())
            {
                isku = (string)empRecord[0];

                if (isku != "")
                {

                    int skunum = Int32.Parse(isku.Substring(isku.LastIndexOf('-') + 1)) + 1;
                    string value = string.Format("{0:000}", skunum);
                    itemSKUTxt.Text = value;
                }
                else
                {
                    itemSKUTxt.Text = "001";
                }
            }
            empRecord.Close();


            string did = ""; //default value if no previous items are in the 



            com = new SqlCommand("SELECT MAX(DepartmentID) FROM Departments", con); // table name 
            da = new SqlDataAdapter(com);
            empRecord = com.ExecuteReader();
            if (empRecord.Read())
            {
                did = (string)empRecord[0];

                if (did != "")
                {

                    int skunum = Int32.Parse(did.Substring(did.LastIndexOf('-') + 1)) + 1;
                    string value = string.Format("{0:000}", skunum);
                    depIDTxt.Text = value;
                }
                else
                {
                    depIDTxt.Text = "001";
                }
            }



            con.Close();
        }
        catch (SqlException exception)
        {
            // errorLabel.Visible = true;
            // errorLabel.Text = "An unknown error occurred, please try again later.";
        }
    }

    //Computes the hash based on the given password
    protected static string ComputeSha256Hash(string rawData)
    {
        // Create a SHA256
        using (SHA256Managed sha256ManagedHash = new SHA256Managed())
        {
            // ComputeHash - returns byte array
            byte[] bytes = sha256ManagedHash.ComputeHash(Encoding.UTF8.GetBytes(rawData));

            // Convert byte array to a string
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }
            return builder.ToString();
        }
    }
}