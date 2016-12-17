namespace Phase2.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial1 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Categories",
                c => new
                    {
                        CategoryId = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false),
                    })
                .PrimaryKey(t => t.CategoryId);
            
            CreateTable(
                "dbo.Comments",
                c => new
                    {
                        CommentId = c.Int(nullable: false, identity: true),
                        Content = c.String(nullable: false),
                        Upvotes = c.Int(nullable: false),
                        CreationDate = c.DateTime(nullable: false),
                        ParentCommentId = c.Int(),
                        Post_PostId = c.Int(),
                        User_UserId = c.Int(),
                    })
                .PrimaryKey(t => t.CommentId)
                .ForeignKey("dbo.Comments", t => t.ParentCommentId)
                .ForeignKey("dbo.Posts", t => t.Post_PostId)
                .ForeignKey("dbo.Users", t => t.User_UserId)
                .Index(t => t.ParentCommentId)
                .Index(t => t.Post_PostId)
                .Index(t => t.User_UserId);
            
            CreateTable(
                "dbo.PostCategories",
                c => new
                    {
                        Post_PostId = c.Int(nullable: false),
                        Category_CategoryId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Post_PostId, t.Category_CategoryId })
                .ForeignKey("dbo.Posts", t => t.Post_PostId, cascadeDelete: true)
                .ForeignKey("dbo.Categories", t => t.Category_CategoryId, cascadeDelete: true)
                .Index(t => t.Post_PostId)
                .Index(t => t.Category_CategoryId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Comments", "User_UserId", "dbo.Users");
            DropForeignKey("dbo.Comments", "Post_PostId", "dbo.Posts");
            DropForeignKey("dbo.Comments", "ParentCommentId", "dbo.Comments");
            DropForeignKey("dbo.PostCategories", "Category_CategoryId", "dbo.Categories");
            DropForeignKey("dbo.PostCategories", "Post_PostId", "dbo.Posts");
            DropIndex("dbo.PostCategories", new[] { "Category_CategoryId" });
            DropIndex("dbo.PostCategories", new[] { "Post_PostId" });
            DropIndex("dbo.Comments", new[] { "User_UserId" });
            DropIndex("dbo.Comments", new[] { "Post_PostId" });
            DropIndex("dbo.Comments", new[] { "ParentCommentId" });
            DropTable("dbo.PostCategories");
            DropTable("dbo.Comments");
            DropTable("dbo.Categories");
        }
    }
}
