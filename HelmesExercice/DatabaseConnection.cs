using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HelmesExercice
{
    public class DatabaseConnection
    {
        public SqlConnection con;

        public DatabaseConnection()
        {
            if ((con = _con()) == null)
            {
                this.Dispose();
            }
        }

        private SqlConnection _con()
        {
            SqlConnection conn = null;
          

            try
            {
                conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString; ;
                conn.Open();
                return conn;
            }
            catch
            {
                conn.Dispose();
                return null;
            }
        }
        public void Dispose()
        {
            if (con != null)
            {
                con.Dispose();
            }
        }
    }
}