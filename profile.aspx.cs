using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

public partial class profile : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)  //Checks to see if this is first loading the page or a refresh
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
                //Checks to see if the user is an admin or not and enables related department and employee items to be shown
                if (Request.Cookies["userInfo"]["admin"] == "True")
                {
                    departmentnav.Visible = true;
                    employeenav.Visible = true;
                }
                Response.Cookies.Set(cookie);
            }
            SqlConnection dbConnection = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
            try
            {
                dbConnection.Open();
                string SQLString = "SELECT  Email, Phone, HomeAddress, City, ZIP, State FROM Employees WHERE EmployeeID = '" + cookie["emplID"] + "'";
                SqlCommand logCommand = new SqlCommand(SQLString, dbConnection);
                SqlDataReader empRecord = logCommand.ExecuteReader();
                if (empRecord.Read())
                {
                    //sets already existing values to those on the webpage using the database.
                    profilenamelabel.Text = cookie["firstName"] + " " + cookie["lastName"];
                    Email.Text = (string)empRecord["Email"];
                    Phone.Text = (string)empRecord["Phone"];
                    HomeAddr.Text = (string)empRecord["HomeAddress"];
                    City.Text = (string)empRecord["City"];
                    Zip.Text = (string)empRecord["ZIP"];
                    DropDownListState.SelectedValue = (string)empRecord["State"];
                }
            }
            catch (SqlException exception)
            {
                // errorLabel.Visible = true;
                // errorLabel.Text = "An unknown error occurred, please try again later.";
            }
            dbConnection.Close();
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




    protected void ActEdits_Click(object sender, EventArgs e)
    {
        //Makes all the bottom section textboxes editable.
        Phone.ReadOnly = false;
        HomeAddr.ReadOnly = false;
        City.ReadOnly = false;
        Zip.ReadOnly = false;
        DropDownListState.Enabled = true;
        SaveChange.Enabled = true;
        //Note here it will convert all the textboxes that are at the stae of readonly to editable and change their class to look like an editable textbox
        Phone.CssClass = "form-control";
        HomeAddr.CssClass = "form-control";
        City.CssClass = "form-control";
        Zip.CssClass = "form-control";
        SaveChange.CssClass = "btn btn-outline-success";
    }

    //Enabled once editing has been enabled and a change a has been made.
    protected void SaveChange_Click(object sender, EventArgs e)
    {

        //Add checks and warnings here to make sure info is properly formatted.


        string[] update = new string[5];

        update[0] = Phone.Text == "" ? "NULL" : Phone.Text;
        update[1] = HomeAddr.Text == "" ? "NULL" : HomeAddr.Text;
        update[2] = City.Text == "" ? "NULL" : City.Text;
        update[3] = Zip.Text == "" ? "NULL" : Zip.Text;
        update[4] = DropDownListState.SelectedValue == "-1" ? "NULL" : DropDownListState.SelectedValue;

        string updatequery = "UPDATE Employees SET Phone ='" + update[0] + "', HomeAddress ='" + update[1] + "', City ='" + update[2] + "', Zip ='" + update[3] + "', State ='" + update[4] + "' WHERE Email ='" + Email.Text + "'";

        //send update query here
        CreateTransactionScope.MakeTransactionScope(updatequery);
        SaveChange.Enabled = false;

        //Sets all the bottom section textboxes back to being uneditable and reverts their style.
        Phone.ReadOnly = true;
        HomeAddr.ReadOnly = true;
        City.ReadOnly = true;
        Zip.ReadOnly = true;
        DropDownListState.Enabled = false;
        Phone.CssClass = "form-control-plaintext";
        HomeAddr.CssClass = "form-control-plaintext";
        City.CssClass = "form-control-plaintext";
        Zip.CssClass = "form-control-plaintext";
        SaveChange.CssClass = "btn btn-outline-dark";
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

    //Method called when attempting to change passwords
    protected void SendPassChange_Click(object sender, EventArgs e)
    {
        if (NewPass.Text.Equals(NewPassConf.Text) && EntCurPassword.Text != "" && EntCurPassword.Text != NewPass.Text)
        { //Checks to make sure the new password boxes match and the current password is not null as well as making sure the old and new password do not match.
            if (Checkpassword()) //Checks to see if the given password matches the current password
            {
                CreateTransactionScope.MakeTransactionScope("UPDATE Employees SET Password ='" + ComputeSha256Hash(NewPass.Text) + "' WHERE Email ='" + Email.Text + "'"); //Generates a new hash for the new password and updates the database with it.
            }
        }
    }

    //Used to check to see if the current password is valid
    protected bool Checkpassword()
    {
        bool passwordchecks = false;
        SqlConnection dbConnection = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
        try
        {
            dbConnection.Open();
            dbConnection.ChangeDatabase("jhudgins6768_SeniorProject");
            //Sql connection is made and string query is sent
            string SQLString = "SELECT * FROM Employees WHERE Email = '" + Email.Text + "'";
            SqlCommand logCommand = new SqlCommand(SQLString, dbConnection);
            SqlDataReader empRecord = logCommand.ExecuteReader();
            if (empRecord.Read())
            {
                //Compares password given in textbox to one in database and returns true if the hash matches
                if (empRecord["Password"].Equals(ComputeSha256Hash(EntCurPassword.Text)))
                {
                    passwordchecks = true;
                }
            }
        }
        catch (SqlException exception)
        {

        }
        dbConnection.Close();
        return passwordchecks;
    }


}