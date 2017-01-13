using Microsoft.Ajax.Utilities;
using Phase2.Models;
using Phase2.Models.EntityManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace Phase2.Controllers
{
    public class LoginController : Controller
    {

        private EntityDataModel db = new EntityDataModel();
        readonly log4net.ILog logger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        ///     Base Login view.
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        ///     Validates data and sets the session variable if data is correct.
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult TryLogin()
        {
            

            List<string> Errors = new List<string>();

            ViewBag.Errors = Errors;

            string inUsername = Request["username"];
            string inPassword = Request["password"];

            if (inUsername.IsNullOrWhiteSpace())
            {
                Errors.Add("Please input a valid username!");
            }
            if (inPassword.IsNullOrWhiteSpace())
            {
                Errors.Add("Please input a valid password!");
            }

            if (Errors.Count > 0)
            {
                ViewBag.Errors = Errors;
                logger.Warn("Login: Invalid login data received");
                return View("Index");

            }

            

            User user = db.Users.Where(u => u.Username == inUsername).FirstOrDefault();

            if (user == null)
            {
                Errors.Add("Username and password combination not found! Please check your input.");
                logger.Warn("Login: user with inputted username does not exist");
                return View("Index");
            }

            string hashedPassword = user.Password;
            bool doesPasswordMatch = Crypto.VerifyHashedPassword(hashedPassword, inPassword);

            if (doesPasswordMatch == false)
            {
                Errors.Add("Username and password combination not found! Please check your input.");
                logger.Warn("Login: username and password combination doesen't match");
                return View("Index");
            }

            logger.Info("Login: User with username " + user.Username + " logged in!");

            Session["User"] = user;
            return Redirect("/");

        }

        /// <summary>
        ///     Resets session variable and redirects to "/".
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Logout()
        {
            Session["User"] = null;
            return Redirect("/");
        }
    }
}