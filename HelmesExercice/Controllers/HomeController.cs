using HelmesExercice.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text.Encodings.Web;
using System.Web;
using System.Web.Mvc;

namespace HelmesExercice.Controllers
{
    public class HomeController : Controller
    {
        private ListUsers _listUsers = new ListUsers();
        private ListUserSectors _listUserSectors = new ListUserSectors();
        private ListSectors _listSectors = new ListSectors();
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult SaveChanges(string Name, string Sectors, string Terms)
        {
            _listUsers.Read();

            List<int> ListSectorsID = Sectors.Split(',').ToList().Select(s => int.Parse(s)).ToList();

            User usr = _listUsers.Where(u => u.Name == Name).FirstOrDefault();

            if(usr == null)
            {
                usr = new User();
                usr.Name = Name;
                usr.Save();
                usr.GetID();

                UserInfos userInfo = new UserInfos();
                userInfo.Terms = Terms.Equals("true");
                userInfo.UserID = usr.UserID;
                userInfo.Insert();
            }

            foreach (int sector in ListSectorsID)
            {
                _listUserSectors.Add(new UserSectors
                {
                    UserID = usr.UserID,
                    SectorID = sector
                });
            }
            _listUserSectors.Save();

            return Json(ListSectorsID);
        }

        [HttpGet]
        public string getSectors()
        {
            _listSectors.Read();

            ListSectors orderedList = _listSectors.Orderlist();

            return JsonConvert.SerializeObject(orderedList);
        }

    }


}