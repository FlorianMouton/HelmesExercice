using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HelmesExercice.Models
{
    public class UserInfos
    {
        public int ID { get; set; }
        public int UserID { get; set; }
        public bool Terms { get; set; }
        public List<int> SectorsList { get; set; } = new List<int>();

        public UserInfos()
        {
           
        }

        public void Insert()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"insert into UserInfos (UserId, TermsAgreed) values(@UserID, @Terms)";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.Add(new SqlParameter("UserID", UserID));
                    command.Parameters.Add(new SqlParameter("Terms", Terms));

                    conn.Open();
                    command.ExecuteNonQuery();

                }
                conn.Close();
            }
        }

        public void Read(int userID)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"select ui.InfoID, ui.UserID, ui.TermsAgreed from UserInfos ui where ui.UserID = @UserID";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.Add(new SqlParameter("UserID", userID));

                    conn.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UserInfos userinfo = new UserInfos();

                            userinfo.ID = Convert.ToInt32(reader["InfoID"].ToString());
                            userinfo.UserID = Convert.ToInt32(reader["UserID"].ToString());
                            userinfo.Terms = Convert.ToBoolean(reader["TermsAgreed"].ToString());

                        }
                    }
                }
                conn.Close();

            }

        }

    }

    public class ListUserInfos : List<UserInfos>
    {
        public void Read()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"select ui.InfoID, ui.UserID, ui.TermsAgreed from UserInfos ui";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UserInfos userinfo = new UserInfos();

                            userinfo.ID = Convert.ToInt32(reader["InfoID"].ToString());
                            userinfo.UserID = Convert.ToInt32(reader["UserID"].ToString());
                            userinfo.Terms = Convert.ToBoolean(reader["TermsAgreed"].ToString());
                            this.Add(userinfo);

                        }
                    }
                }
                conn.Close();

            }

        }
    }

}