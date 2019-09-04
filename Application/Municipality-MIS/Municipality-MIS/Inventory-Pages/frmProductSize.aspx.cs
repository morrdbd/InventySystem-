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
    public partial class frmProductSize : System.Web.UI.Page
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
        public static void InsertSize(clsProductSize clsProductSize)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@SizeName", clsProductSize.SizeName);
                p[1] = new SqlParameter("@SizeShortName", clsProductSize.SizeShortName);
                p[2] = new SqlParameter("@UserID", clsProductSize.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProSizeInsert", p);
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
        public static void UpdateSize(clsProductSize clsProductSize)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[4];
                p[0] = new SqlParameter("@SizeID", clsProductSize.SizeID);
                p[1] = new SqlParameter("@SizeName", clsProductSize.SizeName);
                p[2] = new SqlParameter("@SizeShortName", clsProductSize.SizeShortName);
                p[3] = new SqlParameter("@LastUpdatedBy", clsProductSize.LastUpdatedBy);
                clsCURD.ExecuteStoreProcedure("IMIS_ProSizeUpdate", p);
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
        public static IList<clsProductSize> GetSizeList()
        {
            DataTable dt = new DataTable();
          
            dt = clsCURD.GetData("IMIS_ProSizeSelect");
            IList<clsProductSize> lstToReturn = dt.ToList<clsProductSize>();
            return lstToReturn;
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsProductSize> EditData(clsProductSize clsProductSize)
        {
            List<clsProductSize> details = new List<clsProductSize>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@SizeID", clsProductSize.SizeID);
            dt = clsCURD.GetData("[IMIS_ProSizeSelectByID]", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsProductSize obj = new clsProductSize();
                obj.SizeID = int.Parse(dtrow["SizeID"].ToString());
                obj.SizeName = dtrow["SizeName"].ToString();
                obj.SizeShortName = dtrow["SizeShortName"].ToString();
                details.Add(obj);
            }
            return details;
        }
    }
}