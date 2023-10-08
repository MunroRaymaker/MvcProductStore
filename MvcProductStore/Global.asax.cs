using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using MvcProductStore.Models;

namespace MvcProductStore
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            // This is necessary to seed the database with data
            System.Data.Entity.Database.SetInitializer(new ProductStoreInitializer());

            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}
