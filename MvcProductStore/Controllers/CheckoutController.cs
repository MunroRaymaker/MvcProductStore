using MvcProductStore.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace MvcProductStore.Controllers
{
    [Authorize]
    public class CheckoutController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();
        const string PromoCode = "FREE";

        // GET: Checkout
        public ActionResult AddressAndPayment()
        {
            return View();
        }

        // POST
        [HttpPost]
        public ActionResult AddressAndPayment(FormCollection values)
        {
            var order = new Order();
            TryUpdateModel(order);

            try
            {
                if(string.Equals(values["PromoCode"], PromoCode, StringComparison.OrdinalIgnoreCase) == false)
                {
                    return View(order);
                }

                order.Username = User.Identity.Name;
                order.OrderDate = DateTime.Now;

                // Save order
                db.Orders.Add(order);
                db.SaveChanges();

                // Process order
                var cart = ShoppingCart.GetCart(this.HttpContext);
                cart.CreateOrder(order);

                return RedirectToAction("Complete", new { id = order.OrderId });
            }
            catch
            {
                // Invalid - redisplay order
                return View(order);
            }            
        }

        public ActionResult Complete(int id)
        {
            // Validate the customer owns this order
            bool isValid = db.Orders.Any(o => o.OrderId == id && o.Username == User.Identity.Name);

            if (isValid)
            {
                return View(id);
            }
            else
            {
                return View("Error");
            }
        }
    }
}