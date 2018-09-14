namespace MvcProductStore.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddsDataAnnotations : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.Products", "Name", c => c.String(nullable: false, maxLength: 160));
            AlterColumn("dbo.Products", "ImageUrl", c => c.String(maxLength: 1024));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.Products", "ImageUrl", c => c.String());
            AlterColumn("dbo.Products", "Name", c => c.String());
        }
    }
}
