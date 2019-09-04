using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Inventory_Manager_Lib;
namespace Municipality_MIS.Inventory_Pages
{
    public partial class frmAssetsListOfEmployee : System.Web.UI.Page
    {
        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt_User = obj.GetData(@"SELECT        HRMIS_tblEmployeeInformation.EmployeeID, HRMIS_tblEmployeeInformation.FullName, aspnet_Users.UserId, aspnet_Users.UserName
FROM            HRMIS_tblEmployeeInformation INNER JOIN
                         aspnet_Users ON HRMIS_tblEmployeeInformation.EmployeeID = aspnet_Users.Registration_Number where LoweredUserName=N'" + User.Identity.Name + "'");
            hdUser.Value = dt_User.Rows[0]["UserId"].ToString();
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<GetEmployeeSearch> GetEmployeeInfo(string EmpID)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployeeSearch> details = new List<GetEmployeeSearch>();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "HRMIS_ProGetEmployeeInfoByEmpID";
            cmd.Parameters.Add("@Employee_ID", SqlDbType.NVarChar).Value = EmpID;
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                GetEmployeeSearch obj = new GetEmployeeSearch();
                obj.Employee_ID = dtrow["EmployeeID"].ToString();
                obj.Name = dtrow["Name"].ToString();
                obj.Father_Name = dtrow["Father_Name"].ToString();
                obj.Grand_Father_Name = dtrow["Grand_Father_Name"].ToString();
                details.Add(obj);
            }
            // Newtonsoft.Json.js
            return details;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<GetEmployeeSearch> EmpAdvanceSearchByName(GetEmployeeSearch Employee)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployeeSearch> details = new List<GetEmployeeSearch>();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "HRMIS_ProEmpAdvanceSearchByName";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = Employee.Name;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                GetEmployeeSearch obj = new GetEmployeeSearch();
                obj.Employee_ID = dtrow["EmployeeID"].ToString();
                obj.Name = dtrow["Name"].ToString();
                obj.Father_Name = dtrow["Father_Name"].ToString();
                obj.Grand_Father_Name = dtrow["Grand_Father_Name"].ToString();
                obj.Gender = dtrow["Gender"].ToString();
                obj.Personal_Mobile_Number = dtrow["PersonalMobileNumber"].ToString();
                obj.E_Grade_Name = dtrow["E_Grade_Name"].ToString();
                obj.Main_Course_of_Study = dtrow["MainCourseofStudy"].ToString();
                obj.Specialization = dtrow["Specialization"].ToString();
                obj.Present_Province_Name = dtrow["Present_Province_Name"].ToString();
                obj.Present_District_Name = dtrow["Present_District_Name"].ToString();
                obj.Present_Village = dtrow["PresentVillage"].ToString();
                details.Add(obj);
            }
            return details;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<clsAssetsOfEmployee> AssetsListOfEmployee(string EmpID)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<clsAssetsOfEmployee> details = new List<clsAssetsOfEmployee>();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT       ID, ProductCode, ProductName, SerialNumber, Quantity, AveragePrice, Total
FROM            IMIS_VWEmployeeAsset where AssetStatus = 'Assigned' and ProductUsageTypeID=2 and  EmployeeID='" + EmpID + "'";
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsAssetsOfEmployee obj = new clsAssetsOfEmployee();
                obj.ID = dtrow["ID"].ToString();
                obj.ProductCode = dtrow["ProductCode"].ToString();
                obj.ProductName = dtrow["ProductName"].ToString();
                obj.SerialNumber = dtrow["SerialNumber"].ToString();
                obj.Quantity = dtrow["Quantity"].ToString();
                obj.AveragePrice = dtrow["AveragePrice"].ToString();
                obj.Total = dtrow["Total"].ToString();
                details.Add(obj);
            }
            return details;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<clsAssetsOfEmployee> AssetEdit(string ID)
        {
            string con = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            List<clsAssetsOfEmployee> details = new List<clsAssetsOfEmployee>();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT       ID, ProductCode, ProductName + ' , ' + SerialNumber AS ProductName, Quantity, AveragePrice, Total
FROM            IMIS_VWEmployeeAsset where ID = "+ID+"", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsAssetsOfEmployee obj = new clsAssetsOfEmployee();
                obj.ID = dtrow["ID"].ToString();
                obj.ProductCode = dtrow["ProductCode"].ToString();
                obj.ProductName = dtrow["ProductName"].ToString();
                obj.Quantity = dtrow["Quantity"].ToString();
                obj.AveragePrice = dtrow["AveragePrice"].ToString();
                obj.Total = dtrow["Total"].ToString();
                details.Add(obj);
            }
            // Newtonsoft.Json.js
            return details;
        }


        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void ReturnAsset(clsAssetsOfEmployee Asset)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            SqlTransaction tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand();
            cmd.Transaction = tran;
            cmd.Connection = con;
            try
            {
                cmd.CommandText = @"update IMIS_tblAssignAssetToEmployeeDetail set AssetStatus='Returned',ReturnDate=getdate(),ReturnRemarks=N'" + Asset.ReturnRemarks + "',ReturnBy=N'" + Asset.ReturnBy + "' where ID=" + Asset.ID + "";
                cmd.ExecuteNonQuery();

                #region Stock Update/Insert
                DataTable dt_Stock = new DataTable();
                cmd.CommandText = @"update IMIS_tblStockInHand set Quantity=Quantity+" + Asset.Quantity + " where ProductCode='" + Asset.ProductCode + "'";
                cmd.ExecuteNonQuery();
                #endregion
                
                
                tran.Commit();
            }
            catch (SqlException Sexp)
            {
                tran.Rollback();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
            }
            finally
            {
                con.Close();
            }
        }

    }
}