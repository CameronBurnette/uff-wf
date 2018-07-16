using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UFF_wf
{
    public partial class ManagePolls : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void UpdateControls()
        {
            Response.Redirect(Request.RawUrl);
        }
    }
}