using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace MainProject
{
    public partial class AdminNew : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usertype"] == null || Session["usertype"].ToString().ToLower() != "admin")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadTotalUsers();
                LoadUserProgress();
                LoadLessonStats();
                LoadUserActivity();
                LoadLessonViews();
                LoadCompletionStats();
            }
        }

        private void LoadTotalUsers()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM userTable WHERE usertype = 'user'", con);
                int total = (int)cmd.ExecuteScalar();
                lblTotalUsers.Text = total.ToString();
            }
        }

        private void LoadUserProgress()
        {
            string query = @"
                SELECT 
                    u.username, 
                    l.Title AS Lesson, 
                    p.Score
                FROM userProgress p
                JOIN userTable u ON u.Id = p.UserId
                JOIN lessonTable l ON l.LessonId = p.LessonId
                ORDER BY u.username, l.LessonId";

            BindGrid(GridViewProgress, query);
        }

        private void LoadLessonStats()
        {
            string query = @"
                SELECT 
                    l.Title AS Lesson,
                    COUNT(p.Id) AS UsersCompleted,
                    SUM(p.Score) AS TotalScore
                FROM lessonTable l
                LEFT JOIN userProgress p ON l.LessonId = p.LessonId
                GROUP BY l.Title";

            BindGrid(GridViewLessonStats, query);
        }

        private void BindGrid(System.Web.UI.WebControls.GridView grid, string query)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                grid.DataSource = dt;
                grid.DataBind();
            }
        }

        private void LoadUserActivity()
        {
            int totalUsers = 0, activeUsers = 0;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                totalUsers = Convert.ToInt32(new SqlCommand("SELECT COUNT(*) FROM userTable", con).ExecuteScalar());
                activeUsers = Convert.ToInt32(new SqlCommand("SELECT COUNT(DISTINCT UserId) FROM userProgress", con).ExecuteScalar());
            }

            int inactive = totalUsers - activeUsers;
            litPieDataClient.Text = $"{activeUsers},{inactive}";
        }

        private void LoadLessonViews()
        {
            StringBuilder labels = new StringBuilder(), views = new StringBuilder();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                var cmd = new SqlCommand(@"
                    SELECT l.Title, COUNT(p.Id) AS Completions
                    FROM lessonTable l
                    LEFT JOIN userProgress p ON l.LessonId = p.LessonId
                    GROUP BY l.Title", con);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    labels.Append($"'{reader["Title"]}',");
                    views.Append(reader["Completions"] + ",");
                }
            }

            litLessonLabelsClient.Text = labels.ToString().TrimEnd(',');
            litLessonViewsClient.Text = views.ToString().TrimEnd(',');
        }

        protected Literal LitCompletionClient;

        private void LoadCompletionStats()
        {
            int totalCourses = 10;
            int completedAll = 25, completedSome = 75;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();

                string sql = @"
                WITH UserCompletion AS (
                    SELECT 
                        UserId, 
                        COUNT(DISTINCT LessonId) AS CompletedCount
                    FROM userProgress
                    WHERE Completed = 1
                    GROUP BY UserId
                    HAVING COUNT(DISTINCT LessonId) > 0
                )
                SELECT 
                    SUM(CASE WHEN CompletedCount = @totalCourses THEN 1 ELSE 0 END) AS CompletedAll,
                    SUM(CASE WHEN CompletedCount < @totalCourses THEN 1 ELSE 0 END) AS CompletedSome
                FROM UserCompletion";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@totalCourses", totalCourses);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        completedAll = reader["CompletedAll"] != DBNull.Value ? Convert.ToInt32(reader["CompletedAll"]) : 0;
                        completedSome = reader["CompletedSome"] != DBNull.Value ? Convert.ToInt32(reader["CompletedSome"]) : 0;
                    }
                }
            }

            LitCompletionClient.Text = $"{completedAll},{completedSome}";
        }
    }
}

