using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ElevenBank.WebMVC.Startup))]
namespace ElevenBank.WebMVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
