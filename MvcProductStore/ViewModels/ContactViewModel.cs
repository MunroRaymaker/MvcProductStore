using System.Web;

namespace MvcProductStore.ViewModels
{
    public class ContactViewModel
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string Subject { get; set; }
        public string Message { get; set; }
        public HttpPostedFileBase File { get; set; }
    }
}