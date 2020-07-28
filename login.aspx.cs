using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;
using System.Security.Cryptography;
using System.Configuration;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void submitButton_Click(object sender, EventArgs e)
    {
        SqlConnection dbConnection = new SqlConnection(ConnectionString.GetConnectionString("invDBConStr"));
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
                    userInfoObject.Values["emplID"] = (string)empRecord["EmployeeID"];
                    userInfoObject.Values["firstName"] = (string)empRecord["FirstName"];
                    userInfoObject.Values["lastName"] = (string)empRecord["LastName"];
                    userInfoObject.Values["admin"] = ((bool)empRecord["Admin"]).ToString();
                    userInfoObject.Values["dptID"] = (string)empRecord["DepartmentID"];
                    userInfoObject.Expires = DateTime.Now.AddMinutes(10);
                    Response.Cookies.Add(userInfoObject);
                    string lastLogUpdate = "UPDATE Employees SET LastLogged = GETDATE() WHERE EmployeeID = '" + (string)empRecord["EmployeeID"] + "'";
                    empRecord.Close();
                    logCommand.CommandText = lastLogUpdate;
                    logCommand.ExecuteNonQuery();
                    dbConnection.Close();
                    Response.Redirect("index.aspx", false);
                    
                    Response.Redirect("index.aspx", false);
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
