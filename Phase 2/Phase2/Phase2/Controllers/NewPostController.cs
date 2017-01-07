using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Phase2.Models;
using Phase2.Models.EntityManager;
using System.Web.UI.WebControls;

namespace Phase2.Controllers
{
    public class NewPostController : Controller
    {
        private EntityDataModel db = new EntityDataModel();

        // GET: NewPost
        public ActionResult Index()
        {
            ViewBag.CategoriesList = db.Categories.ToList();

            return View();
        }

        public ActionResult Submit(string[] postCategories)
        {
            try
            {
                string postTitle = Request["postTitle"];
                string postContent = Request["postContent"];


                if (postTitle != null && postContent != null)
                {
                    Post newPost = new Post();
                    newPost.Content = postContent;
                    newPost.Title = postTitle;
                    newPost.CreationDate = DateTime.Now;
                    newPost.Upvotes = 0;
                    newPost.User = db.Users.Where(u => u.Username == "Žiga").First();
                    List<Category> categories = new List<Category>();
                    for (int i = 0; i < postCategories.Length; i++)
                    {
                        int id = Convert.ToInt32(postCategories[i]);
                        Category cat = db.Categories.Where(c => c.CategoryId == id).First();
                        if (cat != null) categories.Add(cat);
                    }
                    newPost.Categories = categories;

                    db.Posts.Add(newPost);
                    db.SaveChanges();
                }
                else
                {
                    string tmp = "zbris to pol";
                }
            }
            catch (Exception e)
            {
                string tmp = "zbris to pol";
            }

            return Redirect("/");
        }
    }
}