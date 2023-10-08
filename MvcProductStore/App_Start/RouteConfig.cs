using System.Web.Mvc;
using System.Web.Routing;

namespace MvcProductStore
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            // HIde this to make the directory discovery more difficult
            routes.MapRoute(
                name: "Admin",
                url: "admin",
                defaults: new { controller = "StoreManager", action = "Index" }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
