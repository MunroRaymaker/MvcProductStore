using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace MvcProductStore.Models
{
    public class Brand
    {
        public int BrandId { get; set; }
        [DisplayName("Brand")]
        public string Name { get; set; }
    }
}