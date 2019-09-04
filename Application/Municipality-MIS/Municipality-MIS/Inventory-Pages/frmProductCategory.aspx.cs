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
    public partial class frmProductCategory : System.Web.UI.Page
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
                obj.fillDll(ddlProductGroup, "GroupName", "GroupID", "SELECT  GroupID, GroupName FROM   IMIS_tblProductGroup");
                obj.fillDll(ddlProductGroupE, "GroupName", "GroupID", "SELECT  GroupID, GroupName FROM   IMIS_tblProductGroup");
            }
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void Insert(clsProductCategory Obj)
        {
            try
            {
                //CategoryName, GroupID, StoreID, UserID
                SqlParameter[] p = new SqlParameter[3];
                p[0] = new SqlParameter("@CategoryName", Obj.CategoryName);
                p[1] = new SqlParameter("@GroupID", Obj.GroupID);
                p[2] = new SqlParameter("@UserID", Obj.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductCategoryInsert", p);
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
        public static void Update(clsProductCategory Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[4];
                p[0] = new SqlParameter("@CategoryCode", Obj.CategoryCode);
                p[1] = new SqlParameter("@CategoryName", Obj.CategoryName);
                p[2] = new SqlParameter("@GroupID", Obj.GroupID);
                p[3] = new SqlParameter("@LastUpdatedBy", Obj.LastUpdatedBy);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductCategoryUpdate", p);
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
        public static IList<clsProductCategory> GetListByStoreID()
        {
            DataTable dt = new DataTable();
            dt = clsCURD.GetData("IMIS_ProProductCategorySelectByStore");
            IList<clsProductCategory> lstToReturn = dt.ToList<clsProductCategory>();
            return lstToReturn;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsProductCategory> EditData(clsProductCategory Obj)
        {
            List<clsProductCategory> details = new List<clsProductCategory>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@CategoryCode", Obj.CategoryCode);
            dt = clsCURD.GetData("[IMIS_ProProductCategorySelectByID]", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsProductCategory obj = new clsProductCategory();
                obj.CategoryCode = int.Parse(dtrow["CategoryCode"].ToString());
                obj.GroupID = int.Parse(dtrow["GroupID"].ToString());
                obj.CategoryName = dtrow["CategoryName"].ToString();
                obj.GroupName = dtrow["GroupName"].ToString();
                details.Add(obj);
            }
            return details;
        }
    }
}