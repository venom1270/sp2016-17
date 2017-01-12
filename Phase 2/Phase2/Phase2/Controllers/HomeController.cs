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
            string x = Request["1"];

            List<int> categoryFilter = new List<int>();
            for (int i = 0; i < Request.QueryString.Count; i++)
            {
                if (Request.QueryString[Request.QueryString.Keys[i]] == "on")
                {
                    int cat = Convert.ToInt32(Request.QueryString.Keys[i]);
                    categoryFilter.Add(cat);
                }
            }

            ViewBag.CategoriesList = db.Categories.ToList();

            ViewBag.CategoryFilter = categoryFilter;

            if (categoryFilter.Count == 0)
            {
                ViewBag.Posts = db.Posts.ToList();
            }
            else
            {
                ViewBag.Posts = db.Posts.Where(p => p.Categories.Where(c => categoryFilter.Contains(c.CategoryId)).Any()).ToList();
            }

            
            
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