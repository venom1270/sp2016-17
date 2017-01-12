using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Phase2.Models
{
    public class User
    {
        [Key]
        public int UserId { get; set; }
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
        public string Salt { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public DateTime RegistrationDate { get; set; }

        public virtual UserRole Role { get; set; }
        public virtual ICollection<Post> Posts { get; set; } 
        public virtual ICollection<Comment> Comments { get; set; }
    }
}