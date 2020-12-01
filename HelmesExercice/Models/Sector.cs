using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace HelmesExercice.Models
{
    public class Sector
    {
        public int SectorID { get; set; }

        public string Label { get; set; }

        public int? ParentSectorId { get; set; }

        public int LevelId { get; set; }

        public Sector()
        {
           
        }
    }

    public class ListSectors : List<Sector>
    {
        public void Read()
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string sql = @"select s.SectorID, s.Label, s.ParentSectorID, s.LevelID from Sectors s";

                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {

                        while (reader.Read())
                        {
                            Sector sector = new Sector();

                            sector.SectorID = Convert.ToInt32(reader["SectorID"].ToString());
                            sector.Label = reader["Label"].ToString();
                            if (Int32.TryParse(reader["ParentSectorID"].ToString(), out int res))
                            {
                                sector.ParentSectorId = res;
                            }
                            else
                            {
                                sector.ParentSectorId = null;
                            }
                            sector.LevelId = Convert.ToInt32(reader["LevelID"].ToString());
                            this.Add(sector);
                        }
                    }
                }
                conn.Close();
            }
        }

        public ListSectors Orderlist()
        {
            ListSectors orderedList = new ListSectors();
            foreach (Sector sect in this.Where(s => s.LevelId == 1).OrderBy(s => s.Label))
            {
                orderedList.Add(sect);
                foreach (Sector sect2 in this.Where(s => s.LevelId == 2 && s.ParentSectorId == sect.SectorID).OrderBy(s => s.Label))
                {
                    orderedList.Add(sect2);
                    foreach (Sector sect3 in this.Where(s => s.LevelId == 3 && s.ParentSectorId == sect2.SectorID).OrderBy(s => s.Label))
                    {
                        orderedList.Add(sect3);
                        foreach (Sector sect4 in this.Where(s => s.LevelId == 4 && s.ParentSectorId == sect3.SectorID).OrderBy(s => s.Label))
                        {
                            orderedList.Add(sect4);
                        }
                    }
                }
            }

            return orderedList;
        }

    }

    
}