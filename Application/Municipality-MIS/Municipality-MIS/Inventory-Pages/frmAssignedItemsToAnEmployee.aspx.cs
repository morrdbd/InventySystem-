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
    public partial class frmAssignedItemsToAnEmployee : System.Web.UI.Page
    {
        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt_User = obj.GetData(@"SELECT        HRMIS_tblEmployeeInformation.EmployeeID, HRMIS_tblEmployeeInformation.FullName, aspnet_Users.UserId, aspnet_Users.UserName
FROM            HRMIS_tblEmployeeInformation INNER JOIN
                         aspnet_Users ON HRMIS_tblEmployeeInformation.EmployeeID = aspnet_Users.Registration_Number where LoweredUserName=N'" + User.Identity.Name + "'");
            hdUser.Value = dt_User.Rows[0]["UserId"].ToString();


            if (!IsPostBack)
                obj.fillDll(ddlProductUsageType, "UsageName", "UsageID", "SELECT    UsageID, UsageName FROM  IMIS_tblProductUsageType");
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
        #region Product Secton
        protected void ddlProductUsageType_DataBound(object sender, EventArgs e)
        {
            ddlProductUsageType.Items.Insert(0, "--د کارېدنه نوعه--");
        }
        public static string ShamsiToGregorian(string shamsiDate)
        {
            //14/09/1396
            string[] date = shamsiDate.Split('/');
            string day = date[0];
            string month = date[1];
            string year = date[2];
            SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand("select dbo.ShamsiToGreg(" + day + "," + month + "," + year + ")", con2);
            if (con2.State == ConnectionState.Closed)
                con2.Open();
            DateTime gd = DateTime.Parse(com.ExecuteScalar().ToString());
            con2.Close();
            return gd.ToString("MM/dd/yyyy");
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<ProductLists> GetProducts(string ProductUsageTypeID)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        IMIS_VWProducts.SNO, IMIS_VWProducts.ProductCode, IMIS_VWProducts.ProductName, IMIS_VWProducts.ProductDescription, IMIS_VWProducts.ProductBarCode, IMIS_VWProducts.ProductCategoryID, 
                         IMIS_VWProducts.ProductBrandID, IMIS_VWProducts.ProductOriginID, IMIS_VWProducts.UnitID, IMIS_VWProducts.PackingID, IMIS_VWProducts.ColorID, IMIS_VWProducts.SizeID, IMIS_VWProducts.ProductImagePath, 
                         IMIS_VWProducts.UserID, IMIS_VWProducts.SizeName, IMIS_VWProducts.CategoryName, IMIS_VWProducts.GroupName, IMIS_VWProducts.BrandName, IMIS_VWProducts.ProductOriginName, IMIS_VWProducts.UnitName, 
                         IMIS_VWProducts.PackingName, IMIS_VWProducts.ColorName, IMIS_VWProducts.GroupID, IMIS_VWProducts.ColorShortName, IMIS_VWProducts.SizeShortName, IMIS_VWProducts.UsageName, 
                         IMIS_VWProducts.ProductUsageTypeID, IMIS_tblStockInHand.Quantity
FROM            IMIS_VWProducts INNER JOIN
                         IMIS_tblStockInHand ON IMIS_VWProducts.ProductCode = IMIS_tblStockInHand.ProductCode
						 where Quantity>0 and ProductUsageTypeID=" + ProductUsageTypeID + "", con);
            da.Fill(dt);
            IList<ProductLists> toReturn = dt.ToList<ProductLists>();
            return toReturn.ToArray();
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<GetProductDetails> GetProductDetail(string ProductCode)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        IMIS_VWProducts.ProductCode, IMIS_VWProducts.ProductName, IMIS_VWProducts.SizeName, IMIS_VWProducts.CategoryName, IMIS_VWProducts.GroupName, IMIS_VWProducts.BrandName, 
                         IMIS_VWProducts.ProductOriginName, IMIS_VWProducts.UnitName, IMIS_VWProducts.PackingName, IMIS_VWProducts.ColorName, IMIS_VWProducts.GroupID, IMIS_VWProducts.ColorShortName, 
                         IMIS_VWProducts.SizeShortName, IMIS_tblStockInHand.AveragePrice
FROM            IMIS_VWProducts INNER JOIN
                         IMIS_tblStockInHand ON IMIS_VWProducts.ProductCode = IMIS_tblStockInHand.ProductCode where IMIS_VWProducts.ProductCode='" + ProductCode + "'", con);
            da.Fill(dt);
            IList<GetProductDetails> lstToReturn = dt.ToList<GetProductDetails>();
            return lstToReturn;
        }
        #endregion
        #region Save Information
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static int InsertPurchaseOrder(AssetAssginMain Main, AssgAssginDetail[] Detail)
        {
            int MainID = GetMaxID("MainID", "IMIS_tblAssignAssetToEmployeeDetail");
            string Date = ShamsiToGregorian(Main.SystemDate.ToString());
            string RequestDate = ShamsiToGregorian(Main.RequestDate.ToString());
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            SqlTransaction tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand();
            cmd.Transaction = tran;
            cmd.Connection = con;
            try
            {
                cmd.CommandText = @"insert into IMIS_tblAssignAssetToEmployeeMain(MainID, EmpID, RequestNumber, RequestByDepartment, RequestDate, TicketNumber, AssgineDepartment, SystemDate, Remarks, UserID) 
                values(" + MainID + ", '" + Main.EmpID + "', N'" + Main.RequestNumber + "', N'" + Main.RequestByDepartment + "', '" + RequestDate + "', N'" + Main.TicketNumber + "', '" + Main.AssgineDepartment + "', '" + Date + "', null, N'" + Main.UserID + "')";
                cmd.ExecuteNonQuery();
                foreach (AssgAssginDetail sod in Detail)
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandText = @"insert into IMIS_tblAssignAssetToEmployeeDetail(MainID, ProductCode, SerialNumber, Quantity, AveragePrice, Total, AssetStatus) 
                    values(" + MainID + ", '" + sod.ProductCode + "', '" + sod.SerialNumber + "', " + sod.Quantity + ", " + sod.AveragePrice + ", " + sod.Total + ", 'Assigned ')";
                    cmd.ExecuteNonQuery();

                    #region Stock Update/Insert
                    DataTable dt_Stock = new DataTable();
                    cmd.CommandText = @"update IMIS_tblStockInHand set Quantity=Quantity-" + sod.Quantity + " where ProductCode='" + sod.ProductCode + "'";
                    cmd.ExecuteNonQuery();
                    #endregion
                }
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
            return MainID;
        }
        public static int GetMaxID(string ColumnName, string TableName)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            try
            {
                int id;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "select isnull(max(" + ColumnName + "),0)+1 from " + TableName + "";
                cmd.Connection = con;
                con.Open();
                return id = int.Parse(cmd.ExecuteScalar().ToString());
            }
            catch (Exception ex)
            {
                throw new Exception("max id error:", ex);
            }
            finally
            {
                con.Close();
            }
        }
        #endregion
    }
    public class GetEmployeeSearch
    {

        public string Employee_ID { set; get; }
        public string ReportingTo { set; get; }
        public int Position_ID { set; get; }
        public int Department_ID { set; get; }
        public string Status { set; get; }
        public string Name { set; get; }
        public string Father_Name { set; get; }
        public string Grand_Father_Name { set; get; }
        public string Name_Local { set; get; }
        public string Father_Name_Local { set; get; }
        public string Grand_Father_Name_Local { set; get; }
        public string Gender { set; get; }
        public string Marital_Status { set; get; }
        public string Photo { set; get; }
        public string OtherId { set; get; }
        public string Date_Of_Birth { set; get; }
        public string Personal_Mobile_Number { set; get; }
        public string Personal_Email_Address { set; get; }
        public string Official_Contact_Number { set; get; }
        public string Official_Email_Address { set; get; }
        public string Emergency_Contact_Relationship { set; get; }
        public string Emergency_Contact_Name { set; get; }
        public string Emergency_Contact_Mobile { set; get; }
        public string National_ID_Card_NO { set; get; }
        public int Education_Grade_ID { set; get; }
        public string Main_Course_of_Study { set; get; }
        public string Specialization { set; get; }
        public string Remarks { set; get; }
        public string User_ID { set; get; }
        public int Permanent_Province_ID { set; get; }
        public int Permanent_District_ID { set; get; }
        public string Permanent_Village { set; get; }
        public int Present_Province_ID { set; get; }
        public int Present_District_ID { set; get; }
        public string Present_Village { set; get; }
        public string SearchType { set; get; }
        public string E_Grade_Name { set; get; }
        public string Present_Province_Name { set; get; }
        public string Present_District_Name { set; get; }
      


    }
    public class ProductLists
    {
        public string ProductCode { set; get; }
        public string ProductName { set; get; }
    }
    public class GetProductDetails
    {
        public string ProductCode { set; get; }
        public string GroupName { set; get; }
        public string ProductOriginName { set; get; }
        public string AveragePrice { set; get; }
    }
    public class AssetAssginMain
    {
        // MainID, EmpID, RequestNumber, RequestByDepartment, RequestDate, TicketNumber, AssgineDepartment, SystemDate, Remarks, UserID
        public int MainID { set; get; }
        public string  EmpID { get; set; }
        public string RequestNumber { get; set; }
        public string RequestByDepartment { set; get; }
        public string RequestDate { set; get; }
        public string TicketNumber { get; set; }
        public string AssgineDepartment { get; set; }
        public string SystemDate { get; set; }
        public string UserID { get; set; }
    }
    public class AssgAssginDetail
    {
        //ID, MainID, ProductCode, SerialNumber, Quantity, AveragePrice, Total, AssetStatus
        public int MainID { set; get; }
        public string ProductCode { get; set; }
        public string SerialNumber { set; get; }
        public float Quantity { set; get; }
        public float AveragePrice { set; get; }
        public float Total { set; get; }
        public string AssetStatus { set; get; }
    }
}


