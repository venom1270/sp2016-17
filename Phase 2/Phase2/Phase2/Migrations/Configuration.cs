namespace Phase2.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using Models;
    using System.Collections.Generic;

    internal sealed class Configuration : DbMigrationsConfiguration<Phase2.Models.EntityManager.EntityDataModel>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(Phase2.Models.EntityManager.EntityDataModel context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //
            //    context.People.AddOrUpdate(
            //      p => p.FullName,
            //      new Person { FullName = "Andrew Peters" },
            //      new Person { FullName = "Brice Lambson" },
            //      new Person { FullName = "Rowan Miller" }
            //    );
            //

            if (!context.Users.Any() && !context.Posts.Any() && !context.Comments.Any() && !context.Categories.Any())
            {
                User u = new User { Username = "Žiga", Email = "zigsim1@gmail.com", Password = "qwe", Salt = "qwe", RegistrationDate = DateTime.Now };
                Category c = new Category { Name = "TEST" };
                Post p = new Post { Content = "Prvi post", CreationDate = DateTime.Now, Title = "Prvi", Upvotes = 5, User = u, Categories = new List<Category> { c } };

                Comment cm = new Comment { Content = "Prvi comment prvega posta", CreationDate = DateTime.Now, Post = p, Upvotes = -10, User = u };

                context.Users.AddOrUpdate(u);
                context.Categories.AddOrUpdate(c);
                context.Posts.AddOrUpdate(p);
                context.Comments.AddOrUpdate(cm);

                context.SaveChanges();
            }

           

            
        }
    }
}
