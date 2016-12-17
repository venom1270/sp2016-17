using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Phase2.Models
{
    public class Post
    {
        [Key]
        public int PostId { get; set; }
        [Required]
        public string Title { get; set; }
        [Required]
        public string Content { get; set; }
        [Required]
        public int Upvotes { get; set; }
        [Required]
        public DateTime CreationDate { get; set; }

        public virtual User User { get; set; }

        public virtual ICollection<Category> Categories { get; set; }
    }
}