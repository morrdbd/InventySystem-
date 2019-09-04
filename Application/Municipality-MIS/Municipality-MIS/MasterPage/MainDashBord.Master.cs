using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Municipality_MIS.MasterPage
{
    public partial class MainDashBord : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                lblUserName.Text = "|ښه رغلاست" + HttpContext.Current.User.Identity.Name.ToUpper();
            }
        }
    }
}