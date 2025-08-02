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
                LoadTotalLessonsCompleted();
                LoadTopLearner();
                LoadUserProgress();
                LoadLessonStats();
                LoadUserActivity();
                LoadLessonViews();
                LoadCompletionStats();
                LoadAnswerAccuracy();
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

        private void LoadTotalLessonsCompleted()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM userProgress WHERE Completed = 1", con);
                int total = (int)cmd.ExecuteScalar();
                lblTotalLessons.Text = total.ToString();
            }
        }

        private void LoadTopLearner()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = @"
                    SELECT TOP 1 u.username, COUNT(p.Id) as CompletedCount
                    FROM userTable u
                    INNER JOIN userProgress p ON u.Id = p.UserId
                    WHERE p.Completed = 1 AND u.usertype = 'user'
                    GROUP BY u.username, u.Id
                    ORDER BY CompletedCount DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                var result = cmd.ExecuteScalar();
                lblTopLearner.Text = result != null ? result.ToString() : "No data";
            }
        }

        private void LoadUserProgress()
        {
            string query = @"
                SELECT TOP 10
                    u.username, 
                    l.Title AS Lesson, 
                    p.Score,
                    p.CompletionDate
                FROM userProgress p
                JOIN userTable u ON u.Id = p.UserId
                JOIN lessonTable l ON l.LessonId = p.LessonId
                WHERE p.Completed = 1
                ORDER BY p.CompletionDate DESC";

            BindGrid(GridViewProgress, query);
        }

        private void LoadLessonStats()
        {
            string query = @"
                SELECT 
                    l.Title AS Lesson,
                    COUNT(p.Id) AS UsersCompleted,
                    COALESCE(AVG(CAST(p.Score AS FLOAT)), 0) AS AverageScore,
                    COALESCE(SUM(p.Score), 0) AS TotalScore
                FROM lessonTable l
                LEFT JOIN userProgress p ON l.LessonId = p.LessonId AND p.Completed = 1
                GROUP BY l.Title, l.LessonId
                ORDER BY l.LessonId";

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

                // Count total users (excluding admin)
                totalUsers = Convert.ToInt32(new SqlCommand("SELECT COUNT(*) FROM userTable WHERE usertype = 'user'", con).ExecuteScalar());

                // Count users who have completed at least one lesson
                activeUsers = Convert.ToInt32(new SqlCommand("SELECT COUNT(DISTINCT UserId) FROM userProgress WHERE Completed = 1", con).ExecuteScalar());
            }

            int inactive = Math.Max(0, totalUsers - activeUsers);
            // Ensure we always have valid integers
            litPieDataClient.Text = $"{Math.Max(0, activeUsers)},{Math.Max(0, inactive)}";
        }

        private void LoadLessonViews()
        {
            StringBuilder labels = new StringBuilder(), views = new StringBuilder();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                var cmd = new SqlCommand(@"
                    SELECT TOP 10 l.Title, COUNT(p.Id) AS Completions
                    FROM lessonTable l
                    LEFT JOIN userProgress p ON l.LessonId = p.LessonId AND p.Completed = 1
                    GROUP BY l.Title, l.LessonId
                    ORDER BY COUNT(p.Id) DESC", con);

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    string title = reader["Title"].ToString();
                    if (!string.IsNullOrEmpty(title))
                    {
                        // Remove any problematic characters and limit length
                        title = System.Text.RegularExpressions.Regex.Replace(title, @"[^\w\s-]", "");
                        if (title.Length > 30) title = title.Substring(0, 30) + "...";

                        labels.Append($"\"{title}\",");
                        views.Append(reader["Completions"] + ",");
                    }
                }
            }

            litLessonLabelsClient.Text = labels.ToString().TrimEnd(',');
            litLessonViewsClient.Text = views.ToString().TrimEnd(',');
        }

        private void LoadCompletionStats()
        {
            int totalCourses = 0;
            int completedAll = 0, completedSome = 0;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();

                // Get actual total number of lessons
                totalCourses = Convert.ToInt32(new SqlCommand("SELECT COUNT(*) FROM lessonTable", con).ExecuteScalar());

                if (totalCourses > 0)
                {
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
            }

            // Ensure we always have valid numbers
            LitCompletionClient.Text = $"{Math.Max(0, completedAll)},{Math.Max(0, completedSome)}";
            LitCompletionClient.Visible = true;
        }

        private void LoadAnswerAccuracy()
        {
            StringBuilder labels = new StringBuilder(), correctAnswers = new StringBuilder(), incorrectAnswers = new StringBuilder();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();

                // Use userAnswers table for detailed accuracy data
                var cmd = new SqlCommand(@"
                    SELECT 
                        l.Title,
                        SUM(CASE WHEN ua.IsCorrect = 1 THEN 1 ELSE 0 END) as CorrectAnswers,
                        SUM(CASE WHEN ua.IsCorrect = 0 THEN 1 ELSE 0 END) as IncorrectAnswers
                    FROM lessonTable l
                    LEFT JOIN userAnswers ua ON l.LessonId = ua.LessonId
                    GROUP BY l.Title, l.LessonId
                    HAVING COUNT(ua.Id) > 0
                    ORDER BY l.LessonId", con);

                var reader = cmd.ExecuteReader();
                bool hasData = false;

                while (reader.Read())
                {
                    hasData = true;
                    string title = reader["Title"].ToString();
                    if (!string.IsNullOrEmpty(title))
                    {
                        // Remove any problematic characters and limit length
                        title = System.Text.RegularExpressions.Regex.Replace(title, @"[^\w\s-]", "");
                        if (title.Length > 30) title = title.Substring(0, 30) + "...";

                        labels.Append($"\"{title}\",");
                        correctAnswers.Append(reader["CorrectAnswers"] + ",");
                        incorrectAnswers.Append(reader["IncorrectAnswers"] + ",");
                    }
                }

                reader.Close();

                // If no userAnswers data, use completion scores as proxy
                if (!hasData)
                {
                    cmd = new SqlCommand(@"
                        SELECT 
                            l.Title,
                            SUM(CASE WHEN p.Score >= 80 THEN 1 ELSE 0 END) as HighScores,
                            SUM(CASE WHEN p.Score < 80 THEN 1 ELSE 0 END) as LowScores
                        FROM lessonTable l
                        LEFT JOIN userProgress p ON l.LessonId = p.LessonId AND p.Completed = 1
                        GROUP BY l.Title, l.LessonId
                        HAVING COUNT(p.Id) > 0
                        ORDER BY l.LessonId", con);

                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string title = reader["Title"].ToString();
                        if (!string.IsNullOrEmpty(title))
                        {
                            // Remove any problematic characters and limit length
                            title = System.Text.RegularExpressions.Regex.Replace(title, @"[^\w\s-]", "");
                            if (title.Length > 30) title = title.Substring(0, 30) + "...";

                            labels.Append($"\"{title}\",");
                            correctAnswers.Append(reader["HighScores"] + ",");
                            incorrectAnswers.Append(reader["LowScores"] + ",");
                        }
                    }
                }
            }

            // Ensure we have data before setting the literal
            string labelsText = labels.ToString().TrimEnd(',');
            string correctText = correctAnswers.ToString().TrimEnd(',');
            string incorrectText = incorrectAnswers.ToString().TrimEnd(',');

            if (!string.IsNullOrEmpty(labelsText))
            {
                litCorrectIncorrectClient.Text = $"{correctText};{incorrectText};{labelsText}";
            }
            else
            {
                litCorrectIncorrectClient.Text = "0;0;\"No Data\"";
            }
        }
    }
}