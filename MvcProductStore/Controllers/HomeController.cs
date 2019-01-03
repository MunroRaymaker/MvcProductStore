using MvcProductStore.Models;
using MvcProductStore.ViewModels;
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

        [HttpGet]
        public ActionResult Reviews()
        {
            var model = new List<ReviewViewModel>();
            model.Add(new ReviewViewModel { Comment = "Great store!!!", Created = new DateTime(2018,6,5), UserName = "Bob Bobbins" });
            model.Add(new ReviewViewModel { Comment = "I like this store", Created = new DateTime(2018,10,12), UserName = "Nabib Halal" });
            model.Add(new ReviewViewModel { Comment = "How much money are your guys scamming of innocent people?", Created = new DateTime(2019,1,2), UserName = "Mr. Tidyman" });

            Session["reviews"] = model;

            return View(model);
        }

        /* This is vulnerable to XSS attacks
           Things to try https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XSS%20injection:
          
           Basic payload
            <script>alert('XSS')</script>
            <scr<script>ipt>alert('XSS')</scr<script>ipt>
            "><script>alert('XSS')</script>
            "><script>alert(String.fromCharCode(88,83,83))</script>
                    
           Img payload
            <img src=x onerror=alert('XSS');>
            <img src=x onerror=alert('XSS')//
            <img src=x onerror=alert(String.fromCharCode(88,83,83));>
            <img src=x oneonerrorrror=alert(String.fromCharCode(88,83,83));>
            <img src=x:alert(alt) onerror=eval(src) alt=xss>
            "><img src=x onerror=alert('XSS');>
            "><img src=x onerror=alert(String.fromCharCode(88,83,83));>
          
         */
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Reviews(FormCollection form)
        {
            var model = Session["reviews"] as List<ReviewViewModel>;
            if(model == null)
            {
                model = new List<ReviewViewModel>();
            }
            
            string user = form["userName"];
            string comment = form["comment"];

            model.Add(new ReviewViewModel { Comment = comment, UserName = user, Created = DateTime.Now });
            Session["reviews"] = model;

            return View(model);
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