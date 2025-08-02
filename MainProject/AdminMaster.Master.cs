using System;
using System.Web.UI;

namespace MainProject
{
    public partial class AdminMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verify admin status
            if (Session["usertype"] == null || Session["usertype"].ToString().ToLower() != "admin")
            {
                Response.Redirect("Login.aspx");
            }

            // Set user initials if logged in
            if (Session["username"] != null)
            {
                string username = Session["username"].ToString();
                userInitials.InnerText = GetInitials(username);
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        private string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "A";
            string[] parts = name.Split(new[] { ' ', '_' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1) return parts[0][0].ToString().ToUpper();
            return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
        }
    }
}