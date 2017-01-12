using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Phase2.Models
{
    public class UserRole
    {
        [Key]
        public int UserRoleId { get; set; }
        [Required]
        public string RoleTitle { get; set; }

        public virtual ICollection<User> Users { get; set; }
    }
}