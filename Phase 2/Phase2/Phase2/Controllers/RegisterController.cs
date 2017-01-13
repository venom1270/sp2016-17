using Microsoft.Ajax.Utilities;
using Phase2.Models;
using Phase2.Models.EntityManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using Microsoft.Extensions.Logging;

namespace Phase2.Controllers
{
    public class RegisterController : Controller
    {
        private EntityDataModel db = new EntityDataModel();

        readonly log4net.ILog logger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        ///     Base register view
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        ///     Method called when user clicks the subitm button on the register form
        ///     Adds a new user to the database and redirects to "/" if successful
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult TryRegister()
        {
            
            List<string> Errors = new List<string>();

            ViewBag.Errors = Errors;

            string inUsername = Request["username"];
            string inPassword = Request["password"];
            string inPassword2 = Request["passwordRepeat"];
            string inEmail = Request["email"];

            if (inUsername.IsNullOrWhiteSpace())
            {
                Errors.Add("Please input a valid username!");
            }
            if (inPassword.IsNullOrWhiteSpace())
            {
                Errors.Add("Please input a valid password!");
            }
            if (inPassword2.IsNullOrWhiteSpace())
            {
                Errors.Add("Please input a valid repeat password!");
            }
            if (inEmail.IsNullOrWhiteSpace())
            {
                Errors.Add("Please input a valid email!");
            }

            if (Errors.Count > 0)
            {
                ViewBag.Errors = Errors;
                logger.Warn("Register: received invalid registration data");
                return View("Index");
            }

           

            if (inPassword != inPassword2)
            {
                Errors.Add("Passwords don't match!");
                logger.Info("Register: received invalid registration data");
                return View("Index");
            }

            // Check if username already exists
            User user = db.Users.Where(u => u.Username == inUsername).FirstOrDefault();

            if (user != null)
            {
                Errors.Add("Username alreay exists. Please use another one.");
                logger.Info("Register: username already exists");
                return View("Index");
            }

            string hashedPassword = Crypto.HashPassword(inPassword);

            UserRole userRole = db.UserRoles.Where(ur => ur.RoleTitle == "User").FirstOrDefault();

            if (userRole == null)
            {
                Errors.Add("An error has occured during registration. Please conatact system administrator for further help.");
                logger.Error("Register: role 'User' not found in database. got caught in userRole == null");
                return View("Index");
            }

            User newUser = new User();
            newUser.Username = inUsername;
            newUser.Password = hashedPassword;
            newUser.Salt = hashedPassword;
            newUser.Email = inEmail;
            newUser.RegistrationDate = DateTime.Now;
            newUser.Role = userRole;

            try
            {
                db.Users.Add(newUser);
                db.SaveChanges();
                Session["User"] = newUser;
                logger.Info("Register: new user with username " + newUser.Username);
                return Redirect("/");
            }
            catch (Exception e)
            {
                Errors.Add("An error has occured during registration. Please conatact system administrator for further help.");
                logger.Error("Register: general registartion error. Stack trace: " + e.Message);
                return View("Index");
            }
            
        }
    }
}