using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Phase2.Models;
using Phase2.Models.EntityManager;
using System.Net.Http;
using System.Web.Helpers;
using Microsoft.Ajax.Utilities;

namespace Phase2.Controllers
{
    public class PostController : Controller
    {
        private EntityDataModel db = new EntityDataModel();

        private void ValidateRequestHeader(HttpRequestMessage request)
        {
            string cookieToken = "";
            string formToken = "";

            IEnumerable<string> tokenHeaders;
            if (request.Headers.TryGetValues("RequestVerificationToken", out tokenHeaders))
            {
                string[] tokens = tokenHeaders.First().Split(':');
                if (tokens.Length == 2)
                {
                    cookieToken = tokens[0].Trim();
                    formToken = tokens[1].Trim();
                }
            }
            AntiForgery.Validate(cookieToken, formToken);
        }


        public ActionResult Index()
        {

            int postId = GetCurrentPostId();
            // Get requested post

            Post post = GetPostById(postId);

            ViewBag.Post = post;

            // Get post comments
            List<Comment> comments = db.Comments.Where(c => c.Post.PostId == postId && c.ParentCommentId == null).ToList();
            ViewBag.Comments = comments;

            ViewBag.CreationDate = post.CreationDate.ToShortDateString();

            return View("Index");
        }

        // POST new comment
        [ValidateAntiForgeryToken]
        public ActionResult NewComment()
        {
            if (Session["User"] == null) return Redirect("/");

            try
            {
                string commentContent = Request["newCommentText"];
                string parentComment = Request["textParentComment"];

                if (commentContent != null)
                {
                    Comment newComment = new Comment();
                    newComment.Content = commentContent;
                    newComment.CreationDate = DateTime.Now;
                    newComment.Post = GetCurrentPost();
                    Phase2.Models.User tmp = (Phase2.Models.User) Session["User"];
                    newComment.User = db.Users.Where(u => u.Username == tmp.Username).FirstOrDefault();
                    newComment.Upvotes = 0;

                    if (parentComment != null && parentComment != "")
                    {
                        int parentId = Convert.ToInt32(parentComment);
                        Comment parent = db.Comments.Where(c => c.CommentId == parentId).First();
                        newComment.ParentCommentId = parentId;
                        newComment.ParentComment = parent;
                    }

                    db.Comments.Add(newComment);
                    db.SaveChanges();
                }
                else
                {
                    string tmp = "zbris to pol";
                }
            }
            catch (Exception e)
            {

            }
            
            
            return RedirectToAction("Index", new { postId = GetCurrentPostId()} );
        }

        public ActionResult DeleteComment()
        {
            string commentIdString = Request["commentId"];

            if (commentIdString.IsNullOrWhiteSpace() == false)
            {
                int commentId = Convert.ToInt32(commentIdString);
                Comment comment = db.Comments.Find(commentId);
                comment.Content = "[ DELETED ]";

                db.SaveChanges();
            }

            return RedirectToAction("Index", new { postId = GetCurrentPostId() });
        }

        private Post GetCurrentPost()
        {
            return GetPostById(GetCurrentPostId());
        }

        private int GetCurrentPostId()
        {
            if (Request.QueryString["postId"] == null)
            {
                return 1;
            }
            else
            {
                string postidstring = Request.QueryString["postId"];
                return Convert.ToInt32(postidstring);
            }
        }

        private Post GetPostById(int postId)
        {
            return db.Posts.Where(p => p.PostId == postId).FirstOrDefault(); ;
        }

    }
}
