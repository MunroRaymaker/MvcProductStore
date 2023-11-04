using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using MvcProductStore.Identity;
using MvcProductStore.Models;
using MvcProductStore.ViewModels;

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
        public ActionResult Contact()
        {
            return View();
        }

        /*
         * This is unsafe as file extensions are not validated. Anything can be uploaded and because directory browsing 
         * is enabled, scripts can be executed in the uploaded files. Eg. try upload the file shell.aspx.
         */
        [HttpPost]
        public ActionResult Contact(ContactViewModel model)
        {
            if (ModelState.IsValid)
            {
                if (model.File != null && model.File.ContentLength > 0)
                {
                    try
                    {
                        string path = Path.Combine(Server.MapPath("~/Uploads"),
                                                   Path.GetFileName(model.File.FileName));
                        model.File.SaveAs(path);
                    }
                    catch (Exception ex)
                    {
                        ViewBag.Message = ex.Message;
                        return View();
                    }
                }

                // TODO Send email here                

                return View("Confirmation");
            }

            return View();
        }

        [HttpGet]
        public ActionResult Reviews()
        {
            var model = new List<ReviewViewModel>
            {
                new ReviewViewModel { Comment = "Great store!!!", Created = new DateTime(2018, 6, 5), UserName = "Bob Bobbins" },
                new ReviewViewModel { Comment = "I like this store", Created = new DateTime(2018, 10, 12), UserName = "Nabib Halal" },
                new ReviewViewModel { Comment = "How much money are your guys scamming of innocent people?", Created = new DateTime(2019, 1, 2), UserName = "Mr. Tidyman" },
                new ReviewViewModel { Comment = "<img src=x onerror=alert(String.fromCharCode(88,83,83))>", Created = DateTime.Now.AddDays(-14), UserName = "Muhaddi" }
            };

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
            if (model == null)
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
                if (dict.ContainsKey(item.ProductId))
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