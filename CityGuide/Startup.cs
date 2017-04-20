using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CityGuide.Startup))]
namespace CityGuide
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
