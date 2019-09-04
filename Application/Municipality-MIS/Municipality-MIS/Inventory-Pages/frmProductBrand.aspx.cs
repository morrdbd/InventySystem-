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
    public partial class frmProductBrand : System.Web.UI.Page
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
        public static void Insert(clsBrand Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[2];
                p[0] = new SqlParameter("@BrandName", Obj.BrandName);
                p[1] = new SqlParameter("@UserID", Obj.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProBrandInsert", p);
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
        public static void Update(clsBrand Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@BrandName", Obj.BrandName);
                p[1] = new SqlParameter("@BrandID", Obj.BrandID);
                p[2] = new SqlParameter("@LastUpdatedBy", Obj.LastUpdatedBy);
                clsCURD.ExecuteStoreProcedure("IMIS_ProBrandUpdate", p);
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
        public static IList<clsBrand> GetListByStoreID()
        {
            DataTable dt = new DataTable();
            dt = clsCURD.GetData("IMIS_ProBrandSelectByStoreID");
            IList<clsBrand> lstToReturn = dt.ToList<clsBrand>();
            return lstToReturn;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsBrand> EditData(clsBrand Obj)
        {
            List<clsBrand> details = new List<clsBrand>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@BrandID", Obj.BrandID);
            dt = clsCURD.GetData("[IMIS_ProBrandSelectByID]", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsBrand obj = new clsBrand();
                obj.BrandID = int.Parse(dtrow["BrandID"].ToString());
                obj.BrandName = dtrow["BrandName"].ToString();
                details.Add(obj);
            }
            return details;
        }
    }
}