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
    public class RegisterController : Controller
    {
        private EntityDataModel db = new EntityDataModel();

        // GET: Register
        public ActionResult Index()
        {
            return View();
        }

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
                return View("Index");
            }

           

            if (inPassword != inPassword2)
            {
                Errors.Add("Passwords don't match!");
                return View("Index");
            }

            // Check if username already exists
            User user = db.Users.Where(u => u.Username == inUsername).FirstOrDefault();

            if (user != null)
            {
                Errors.Add("Username alreay exists. Please use another one.");
                return View("Index");
            }

            string hashedPassword = Crypto.HashPassword(inPassword);

            UserRole userRole = db.UserRoles.Where(ur => ur.RoleTitle == "User").FirstOrDefault();

            if (userRole == null)
            {
                Errors.Add("An error has occured during registration. Please conatact system administrator for further help.");
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
                return Redirect("/");
            }
            catch (Exception e)
            {
                Errors.Add("An error has occured during registration. Please conatact system administrator for further help.");
                return View("Index");
            }
            
        }
    }
}