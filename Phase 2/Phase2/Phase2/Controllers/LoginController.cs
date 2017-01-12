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

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

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
                return View("Index");
            }

            

            User user = db.Users.Where(u => u.Username == inUsername).FirstOrDefault();

            if (user == null)
            {
                Errors.Add("Username and password combination not found! Please check your input.");
                return View("Index");
            }

            string hashedPassword = user.Password;
            bool doesPasswordMatch = Crypto.VerifyHashedPassword(hashedPassword, inPassword);

            if (doesPasswordMatch == false)
            {
                Errors.Add("Username and password combination not found! Please check your input.");
                return View("Index");
            }

            Session["User"] = user;
            return Redirect("/");

        }

        public ActionResult Logout()
        {
            Session["User"] = null;
            return Redirect("/");
        }
    }
}