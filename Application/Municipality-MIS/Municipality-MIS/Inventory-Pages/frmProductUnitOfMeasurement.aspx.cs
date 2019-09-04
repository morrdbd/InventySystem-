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
    public partial class frmProductUnitOfMeasurement : System.Web.UI.Page
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
        public static void Insert(clsUnitOfMeasurement Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[2];
                p[0] = new SqlParameter("@UnitName", Obj.UnitName);
                p[1] = new SqlParameter("@UserID", Obj.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProUnitOfMeasurementInsert", p);
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
        public static void Update(clsUnitOfMeasurement Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@UnitName", Obj.UnitName);
                p[1] = new SqlParameter("@UnitID", Obj.UnitID);
                p[2] = new SqlParameter("@LastUpdatedBy", Obj.LastUpdatedBy);
                clsCURD.ExecuteStoreProcedure("IMIS_ProUnitOfMeasurementUpdate", p);
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
        public static IList<clsUnitOfMeasurement> GetListByStoreID()
        {
            DataTable dt = new DataTable();
            dt = clsCURD.GetData("IMIS_ProUnitOfMeasurementSelectByStoreID");
            IList<clsUnitOfMeasurement> lstToReturn = dt.ToList<clsUnitOfMeasurement>();
            return lstToReturn;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsUnitOfMeasurement> EditData(clsUnitOfMeasurement Obj)
        {
            List<clsUnitOfMeasurement> details = new List<clsUnitOfMeasurement>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@UnitID", Obj.UnitID);
            dt = clsCURD.GetData("[IMIS_ProUnitOfMeasurementSelectByID]", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsUnitOfMeasurement obj = new clsUnitOfMeasurement();
                obj.UnitID = int.Parse(dtrow["UnitID"].ToString());
                obj.UnitName = dtrow["UnitName"].ToString();
                details.Add(obj);
            }
            return details;
        }
    }
}