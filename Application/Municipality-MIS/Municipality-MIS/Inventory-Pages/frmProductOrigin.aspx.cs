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
    public partial class frmProductOrigin : System.Web.UI.Page
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
        public static void Insert(clsOrigin Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[2];
                p[0] = new SqlParameter("@ProductOriginName", Obj.ProductOriginName);
                p[1] = new SqlParameter("@UserID", Obj.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductOriginInsert", p);
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
        public static void Update(clsOrigin Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@ProductOriginName", Obj.ProductOriginName);
                p[1] = new SqlParameter("@ProductOriginID", Obj.ProductOriginID);
                p[2] = new SqlParameter("@LastUpdatedBy", Obj.LastUpdatedBy);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductOriginUpdate", p);
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
        public static IList<clsOrigin> GetListByStoreID()
        {
            DataTable dt = new DataTable();
            dt = clsCURD.GetData("IMIS_ProProductOriginSelectByStore");
            IList<clsOrigin> lstToReturn = dt.ToList<clsOrigin>();
            return lstToReturn;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsOrigin> EditData(clsOrigin Obj)
        {
            List<clsOrigin> details = new List<clsOrigin>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@ProductOriginID", Obj.ProductOriginID);
            dt = clsCURD.GetData("[IMIS_ProProductOriginSelectByID]", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsOrigin obj = new clsOrigin();
                obj.ProductOriginID = int.Parse(dtrow["ProductOriginID"].ToString());
                obj.ProductOriginName = dtrow["ProductOriginName"].ToString();

                details.Add(obj);
            }
            return details;
        }
    }
}