using Microsoft.Ajax.Utilities;
using Microsoft.Extensions.Logging;
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

        readonly log4net.ILog logger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        ///     Base Root view.
        ///     Checks for filters and displays appropriate posts.
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
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

            string searchFilter = Request["searchFilter"];

            ViewBag.CategoriesList = db.Categories.ToList();

            ViewBag.CategoryFilter = categoryFilter;

            List<Post> Posts;

            if (categoryFilter.Count == 0)
            {
                Posts = db.Posts.ToList();
            }
            else
            {
                Posts = db.Posts.Where(p => p.Categories.Where(c => categoryFilter.Contains(c.CategoryId)).Any()).ToList();
            }

            if (searchFilter.IsNullOrWhiteSpace() == false)
            {
                Posts = Posts.Where(p => p.Title.ToLower().Contains(searchFilter.ToLower())).ToList();
            }

            ViewBag.Posts = Posts;

            return View();
        }

     
    }
}