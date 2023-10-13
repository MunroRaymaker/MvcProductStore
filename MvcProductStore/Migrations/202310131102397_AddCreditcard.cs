namespace MvcProductStore.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddCreditcard : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.CreditCards",
                c => new
                    {
                        CreditCardId = c.Int(nullable: false, identity: true),
                        CardNumber = c.String(),
                        ExpDate = c.String(),
                        CVC = c.String(),
                        CardholderName = c.String(),
                        Amount = c.Decimal(nullable: false, precision: 18, scale: 2),
                        Currency = c.String(),
                        TransactionId = c.String(),
                        OrderId = c.String(),
                        PaymentStatus = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.CreditCardId);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.CreditCards");
        }
    }
}
