using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MainProject
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Hide navigation elements for register page
            var phLoggedIn = Master.FindControl("phLoggedIn") as PlaceHolder;
            var phNotLoggedIn = Master.FindControl("phNotLoggedIn") as PlaceHolder;

            if (phLoggedIn != null) phLoggedIn.Visible = false;
            if (phNotLoggedIn != null) phNotLoggedIn.Visible = false;

            // Clear session on load
            Session.Clear();
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    con.Open();

                    // Check if username exists
                    string checkUser = "SELECT COUNT(*) FROM userTable WHERE username = @username";
                    SqlCommand checkCmd = new SqlCommand(checkUser, con);
                    checkCmd.Parameters.AddWithValue("@username", username.Text.Trim());
                    int exists = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (exists > 0)
                    {
                        errMsg.Visible = true;
                        errMsg.Text = "Username already exists!";
                        return;
                    }

                    // Validate password length
                    if (pwd.Text.Length < 8 || pwd.Text.Length > 16)
                    {
                        errMsg.Visible = true;
                        errMsg.Text = "Password must be between 8 and 16 characters.";
                        return;
                    }

                    // Determine user type
                    string userType = "user";
                    if (adminKey.Text == "adminSecret123")
                        userType = "admin";

                    // Insert new user
                    string insert = @"INSERT INTO userTable 
                        (gender, country, email, username, password, usertype) 
                        VALUES (@gender, @country, @email, @username, @password, @usertype)";
                    SqlCommand insertCmd = new SqlCommand(insert, con);
                    insertCmd.Parameters.AddWithValue("@gender", gender.SelectedItem.Text);
                    insertCmd.Parameters.AddWithValue("@country", country.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@email", email.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@username", username.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@password", pwd.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@usertype", userType);

                    insertCmd.ExecuteNonQuery();

                    // Set session variables
                    Session["username"] = username.Text;
                    Session["usertype"] = userType;

                    // Redirect based on user type
                    Response.Redirect(userType == "admin" ? "AdminNew.aspx" : "MainPage.aspx");
                }
            }
            catch (Exception ex)
            {
                errMsg.Visible = true;
                errMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}