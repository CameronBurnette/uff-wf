using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(UFF_wf.Startup))]
namespace UFF_wf
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
