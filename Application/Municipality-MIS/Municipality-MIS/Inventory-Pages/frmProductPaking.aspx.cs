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
    public partial class frmProductPaking : System.Web.UI.Page
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
        public static void Insert(clsProductPaking Obj)
        {
            try
            {
              
                SqlParameter[] p = new SqlParameter[2];
                p[0] = new SqlParameter("@PackingName", Obj.PackingName);

                p[1] = new SqlParameter("@UserID", Obj.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductPakingInsert", p);
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
        public static void Update(clsProductPaking Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@PackingName", Obj.PackingName);
                p[1] = new SqlParameter("@PackingID", Obj.PackingID);
                p[2] = new SqlParameter("@LastUpdatedBy", Obj.LastUpdatedBy);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductPakingUpdate", p);
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
        public static IList<clsProductPaking> GetListByStoreID()
        {

            DataTable dt = new DataTable();
            dt = clsCURD.GetData("IMIS_ProProductPakingSelectByStoreID");
            IList<clsProductPaking> lstToReturn = dt.ToList<clsProductPaking>();
            return lstToReturn;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsProductPaking> EditData(clsProductPaking Obj)
        {
            List<clsProductPaking> details = new List<clsProductPaking>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@PackingID", Obj.PackingID);
            dt = clsCURD.GetData("[IMIS_ProProductPakingSelectByID]", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsProductPaking obj = new clsProductPaking();
                obj.PackingID = int.Parse(dtrow["PackingID"].ToString());
                obj.PackingName = dtrow["PackingName"].ToString();
                details.Add(obj);
            }
            return details;
        }
    }
}