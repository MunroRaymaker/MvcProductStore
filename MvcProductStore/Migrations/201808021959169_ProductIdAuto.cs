namespace MvcProductStore.Migrations
{
    using System.Data.Entity.Migrations;

    public partial class ProductIdAuto : DbMigration
    {
        public override void Up()
        {
            DropPrimaryKey("dbo.Products");
            AlterColumn("dbo.Products", "ProductId", c => c.Int(nullable: false, identity: true));
            AddPrimaryKey("dbo.Products", "ProductId");
        }

        public override void Down()
        {
            DropPrimaryKey("dbo.Products");
            AlterColumn("dbo.Products", "ProductId", c => c.Int(nullable: false));
            AddPrimaryKey("dbo.Products", "ProductId");
        }
    }
}
