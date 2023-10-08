using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Web.Mvc;

namespace MvcProductStore.Models
{
    [Bind(Exclude = "ProductId")]
    public class Product
    {
        [ScaffoldColumn(false)]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ProductId { get; set; }
        public string ItemNumber { get; set; }
        [DisplayName("Category")]
        public int CategoryId { get; set; }
        [DisplayName("Brand")]
        public int BrandId { get; set; }
        [Required(ErrorMessage = "A Product Name is required")]
        [StringLength(160)]
        public string Name { get; set; }
        public string Description { get; set; }
        [Range(0.01, 1000.00,
           ErrorMessage = "Price must be between 0.01 and 1000.00")]
        public decimal Price { get; set; }
        public string Currency { get; set; }
        [DisplayName("Image URL")]
        [StringLength(1024)]
        public string ImageUrl { get; set; }
        public virtual Category Category { get; set; } // lazy-load
        public virtual Brand Brand { get; set; } // lazy-load
        public virtual List<OrderDetail> OrderDetails { get; set; }
    }
}