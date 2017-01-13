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
        readonly log4net.ILog logger = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        ///     Base NewPost view.
        ///     Only Users and Admins have acces to this method.
        /// </summary>
        /// <returns></returns>
        [AuthorizationFilter("User", "Admin")]
        public ActionResult Index()
        {
            ViewBag.CategoriesList = db.Categories.ToList();

            return View();
        }

        /// <summary>
        ///     Called when submit on the new post form is pressed.
        ///     Only Users and Admins have acces to this method.
        /// </summary>
        /// <param name="postCategories">Categories the post will belong to</param>
        /// <returns></returns>
        [AuthorizationFilter("User", "Admin")]
        [ValidateAntiForgeryToken]
        public ActionResult Submit(string[] postCategories)
        {
            try
            {
                if (Session["User"] == null)
                {
                    return View("Index");
                }
                

                string postTitle = Request["postTitle"];
                string postContent = Request["postContent"];


                if (postTitle != null && postContent != null)
                {
                    Post newPost = new Post();
                    newPost.Content = postContent;
                    newPost.Title = postTitle;
                    newPost.CreationDate = DateTime.Now;
                    newPost.Upvotes = 0;
                    User tmpUser = (User)Session["User"];
                    newPost.User = db.Users.Where(u => u.Username == tmpUser.Username).FirstOrDefault();
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

                    logger.Info("NewPost: user " + tmpUser.Username + " created new post titled " + newPost.Title);
                }
                else
                {
                    logger.Info("NewPost: received invalid data");
                }
            }
            catch (Exception e)
            {
                logger.Error("NewPost: general error: " + e.Message);
            }

            return Redirect("/");
        }
    }
}