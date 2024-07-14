using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using Bogus;
using MvcProductStore.Identity;
using MvcProductStore.Models;

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
            var summary = ShoppingCart.GetCart(this.HttpContext).GetOrderSummary();
            
            ViewBag.Total = summary.Total;
            ViewBag.SubTotal = summary.SubTotal;
            ViewBag.Shipping = summary.ShippingCost;

            Order fakeData = new Faker<Order>("es")
                .RuleFor(o => o.FirstName, f => f.Person.FirstName)
                .RuleFor(o => o.LastName, f => f.Person.LastName)
                .RuleFor(o => o.Address, f => f.Address.StreetAddress())
                .RuleFor(o => o.City, f => f.Address.City())
                .RuleFor(o => o.Country, f => f.Address.Country())
                .RuleFor(o => o.State, f => f.Address.State())
                .RuleFor(o => o.PostalCode, f => f.Address.ZipCode())
                .RuleFor(o => o.Phone, f => f.Phone.PhoneNumber())
                .RuleFor(o => o.Email, f => f.Person.Email)
                .Generate();

            return View(fakeData);
        }

        // POST
        [HttpPost]
        public ActionResult AddressAndPayment(FormCollection values)
        {
            var order = new Order();
            TryUpdateModel(order);

            try
            {
                if (string.Equals(values["PromoCode"], PromoCode,
                        StringComparison.OrdinalIgnoreCase) == true)
                {
                    return View(order);
                }

                if (string.IsNullOrEmpty(values["CardNumber"]) ||
                    string.IsNullOrEmpty(values["CVC"]) ||
                    string.IsNullOrEmpty(values["ExpDateMonth"]) ||
                    string.IsNullOrEmpty(values["ExpDateYear"]) ||
                    string.IsNullOrEmpty(values["CardholderName"]))
                {
                    return View(order);
                }

                order.Username = User.Identity.Name;
                order.OrderDate = DateTime.Now;
                
                // Save order
                db.Orders.Add(order);
                db.SaveChanges();

                // Process order - needs to be in this order, or else the statement will fail because the order does not exist and no foreign key can be found.
                var cart = ShoppingCart.GetCart(this.HttpContext);
                cart.CreateOrder(order);

                // Update order with totals
                db.SaveChanges();

                // Fake Payment Generator
                Random rnd = new Random();
                var transact = rnd.Next(1000000000, 1200000000);

                // Payment
                using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
                {
                    conn.Open();
                    var sql = @"
                        INSERT INTO [dbo].[CreditCards]
                                   ([CardNumber]
                                   ,[ExpDate]
                                   ,[CVC]
                                   ,[CardholderName]
                                   ,[Amount]
                                   ,[Currency]
                                   ,[TransactionId]
                                   ,[OrderId]
                                   ,[PaymentStatus]
                                   ,[CreatedDate])
                             VALUES
                                   (@CardNumber
                                   ,@ExpDate
                                   ,@CVC
                                   ,@CardholderName
                                   ,@Amount
                                   ,'DKK'
                                   ,@TransactionId
                                   ,@OrderId
                                   ,'AuthorizationApproved'
                                   ,GETDATE())
                        ";

                    decimal total = cart.GetTotal();
                    string expDate = $"{values["ExpDateMonth"]}{values["ExpDateYear"].ToString().Substring(2, 2)}";
                    string cn = values["CardNumber"].ToString().Replace(" ", "");
                    string cvc = values["CVC"];
                    string chn = values["CardholderName"];

                    var cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("CardNumber", cn);
                    cmd.Parameters.AddWithValue("ExpDate", expDate);
                    cmd.Parameters.AddWithValue("CVC", cvc);
                    cmd.Parameters.AddWithValue("CardholderName", chn);
                    cmd.Parameters.AddWithValue("Amount", total);
                    cmd.Parameters.AddWithValue("TransactionId", transact);
                    cmd.Parameters.AddWithValue("OrderId", order.OrderId);
                    cmd.ExecuteNonQuery();
                }

                return RedirectToAction("Complete", new { id = order.OrderId });
            }
            catch (Exception ex)
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