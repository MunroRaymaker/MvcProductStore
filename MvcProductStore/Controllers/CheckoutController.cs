using MvcProductStore.Models;
using System;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;

namespace MvcProductStore.Controllers
{
    [Authorize]
    public class CheckoutController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();
        //const string PromoCode = "FREE";

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
                if( string.IsNullOrEmpty(values["CardNumber"]) || 
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

                // Process order
                var cart = ShoppingCart.GetCart(this.HttpContext);
                cart.CreateOrder(order);

                // Fake Payment Generator
                Random rnd = new Random();
                var transact = rnd.Next(1000000000, 1200000000);

                // Payment
                using (var conn = new SqlConnection(db.Database.Connection.ConnectionString))
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
                    string cn = values["CardNumber"].ToString().Replace(" ","");
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
            catch(Exception ex)
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