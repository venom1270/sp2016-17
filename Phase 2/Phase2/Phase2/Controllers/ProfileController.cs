using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Phase2.Models;
using Phase2.Models.EntityManager;

namespace Phase2.Controllers
{
    public class ProfileController : Controller
    {
        private EntityDataModel db = new EntityDataModel();

        // GET: Profile
        public ActionResult Index()
        {
            // TODO
            Models.User user = db.Users.First();

            ViewBag.User = user;
            ViewBag.RegDate = user.RegistrationDate.ToShortDateString();


            return View();
        }
    }
}