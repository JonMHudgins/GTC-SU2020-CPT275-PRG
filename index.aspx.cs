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
            if(Request.Cookies["userInfo"]["admin"] == "True")  //Checks to see if the user is an admin or not and enables related department and employee items to be shown
            {
                addEmployeeModal.Visible = true;
                addDepartmentModal.Visible = true;
                departmentnav.Visible = true;
                employeenav.Visible = true;
                blockopenemployees.Visible = true;
                opendepartmodal.Visible = true;
                openemployeemodal.Visible = true;
            }
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
            string sid = DropDownListsupplier.SelectedValue;
            if(sid == "--New Supplier--")
            {
                string[] suppinfo = new string[4];
                sid = "S-001";

                try
                {


                    SqlConnection con = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
                    con.Open();

                    SqlCommand com = new SqlCommand("SELECT MAX(SupplierID) FROM Suppliers", con); // table name 
                    SqlDataAdapter da = new SqlDataAdapter(com);
                    SqlDataReader empRecord = com.ExecuteReader();
                    if (empRecord.Read())
                    {
                        sid = (string)empRecord[0];

                        if (sid != "")
                        {

                            int skunum = Int32.Parse(sid.Substring(sid.LastIndexOf('-') + 1)) + 1;
                            sid = "S-" + string.Format("{0:000}", skunum);
                        }
                        else
                        {
                            sid = "S-001";
                        }
                    }
                    con.Close();
                }
                catch(SqlException ex)
                {
                    itemstatuslabel.Text = "Supplier could not be added";
                    itemstatuslabel.Visible = true;
                }
                //Block used to set up string array for inserting new supplier into database and allows for empty phone and name texts
                if ((supEmailTxt.Text == "" || EmailRegexValid.IsValid) && (supPhoneTxt.Text == "" || PhoneRegexValid.IsValid))
                {

                    suppinfo[0] = sid;
                    suppinfo[1] = supNameTxt.Text;
                    suppinfo[2] = supPhoneTxt.Text != "" ? "'" + supPhoneTxt.Text + "'" : "NULL";
                    suppinfo[3] = supEmailTxt.Text != "" ? "'" + supEmailTxt.Text + "'" : "NULL";
                    if (!(supNameTxt.Text != "" && CreateTransactionScope.MakeTransactionScope(String.Format("Insert Into Suppliers VALUES ('{0}', '{1}', {2}, {3})", suppinfo[0], suppinfo[1], suppinfo[2], suppinfo[3])) > 0))
                    {
                        itemstatuslabel.Text = "Supplier could not be added";
                        itemstatuslabel.Visible = true;
                        return;
                    }
                }
                else
                {
                    itemstatuslabel.Text = "Supplier could not be added";
                    itemstatuslabel.Visible = true;
                    return;
                }
                            
                            
            }

            if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec ItemModal @Action = 'Insert', @SKU = 'I-{0}', @Name = '{1}', @Quantity = '{2}', @OnHand = '{3}', @Price = '{4}', @SupplierID = '{5}', @EmployeeID = '{6}', @Comments = '{7}'"
                , itemSKUTxt.Text, itemNameTxt.Text, itemQTYTxt.Text, itemQOHTxt.Text, itemPriceTxt.Text, sid, Request.Cookies["userInfo"]["emplID"], itemCommentsTxt.Text)) > 0) //Sends isnert statement to add new item and also checks to see if it was successfully added or not
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

            if (CreateTransactionScope.MakeTransactionScope(String.Format("Exec EmployeeModal @Action = 'Insert', @EmployeeID = '{0}', @FirstName ='{1}', @LastName = '{2}', @Admin = '{3}', @DepartmentID = '{4}', @Pass = '{5}', @LastLogged = '{6}', @Email = '{7}'"
                , eid, efirsttxt.Text, elasttxt.Text, admin, DropDownListDep.SelectedValue, ComputeSha256Hash(passwordtxt.Text), DateTime.Now, emailtxt.Text)) > 0)
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


    // Method called when pressing the create department button on the modal
    protected void createDepartmentButton_Click(object sender, EventArgs e)
    {
        if (depIDTxt.Text != "" && depNameTxt.Text != "")
        {

            if (CreateTransactionScope.MakeTransactionScope("EXEC DepartmentModal @Action = 'Insert', @ID ='D-" + depIDTxt.Text + "', @Name = '" + depNameTxt.Text + "'") > 0)
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
        //Calls for the page to be updated and a postback
        GridViewItem.DataBind(); 

    }

    //Method used for the bottom gridview for creating a new purchase order
    private void OrderBinding()
    {
        //Sets the datasource to be the data table that is stored in the view state
        GridViewOrder.DataSource = dt;
        //Calls for the page to be updated and a postback
        GridViewOrder.DataBind();
    }



    //Activated when using the select button on a column and will store the SKU of the row also changes the selected row's style to light blue
    protected void GridViewItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Grabs all the data from the selected row that is needed
        itemSKU[0] = GridViewItem.SelectedRow.Cells[1].Text;
        itemSKU[1] = GridViewItem.SelectedRow.Cells[2].Text;
        itemSKU[2] = GridViewItem.SelectedRow.Cells[3].Text;
        itemSKU[3] = GridViewItem.SelectedRow.Cells[5].Text;

        //stores the selected row in the Viewstate
        ViewState["selectedrow"] = itemSKU;

        //sets the datatable to be equal to the last viewstate version
        dt = ViewState["ordertable"] as DataTable;

        //Loops to check and make sure the current selected item isnt already in the bottom table
        foreach (DataRow row in dt.Rows)
        {
            if (itemSKU[0].Equals(row["SKU"].ToString()))
            {
                POstatuslbl.Text = "Cannot add duplicate item to order";
                POstatuslbl.Visible = true;
                return;
            }
            else
            {
                POstatuslbl.Visible = false;
            }
        }

        AddItemButton.Enabled = true;

    }

    protected void GridViewItem_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewItem.SelectedIndex = -1;
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
        //Checks to see if the itemnametxt textbox is an empty string
        if (SearchText.Text != "") 
        {
            if (SearchText.Text.Contains("I-"))
            {
                this.ItemBinding(BaseItem.Search("SKU = '" + SearchText.Text + "'"));
            }
            else
            {
                //if string is not empty it will create a new statement to append to the where clause using the itemname column and call for a datasource refresh from the TableBase object
                this.ItemBinding(BaseItem.Search("ItemName LIKE '%" + SearchText.Text + "%'")); 
            }

        }
        else
        {
            //if string is empty it will clear any current where clauses besides any filters and call for a datasoruce refresh with the TableBase object
            this.ItemBinding(BaseItem.Search()); 
        }
    }
    //Adds selected item to purchase order table along with quantity
    protected void AddItemButton_Click(object sender, EventArgs e)
    {
        DataTable dt = ViewState["ordertable"] as DataTable;
        itemSKU = ViewState["selectedrow"] as string[];

        //Checks to make sure the quantity text is not empty or not a int
        if (QuantityText.Text != "" && QuantityText.Text.All(char.IsDigit) && QuantityText.Text != "0") 
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

    //Method called when sorting the botttom grid in the purchase order 
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
        dt = ViewState["ordertable"] as DataTable;
        //Transaction scope here
        if (dt != null && dt.Rows.Count > 0) //checks to see if the bottom grid has any rows or is empty
        {
            string pid = "P-001";

            try
            {


                SqlConnection con = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
                con.Open();

                SqlCommand com = new SqlCommand("SELECT MAX(PurchID) FROM PurchaseOrder", con); // table name 
                SqlDataAdapter da = new SqlDataAdapter(com);
                SqlDataReader empRecord = com.ExecuteReader();
                if (empRecord.Read())
                {
                    pid = (string)empRecord[0];

                    if (pid != "")
                    {

                        int skunum = Int32.Parse(pid.Substring(pid.LastIndexOf('-') + 1)) + 1;
                        pid = "P-" + string.Format("{0:000}", skunum);
                    }
                    else
                    {
                        pid = "P-001";
                    }
                }
                con.Close();


                //Attempts to create new purchase order with automatic id and if it can't it gives a warning instead
                if (CreateTransactionScope.MakeTransactionScope(string.Format("EXEC PurchaseOrderModal @Action = 'Insert', @PurchaseID = '{0}', @EmployeeID = '{1}'", pid, Request.Cookies["userInfo"]["emplID"])) > 0)
                {
                    using (var bulkCopy = new SqlBulkCopy(ConnectionString.GetConnectionString("invDBConStr"), SqlBulkCopyOptions.KeepIdentity))
                    {

                        DataTable copyDT;
                        copyDT = dt.Copy();
                        copyDT.Columns.Remove("SupplierID");
                        copyDT.Columns.Remove("Price");
                        copyDT.Columns.Remove("ItemName");
                        copyDT.Columns["Quantity"].ColumnName = "OrdQuantity";
                        DataColumn newcol = new DataColumn("PurchID", typeof(System.String))
                        {
                            DefaultValue = pid
                        };
                        copyDT.Columns.Add(newcol);
                        
                       
                        
                        foreach(DataColumn col in copyDT.Columns)
                        {

                            bulkCopy.ColumnMappings.Add(col.ColumnName, col.ColumnName);
                            
                        }
                        bulkCopy.BulkCopyTimeout = 300;
                        bulkCopy.DestinationTableName = "PurchaseOrderLine";
                        bulkCopy.WriteToServer(copyDT);

                        POstatuslbl.Text = "Purchase order successfully added";
                        POstatuslbl.Visible = true;

                    }
                }
                else
                {
                    POstatuslbl.Text = "Purchase order could not be made";
                    POstatuslbl.Visible = true;
                }
                
            }

            catch (SqlException exception)
            {
                POstatuslbl.Text = "Purchase order could not be made";
                POstatuslbl.Visible = true;
            }
        }
        else
        {
            POstatuslbl.Text = "Purchase order could not be made";
            POstatuslbl.Visible = true;
        }


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

            //CreatePOButton.Enabled = true;

        }
        else
        {
            DeleteBtn.Enabled = false;
            //CreatePOButton.Enabled = false;
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

    //Method used to populate all dropdown lists in the modals
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
            DropDownListsupplier.Items.Add(new ListItem("--New Supplier--", "--New Supplier--"));


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
            
        }

    }

    //Method used to populate default new id's in the modals
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


            string did = ""; //default value if no previous items are in the database



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

    //Method called when drop down list in the supplier modal is changed and triggers the new supplier panel to be visible
    protected void DropDownListsupplier_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(DropDownListsupplier.SelectedValue == "--New Supplier--")
        {
            NSupPanel.Visible = true;
        }
        else
        {
            NSupPanel.Visible = false;
        }
    }
}