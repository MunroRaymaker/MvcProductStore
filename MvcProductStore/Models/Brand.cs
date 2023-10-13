using System;
using System.ComponentModel;

namespace MvcProductStore.Models
{
    public class Brand
    {
        public int BrandId { get; set; }
        [DisplayName("Brand")]
        public string Name { get; set; }
    }

    public class CreditCard
    {
        public int CreditCardId { get; set; }

        public string CardNumber { get; set; }

        public string ExpDate { get; set; }
        
        public string CVC { get; set; }
        
        public string CardholderName { get; set; }
        
        public decimal Amount { get; set; }
        
        public string Currency { get; set; }

        public string TransactionId { get; set; }

        public string OrderId { get; set; }

        public string PaymentStatus { get; set; }

        public DateTime CreatedDate { get; set; }
    }
}