using System.Collections.Generic;

namespace MvcProductStore.Models
{
    public class ProductStoreInitializer : System.Data.Entity.DropCreateDatabaseIfModelChanges<ApplicationDbContext>
    {
        protected override void Seed(ApplicationDbContext context)
        {
            var brands = new List<Brand>
            {
                new Brand{ BrandId = 1, Name = "Hugo Boss"},
                new Brand{ BrandId = 2, Name = "Lancôme"},
                new Brand{ BrandId = 3, Name = "Bacardi"},
                new Brand{ BrandId = 4, Name = "Toms"}
            };

            brands.ForEach(b => context.Brand.Add(b));
            context.SaveChanges();

            var categories = new List<Category>
            {
                new Category{ CategoryId = 10, Name = "Perfume & Cosmetics", Description = "A Selection of Perfumes for the discerning user" },
                new Category{ CategoryId = 20, Name = "Spirits", Description = "A Selection of Spirits for the discerning user" },
                new Category{ CategoryId = 30, Name = "Boutique", Description = "A Selection of Boutique for the discerning user" },
                new Category{ CategoryId = 40, Name = "Tobacco", Description = "A Selection of Tobacco for the discerning user" },
                new Category{ CategoryId = 50, Name = "Confectionary", Description = "A Selection of Confectionary for the discerning user" }
            };

            categories.ForEach(c => context.Categories.Add(c));
            context.SaveChanges();

            var products = new List<Product>
            {
                new Product{ ItemNumber = "1000", CategoryId = 10, Description = "Boss Bottled 3 x 100g Deosticks", Currency = "DKK", Price = 99.0m, Name = "Boss Deostick sampak", ImageUrl = "/images/products/1000.png", BrandId = 1 },
                new Product{ ItemNumber = "1001", CategoryId = 10, Description = "Lancome mascara", Currency = "DKK", Price = 199.0m, Name = "Lancôme mascara", ImageUrl = "/images/products/1001.png", BrandId = 2 },
                new Product{ ItemNumber = "1002", CategoryId = 20, Description = "Bacardi Old Spice", Currency = "DKK", Price = 99.0m, Name = "Bacardi Old Spice", ImageUrl = "/images/products/1002.png", BrandId = 3 },
                new Product{ ItemNumber = "1003", CategoryId = 30, Description = "Badelagen", Currency = "DKK", Price = 99.0m, Name = "Badelagen", ImageUrl = "/images/products/1003.png", BrandId = 3 },
                new Product{ ItemNumber = "1004", CategoryId = 50, Description = "Toms chokoladefrøer", Currency = "DKK", Price = 99.0m, Name = "Toms chokoladefrøer", ImageUrl = "/images/products/1004.png", BrandId = 4 }
            };

            products.ForEach(p => context.Products.Add(p));
            context.SaveChanges();

            base.Seed(context);
        }
    }
}