using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HelmesExercice.Models
{
    public class UserSectors
    {
        public int SectorID { get; set; }

        public int UserID { get; set; }

        public UserSectors()
        {

        }

       
    }

    public class ListUserSectors : List<UserSectors>
    {
        public void Read()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"select us.UserID, us.SectorID from UserSectors us";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UserSectors userSectors = new UserSectors();

                            userSectors.UserID = Convert.ToInt32(reader["UserID"].ToString());
                            userSectors.SectorID = Convert.ToInt32(reader["SectorID"].ToString());
                            this.Add(userSectors);
                        }
                    }
                }
                conn.Close();

            }

        }

        public void Read(int userID)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"select us.SectorID from UserSectors us where us.UserID = @UserID";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.Add(new SqlParameter("UserId", userID));

                    conn.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UserSectors userSectors = new UserSectors();

                            userSectors.UserID = userID;
                            userSectors.SectorID = Convert.ToInt32(reader["SectorID"].ToString());
                            this.Add(userSectors);
                        }
                    }
                }
                conn.Close();

            }
        }

        public void Save()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString; ;

                string sql = @"delete from UserSectors where UserID = @UserId";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.Add(new SqlParameter("UserId", this.First().UserID));

                    conn.Open();
                    command.ExecuteNonQuery();
                }

                foreach(UserSectors userSector in this)
                {
                    sql = @"insert into UserSectors (UserID, SectorID) values(@UserId, @SectorID)";

                    using (SqlCommand command = new SqlCommand(sql, conn))
                    {
                        command.Parameters.Add(new SqlParameter("UserId", userSector.UserID));
                        command.Parameters.Add(new SqlParameter("SectorID", userSector.SectorID));

                        command.ExecuteNonQuery();
                    }
                }
                
                conn.Close();
            }
        }

    }
}