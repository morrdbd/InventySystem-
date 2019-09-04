using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Inventory_Manager_Lib;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.IO;

namespace Inventory_Manager_ALKC.IMIS_Pages
{
    public partial class frmProductList : System.Web.UI.Page
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
                obj.fillDll(ddlProductBrand, "BrandName", "BrandID", "SELECT   BrandID, BrandName  FROM IMIS_tblBrand");
                obj.fillDll(ddlProductOrigin, "ProductOriginName", "ProductOriginID", "SELECT ProductOriginID, ProductOriginName FROM  IMIS_tblProductOrigin ");
                obj.fillDll(ddlUnit, "UnitName", "UnitID", "SELECT UnitID, UnitName FROM IMIS_tblUnitOfMeasurement");
                obj.fillDll(ddlSize, "SizeName", "SizeID", "SELECT   SizeID, SizeName, SizeShortName FROM  IMIS_tblSize");
                obj.fillDll(ddlColor, "ColorName", "ColorID", "SELECT   ColorID, ColorName, ColorShortName FROM   IMIS_tblColor");
                obj.fillDll(ddlPacking, "PackingName", "PackingID", "SELECT  PackingID, PackingName FROM   IMIS_tblProductPaking");
                obj.fillDll(ddlProductUsageType, "UsageName", "UsageID", "SELECT    UsageID, UsageName FROM  IMIS_tblProductUsageType");
            }
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<clsProduct> GetProductList()
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        SNO, ProductCode, ProductName, ProductDescription, ProductImagePath,  
                         GroupName, CategoryName, ProductOriginName, SizeName, ColorName, PackingName, UnitName,BrandName,UsageName
FROM            IMIS_VWProducts", con);
            da.Fill(dt);
            IList<clsProduct> lstToReturn = new List<clsProduct>();
            foreach (DataRow r in dt.Rows)
            {
                lstToReturn.Add(new clsProduct
                {
                    SNO =int.Parse(r["SNO"].ToString()),
                    ProductCode = r["ProductCode"].ToString(),
                    ProductName = r["ProductName"].ToString(),
                    UsageName = r["UsageName"].ToString(),
                    GroupName = r["GroupName"].ToString(),
                    CategoryName = r["CategoryName"].ToString(),
                    ProductOriginName = r["ProductOriginName"].ToString(),
                    BrandName = r["BrandName"].ToString(),
                    SizeName = r["SizeName"].ToString(),
                    ColorName = r["ColorName"].ToString(),
                    ProductImagePath = r["ProductImagePath"].ToString().Replace("~/", "../"),
                });
            }
            return lstToReturn;
        }
        
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<clsProduct> GetProductListByName( string ProductName)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        SNO, ProductCode, ProductName, ProductDescription, ProductImagePath,  
                         GroupName, CategoryName, ProductOriginName, SizeName, ColorName, PackingName, UnitName,BrandName,UsageName
FROM            IMIS_VWProducts where ProductName like N'%" + ProductName + "%'", con);
            da.Fill(dt);
            IList<clsProduct> lstToReturn = new List<clsProduct>();
            foreach (DataRow r in dt.Rows)
            {
                lstToReturn.Add(new clsProduct
                {
                    SNO = int.Parse(r["SNO"].ToString()),
                    ProductCode = r["ProductCode"].ToString(),
                    ProductName = r["ProductName"].ToString(),
                    UsageName = r["UsageName"].ToString(),
                    GroupName = r["GroupName"].ToString(),
                    CategoryName = r["CategoryName"].ToString(),
                    ProductOriginName = r["ProductOriginName"].ToString(),
                    BrandName = r["BrandName"].ToString(),
                    SizeName = r["SizeName"].ToString(),
                    ColorName = r["ColorName"].ToString(),
                    ProductImagePath = r["ProductImagePath"].ToString().Replace("~/", "../"),
                });
            }
            return lstToReturn;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<clsProduct> ProductEdit2(clsProduct Obj)
        {
            List<clsProduct> details = new List<clsProduct>();
            DataTable dt = new DataTable();
            SqlParameter[] p = new SqlParameter[1];
            p[0] = new SqlParameter("@SNO", Obj.SNO);
            dt = clsCURD.GetData("IMIS_ProSelectProductBySNO", p);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsProduct obj = new clsProduct();
                obj.SNO = int.Parse(dtrow["SNO"].ToString());
                obj.ProductName = dtrow["ProductName"].ToString();
                obj.ProductDescription = dtrow["ProductDescription"].ToString();
                obj.ProductUsageTypeName = dtrow["ProductUsageTypeName"].ToString();
                obj.ProductBarCode = dtrow["ProductBarCode"].ToString();
                obj.GroupID = int.Parse(dtrow["GroupID"].ToString());
                obj.ProductCategoryID =int.Parse(dtrow["ProductCategoryID"].ToString());
                obj.ProductBrandID =int.Parse(dtrow["ProductBrandID"].ToString());
                obj.ProductOriginID = int.Parse(dtrow["ProductOriginID"].ToString());
                obj.UnitID = int.Parse(dtrow["UnitID"].ToString());
                obj.PackingID = int.Parse(dtrow["PackingID"].ToString());
                obj.UnitID = int.Parse(dtrow["UnitID"].ToString());
                obj.ColorID =int.Parse(dtrow["ColorID"].ToString());
                obj.SizeID = int.Parse(dtrow["SizeID"].ToString());
                obj.SalePrice =float.Parse(dtrow["SalePrice"].ToString());
                obj.SizeID =int.Parse(dtrow["SizeID"].ToString());
                obj.ProductImagePath = dtrow["ProductImagePath"].ToString().Replace("~/", "../");
                details.Add(obj);
            }
            return details;
        }


        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<clsProduct> ProductEdit(string ProductCode)
        {
            string con = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            List<clsProduct> details = new List<clsProduct>();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        SNO, ProductCode, ProductName, ProductDescription, ProductBarCode, ProductCategoryID, ProductBrandID, ProductOriginID, UnitID, PackingID, ColorID, SizeID, ProductImagePath, 
                         UserID, SizeName, CategoryName, GroupName, BrandName, ProductOriginName, UnitName, PackingName, ColorName,GroupID,ProductUsageTypeID
FROM            IMIS_VWProducts
WHERE        ProductCode='" + ProductCode + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsProduct obj = new clsProduct();
                obj.ProductCode = dtrow["ProductCode"].ToString();
                obj.ProductName = dtrow["ProductName"].ToString();
                obj.ProductDescription = dtrow["ProductDescription"].ToString();
                obj.ProductUsageTypeID = int.Parse(dtrow["ProductUsageTypeID"].ToString());
                obj.ProductBarCode = dtrow["ProductBarCode"].ToString();
                obj.GroupID = int.Parse(dtrow["GroupID"].ToString());
                obj.ProductCategoryID = int.Parse(dtrow["ProductCategoryID"].ToString());
                obj.ProductBrandID = int.Parse(dtrow["ProductBrandID"].ToString());
                obj.ProductOriginID = int.Parse(dtrow["ProductOriginID"].ToString());
                obj.UnitID = int.Parse(dtrow["UnitID"].ToString());
                obj.PackingID = int.Parse(dtrow["PackingID"].ToString());
                obj.UnitID = int.Parse(dtrow["UnitID"].ToString());
                obj.ColorID = int.Parse(dtrow["ColorID"].ToString());
                obj.SizeID = int.Parse(dtrow["SizeID"].ToString());
                obj.ProductImagePath = dtrow["ProductImagePath"].ToString().Replace("~/", "../");
                details.Add(obj);
            }
            // Newtonsoft.Json.js
            return details;
        }
        
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void Update(clsProduct Obj)
        {
            try
            {
                SqlParameter[] p = new SqlParameter[15];
                p[0] = new SqlParameter("@ProductName", Obj.ProductName);
                p[1] = new SqlParameter("@ProductDescription", Obj.ProductDescription);
                p[2] = new SqlParameter("@ProductUsageTypeID", Obj.ProductUsageTypeID);
                p[3] = new SqlParameter("@ProductBarCode", Obj.ProductBarCode);
                p[4] = new SqlParameter("@ProductCategoryID", Obj.ProductCategoryID);
                p[5] = new SqlParameter("@ProductBrandID", Obj.ProductBrandID);
                p[6] = new SqlParameter("@ProductOriginID", Obj.ProductOriginID);
                p[7] = new SqlParameter("@UnitID", Obj.UnitID);
                p[8] = new SqlParameter("@PackingID", Obj.PackingID);
                p[9] = new SqlParameter("@ColorID", Obj.ColorID);
                p[10] = new SqlParameter("@SizeID", Obj.SizeID);
                p[11] = new SqlParameter("@SalePrice", Obj.SalePrice);
                if (Obj.ProductImageChange == "Yes")
                {
                    DeletePhoto(Obj.ProductCode);
                    string ext = Path.GetExtension(Obj.ProductImagePath);
                    Obj.ProductImagePath = "~/All-Photo/Product-Images/" + Obj.ProductCode + ext;
                } 
                p[12] = new SqlParameter("@ProductImagePath", Obj.ProductImagePath);
                p[13] = new SqlParameter("@LastUpdateBy", Obj.LastUpdateBy);
                p[14] = new SqlParameter("@ProductCode", Obj.ProductCode);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductUpdate", p);
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

        public static void DeletePhoto(string EmpID)
        {
            string paht = "~/All-Photo/Student-Photo/" + EmpID;
            if (File.Exists(paht + ".jpg"))
            {
                File.Delete(paht + ".jpg");
            }
            else if (File.Exists(paht + ".png"))
            {
                File.Delete(paht + ".png");
            }
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static IList<clsProductCategory> getProductCategory(int Group_ID)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT   CategoryCode, CategoryName FROM   IMIS_tblProductCategory where GroupID=" + Group_ID + "", con);
            da.Fill(dt);
            IList<clsProductCategory> toReturn = dt.ToList<clsProductCategory>();
            return toReturn;
        }
      
    }
}