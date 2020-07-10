using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Security.Cryptography;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void submitButton_Click(object sender, EventArgs e)
    {
        SqlConnection dbConnection = new SqlConnection("Data Source=192.185.7.119;Initial Catalog=jhudgins6768_SeniorProject;Persist Security Info=True;User ID=jhudgins6768_admin;Password=TheAdminPasswordIsAdminPassword1");
        try
        {
            dbConnection.Open();
            dbConnection.ChangeDatabase("jhudgins6768_SeniorProject");
            string SQLString = "SELECT * FROM Employees WHERE Email = '"+email.Text+"'";
            SqlCommand logCommand = new SqlCommand(SQLString, dbConnection);
            SqlDataReader empRecord = logCommand.ExecuteReader();
            if (empRecord.Read())
            {
                if (empRecord["Password"].Equals(ComputeSha256Hash(password.Text)))
                {
                    HttpCookie userInfoObject = new HttpCookie("userInfo");
                    userInfoObject.Values["firstName"] = (string)empRecord["firstName"];
                    userInfoObject.Values["lastName"] = (string)empRecord["lastName"];
                    userInfoObject.Expires = DateTime.Now.AddMinutes(1);
                    Response.Cookies.Add(userInfoObject);
                    Response.Redirect("index.aspx");
                }
                else
                {
                    errorLabel.Visible = true;
                    errorLabel.Text = "Incorrect password. Please check your password and try again.";
                }
            }
            else
            {
                errorLabel.Visible = true;
                errorLabel.Text = "No user found. Check your user name and try again.";
            }
        }
        catch (SqlException exception)
        {
            errorLabel.Visible = true;
            errorLabel.Text = "An unknown error occurred, please try again later.";
        }
        dbConnection.Close();
        
    }

    protected static string ComputeSha256Hash(string rawData)
    {
        // Create a SHA256
        using (SHA256Managed sha256ManagedHash = new SHA256Managed())
        {
            // ComputeHash - returns byte array
            byte[] bytes = sha256ManagedHash.ComputeHash(Encoding.UTF8.GetBytes(rawData));

            // Convert byte array to a string
            StringBuilder builder = new StringBuilder();
            for(int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }
            return builder.ToString();
        }
    }
}