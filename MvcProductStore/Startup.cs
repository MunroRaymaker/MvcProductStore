using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MvcProductStore.Startup))]
namespace MvcProductStore
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
