using System;
using System.Web.UI;

namespace MainProject
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] != null)
                {
                    phNotLoggedIn.Visible = false;
                    phLoggedIn.Visible = true;

                    string username = Session["username"].ToString();
                    string initials = GetInitials(username);
                    userInitials.InnerText = initials.ToUpper();
                }
                else
                {
                    phNotLoggedIn.Visible = true;
                    phLoggedIn.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("MainPage.aspx");
        }

        private string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name))
                return "?";

            string[] parts = name.Split(new[] { ' ', '_' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1) return parts[0].Substring(0, 1);
            return parts[0][0].ToString() + parts[1][0].ToString();
        }
    }
}