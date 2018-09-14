using MvcProductStore.Models;
using System.Collections.Generic;

namespace MvcProductStore.ViewModels
{
    public class ShoppingCartViewModel
    {
        public List<Cart> CartItems { get; set; }
        public decimal CartTotal { get; set; }
    }
}