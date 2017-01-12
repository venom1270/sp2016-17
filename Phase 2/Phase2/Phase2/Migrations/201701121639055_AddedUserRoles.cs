namespace Phase2.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedUserRoles : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.UserRoles",
                c => new
                    {
                        UserRoleId = c.Int(nullable: false, identity: true),
                        RoleTitle = c.String(nullable: false),
                    })
                .PrimaryKey(t => t.UserRoleId);
            
            AddColumn("dbo.Users", "Role_UserRoleId", c => c.Int());
            CreateIndex("dbo.Users", "Role_UserRoleId");
            AddForeignKey("dbo.Users", "Role_UserRoleId", "dbo.UserRoles", "UserRoleId");
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Users", "Role_UserRoleId", "dbo.UserRoles");
            DropIndex("dbo.Users", new[] { "Role_UserRoleId" });
            DropColumn("dbo.Users", "Role_UserRoleId");
            DropTable("dbo.UserRoles");
        }
    }
}
