using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace MvcProductStore.Models
{
    public class Category
    {
        public int CategoryId { get; set; }
        [DisplayName("Category")]
        public string Name { get; set; }
        public string Description { get; set; }
        public List<Product> Products { get; set; }
    }
}