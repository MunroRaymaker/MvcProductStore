using MvcProductStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcProductStore.Controllers
{
    public class HomeController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        public ActionResult Index()
        {
            var topSellers = GetTopSellingProducts(5);

            return View(topSellers);
        }

        private List<Product> GetTopSellingProducts(int count)
        {
            var orders = db.Products.SelectMany(p => p.OrderDetails).ToArray();

            var dict = new Dictionary<int, int>();

            foreach (var item in orders)
            {
                if(dict.ContainsKey(item.ProductId))
                {
                    dict[item.ProductId] = dict[item.ProductId] + item.Quantity;
                }
                else
                {
                    dict.Add(item.ProductId, item.Quantity);
                }
            }


            return db.Products.OrderByDescending(p => p.OrderDetails.Sum(o => o.Quantity))
                .Take(count)
                .ToList();
        }
    }
}