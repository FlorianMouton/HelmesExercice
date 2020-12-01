using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HelmesExercice.Models
{
    public class User
    {
        public int UserID { get; set; }

        public string Name { get; set; }
        public User()
        {

        }

        public void Save()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString; ;

                string sql = @"insert into Users (Name) values(@Name)";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.Add(new SqlParameter("Name", Name));

                    conn.Open();
                    command.ExecuteNonQuery();
                                       
                }
                conn.Close();
            }
        }

        public void GetID()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"select u.UserID from Users u where u.Name = @Name";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.Add(new SqlParameter("Name", Name));
                    conn.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if(reader.Read())
                        {
                            UserID = Convert.ToInt32(reader["UserID"].ToString());

                        }
                    }
                }
                conn.Close();
            }
        }
    }

    public class ListUsers : List<User>
    {
        public void Read()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"select u.UserID, u.Name from Users u";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while(reader.Read())
                        {
                            User user = new User();

                            user.UserID = Convert.ToInt32(reader["UserID"].ToString());
                            user.Name = reader["Name"].ToString();
                            this.Add(user);

                        }
                    }
                }
                conn.Close();

            }
        
        }
    }
}