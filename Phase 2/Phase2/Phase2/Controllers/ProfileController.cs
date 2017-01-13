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

        readonly log4net.ILog logger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        ///     Base Profile view.
        ///     Receives 'userId' GET parameter; if it's null it redirects to "/"
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Index()
        {
            int userId = getUserId();
            if (userId == -1)
            {
                logger.Warn("Profile: empty userId");
                return Redirect("/");
            }

            User user = db.Users.Where(u => u.UserId == userId).FirstOrDefault();
            if (user == null)
            {
                logger.Warn("Profile: userId doesn't match user");
                return Redirect("/");
            }

            ViewBag.User = user;
            ViewBag.RegDate = user.RegistrationDate.ToShortDateString();


            return View();
        }

        /// <summary>
        ///     Called when user click apply on change profile form.
        ///     Changes the User model data of current user according to input.
        ///     Only Users and Admins have acces to this method.
        /// </summary>
        /// <returns></returns>
        [AuthorizationFilter("Admin", "User")]
        [ValidateAntiForgeryToken]
        public ActionResult ChangeProfile()
        {

            string inEmail = Request["email"];
            string inPassword1 = Request["password"];
            string inPassword2 = Request["passwordRepeat"];

            int userId = getUserId();
            if (userId == -1)
            {
                logger.Warn("ChangeProfile: userId doesn't match user");
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
                else
                {
                    logger.Warn("ChangeProfile: passwords don't match");
                }
            }

            db.SaveChanges();

            logger.Info("ChangeProfile: succsessfully updated user profile: " + tmp.Username);

            return RedirectToAction("Index", new { user = Request["user"] });


        }

        /// <summary>
        ///     A helper private function to parse userId from GET request
        /// </summary>
        /// <returns></returns>
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