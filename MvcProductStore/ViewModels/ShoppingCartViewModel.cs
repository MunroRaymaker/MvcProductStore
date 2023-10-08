using System.Collections.Generic;
using MvcProductStore.Models;

namespace MvcProductStore.ViewModels
{
    public class ShoppingCartViewModel
    {
        public List<Cart> CartItems { get; set; }
        public decimal CartTotal { get; set; }
    }
}