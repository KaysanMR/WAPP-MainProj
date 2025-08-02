using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace MainProject
{
    public partial class Lessons : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] != null)
                {
                    LoadLessons();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void LoadLessons()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT LessonId, Title FROM lessonTable ORDER BY LessonId", con);
                SqlDataReader reader = cmd.ExecuteReader();
                lessonRepeater.DataSource = reader;
                lessonRepeater.DataBind();
            }
        }
    }
}