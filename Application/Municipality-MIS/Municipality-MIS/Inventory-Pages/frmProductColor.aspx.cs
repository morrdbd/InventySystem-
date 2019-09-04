using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Inventory_Manager_Lib;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web.Script.Services;

namespace Inventory_Manager_ALKC.IMIS_Pages
{
    public partial class frmProductColor : System.Web.UI.Page
    {
        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt_User = obj.GetData(@"SELECT        HRMIS_tblEmployeeInformation.EmployeeID, HRMIS_tblEmployeeInformation.FullName, aspnet_Users.UserId, aspnet_Users.UserName
FROM            HRMIS_tblEmployeeInformation INNER JOIN
                         aspnet_Users ON HRMIS_tblEmployeeInformation.EmployeeID = aspnet_Users.Registration_Number where LoweredUserName=N'" + User.Identity.Name + "'");
                hdUser.Value = dt_User.Rows[0]["UserId"].ToString();
            }
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void Insert(clsProductColor Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@ColorName", Obj.ColorName);
                p[1] = new SqlParameter("@ColorShortName", Obj.ColorShortName);
              
                p[2] = new SqlParameter("@UserID", Obj.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProColorInsert", p);
            }
            catch (SqlException Sexp)
            {

            }
            catch (Exception ex)
            {
            }
            finally
            {

            }
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void Update(clsProductColor Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[4];
                p[0] = new SqlParameter("@ColorName", Obj.ColorName);
                p[1] = new SqlParameter("@ColorShortName", Obj.ColorShortName);
                p[2] = new SqlParameter("@ColorID", Obj.ColorID);
                p[3] = new SqlParameter("@LastUpdatedBy", Obj.LastUpdatedBy);
                clsCURD.ExecuteStoreProcedure("IMIS_ProColorUpdate", p);
            }
            catch (SqlException Sexp)
            {

            }
            catch (Exception ex)
            {
            }
            finally
            {

            }
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<clsProductColor> GetListByStoreID()
        {
            DataTable dt = new DataTable();
            dt = clsCURD.GetData("IMIS_ProColorSelect");
            IList<clsProductColor> lstToReturn = dt.ToList<clsProductColor>();
            return lstToReturn;
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsProductColor> EditData(clsProductColor Obj)
        {
            List<clsProductColor> details = new List<clsProductColor>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@ColorID", Obj.ColorID);
            dt = clsCURD.GetData("[IMIS_ProColorSelectByID]", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsProductColor obj = new clsProductColor();
                obj.ColorID = int.Parse(dtrow["ColorID"].ToString());
                obj.ColorName = dtrow["ColorName"].ToString();
                obj.ColorShortName = dtrow["ColorShortName"].ToString();
                details.Add(obj);
            }
            return details;
        }
    }
}