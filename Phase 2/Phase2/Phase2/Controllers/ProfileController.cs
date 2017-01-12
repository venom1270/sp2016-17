using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Phase2.Models;
using Phase2.Models.EntityManager;
using Microsoft.Ajax.Utilities;
using System.Web.Helpers;

namespace Phase2.Controllers
{
    public class ProfileController : Controller
    {
        private EntityDataModel db = new EntityDataModel();

        // GET: Profile
        public ActionResult Index()
        {
            int userId = getUserId();
            if (userId == -1)
            {
                return Redirect("/");
            }

            User user = db.Users.Where(u => u.UserId == userId).FirstOrDefault();
            if (user == null)
            {
                return Redirect("/");
            }

            ViewBag.User = user;
            ViewBag.RegDate = user.RegistrationDate.ToShortDateString();


            return View();
        }

        public ActionResult ChangeProfile()
        {

            string inEmail = Request["email"];
            string inPassword1 = Request["password"];
            string inPassword2 = Request["passwordRepeat"];

            int userId = getUserId();
            if (userId == -1)
            {
                return Redirect("/");
            }

            User tmp = db.Users.Find(userId);

            if (inEmail.IsNullOrWhiteSpace() == false)
            {

                tmp.Email = inEmail;
            }

            if (inPassword1.IsNullOrWhiteSpace() == false && inPassword2.IsNullOrWhiteSpace() == false)
            {
                if (inPassword1 == inPassword2)
                {
                    string hashedPassword = Crypto.HashPassword(inPassword1);
                    tmp.Password = hashedPassword;
                    tmp.Salt = hashedPassword;
                }
            }

            db.SaveChanges();


            return RedirectToAction("Index", new { user = Request["user"] });


        }

        private int getUserId()
        {
            string userIdRequest = Request["user"];

            if (userIdRequest.IsNullOrWhiteSpace())
            {
                return -1;
            }

            int userId = Convert.ToInt32(userIdRequest);
            return userId;
        }
    }
}