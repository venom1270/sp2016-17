using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Phase2.Models
{
    public class AuthorizationFilter : AuthorizeAttribute, IAuthorizationFilter
    {
        public new void OnAuthorization(AuthorizationContext filterContext)
        {
            if (filterContext.ActionDescriptor.IsDefined(typeof(AllowAnonymousAttribute), true)
             || filterContext.ActionDescriptor.ControllerDescriptor.IsDefined(typeof(AllowAnonymousAttribute), true))
            {
                // Don't check for authorization as AllowAnonymous filter is applied to the action or controller
                return;
            }

            User user = (User)HttpContext.Current.Session["User"];

            // Check for authorization
            if (user == null)
            {
                filterContext.Result = new HttpUnauthorizedResult();
                return;
            }

            // TODO: AUTHORIZE USER            

            bool authorized = false;
            
            foreach (var role in this.rolesAllowed)
            {
                if (user.Role.RoleTitle == role)
                {
                    authorized = true;
                    break;
                }
            }

            if (!authorized)
            {
                filterContext.Result = new HttpUnauthorizedResult();
            }
        }

        private string[] rolesAllowed { get; set; }
        public AuthorizationFilter(params string[] rolesAllowed)
        {
            if (rolesAllowed.Length == 0)
                throw new ArgumentException("RolesRequired");
            this.rolesAllowed = rolesAllowed.ToArray();
        }


    }
}