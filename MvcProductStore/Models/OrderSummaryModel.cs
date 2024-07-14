namespace MvcProductStore.Models
{
    public class OrderSummaryModel
    {
        public decimal SubTotal { get; set; }
        public decimal ShippingCost { get; set; }
        public decimal Total => SubTotal + ShippingCost;
    }
}