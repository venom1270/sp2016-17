using Phase2.Models;
using Phase2.Models.EntityManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace Phase2.Controllers
{
    public class HomeController : Controller
    {
        private EntityDataModel db = new EntityDataModel();

        public ActionResult Index()
        {
            ViewBag.CategoriesList = db.Categories.ToList();

            ViewBag.Posts = db.Posts.ToList();
            
            return View();
        }

        /*public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            Models.EntityManager.EntityDataModel em = new Models.EntityManager.EntityDataModel();

            Post p = em.Posts.Find(1);
            Console.WriteLine(p.Content);
            

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }*/
    }
}