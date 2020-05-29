using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

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
            string SQLString = "SELECT * FROM Employee WHERE Email = '"+email.Text+"'";
            SqlCommand logCommand = new SqlCommand(SQLString, dbConnection);
            SqlDataReader empRecord = logCommand.ExecuteReader();
            if (empRecord.Read())
            {
                if (empRecord["Pass"].Equals(password.Text))
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
}