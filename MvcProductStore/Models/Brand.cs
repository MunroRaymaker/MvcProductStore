using System.ComponentModel;

namespace MvcProductStore.Models
{
    public class Brand
    {
        public int BrandId { get; set; }
        [DisplayName("Brand")]
        public string Name { get; set; }
    }
}