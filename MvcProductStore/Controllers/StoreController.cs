using MvcProductStore.Models;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;

namespace MvcProductStore.Controllers
{
    public class StoreController : Controller
    {
        ApplicationDbContext db = new ApplicationDbContext();

        // GET: Store
        public ActionResult Index()
        {
            var categories = db.Categories.ToList();
            return View(categories);
        }

        // GET Store/Browse
        public ActionResult Browse(int categoryId)
        {
            var categoryModel = db.Categories.Include("Products").Single(c => c.CategoryId == categoryId);
            return View(categoryModel);
        }

        // GET Store/Details/5
        public ActionResult Details(int id)
        {
            var product = db.Products.Find(id);
            return View(product);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Search(string q)
        {
            // This is vulnerable to sql injection             
            var results = new List<Product>();

            using (var conn = new SqlConnection(db.Database.Connection.ConnectionString))
            {
                conn.Open();
                var sql = "SELECT ProductId, Name, ImageUrl FROM Products WHERE Name LIKE '%" + q + "%'";
                var cmd = new SqlCommand(sql, conn);

                var reader = cmd.ExecuteReader();
                while(reader.Read())
                {
                    var p = new Product
                    {
                        ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),                        
                        Name = reader.GetString(reader.GetOrdinal("Name")),
                        ImageUrl = reader.GetString(reader.GetOrdinal("ImageUrl"))
                    };
                    results.Add(p);
                }
            }

            return View(results);

            // The proper way to search products
            // var products = db.Products.ToArray();

            // q = q.ToLowerInvariant();

            //if(!string.IsNullOrEmpty(q))
            //{
            //    products = products.Where(p => p.Name.ToLowerInvariant().Contains(q) || 
            //        p.Category.Name.ToLowerInvariant().Contains(q) || 
            //        p.Brand.Name.ToLowerInvariant().Contains(q)).ToArray();
            //}

            //return View(products);
        }

        //
        // GET: /Store/CategoryMenu
        [ChildActionOnly]
        public ActionResult CategoryMenu()
        {
            var categories = db.Categories.ToList();
            return PartialView(categories);
        }
    }
}