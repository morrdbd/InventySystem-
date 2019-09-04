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
    public partial class frmProduct : System.Web.UI.Page
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

                #region Data Of By Store
                //obj.fillDll(ddlProductGroup, "GroupName", "GroupID", "SELECT  GroupID, GroupName FROM   IMIS_tblProductGroup where StoreID=" + hdStoreID.Value + "");
                //obj.fillDll(ddlProductBrand, "BrandName", "BrandID", "SELECT   BrandID, BrandName  FROM IMIS_tblBrand where StoreID=" + hdStoreID.Value + "");
                //obj.fillDll(ddlProductOrigin, "ProductOriginName", "ProductOriginID", "SELECT ProductOriginID, ProductOriginName FROM  IMIS_tblProductOrigin  where StoreID=" + hdStoreID.Value + "");
                //obj.fillDll(ddlUnit, "UnitName", "UnitID", "SELECT UnitID, UnitName FROM IMIS_tblUnitOfMeasurement where StoreID=" + hdStoreID.Value + "");
                //obj.fillDll(ddlSize, "SizeName", "SizeID", "SELECT   SizeID, SizeName, SizeShortName FROM  IMIS_tblSize where StoreID=" + hdStoreID.Value + "");
                //obj.fillDll(ddlColor, "ColorName", "ColorID", "SELECT   ColorID, ColorName, ColorShortName FROM   IMIS_tblColor where StoreID=" + hdStoreID.Value + "");
                //obj.fillDll(ddlPacking, "PackingName", "PackingID", "SELECT  PackingID, PackingName FROM   IMIS_tblProductPaking where StoreID=" + hdStoreID.Value + "");
                #endregion



            }
        }
        //ProductCode, ProductName, ProductDescription, ProductBarCodeType, ProductBarCode, ProductCategoryID, 
        //ProductBrandID, ProductOriginID, UnitID, PackingID, ColorID, SizeID, SalePrice, ProductImagePath, StoreID, 
        //UserID, SystemDate, LastUpdateBy, LastUpdateDate
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string Insert(clsProduct Obj)
        {
            string ProductCode = GetProductCode();
            try
            {
             
                SqlParameter[] p = new SqlParameter[14];
                p[0] = new SqlParameter("@ProductCode", ProductCode);
                p[1] = new SqlParameter("@ProductName", Obj.ProductName);
                p[2] = new SqlParameter("@ProductDescription", Obj.ProductDescription);
                p[3] = new SqlParameter("@ProductUsageTypeID", Obj.ProductUsageTypeID);
                p[4] = new SqlParameter("@ProductBarCode", Obj.ProductBarCode);
                p[5] = new SqlParameter("@ProductCategoryID", Obj.ProductCategoryID);
                p[6] = new SqlParameter("@ProductBrandID", Obj.ProductBrandID);
                p[7] = new SqlParameter("@ProductOriginID", Obj.ProductOriginID);
                p[8] = new SqlParameter("@UnitID", Obj.UnitID);
                p[9] = new SqlParameter("@PackingID", Obj.PackingID);
                p[10] = new SqlParameter("@ColorID", Obj.ColorID);
                p[11] = new SqlParameter("@SizeID", Obj.SizeID);

                string ext = Path.GetExtension(Obj.ProductImagePath);
                Obj.ProductImagePath = "~/All-Photo/Product-Images/" + ProductCode + ext;
                p[12] = new SqlParameter("@ProductImagePath", Obj.ProductImagePath);
                p[13] = new SqlParameter("@UserID", Obj.UserID);
                clsCURD.ExecuteStoreProcedure("IMIS_ProProductInsert", p);
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
            return ProductCode;
        }
       
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetProductCode()
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"select isnull(max(ProductCode),0)+1 as maxID from IMIS_tblProduct", con);
            da.Fill(dt);
            string Code = dt.Rows[0]["maxID"].ToString();
            if (Code == "")
            {
                return "000000000001";
            }
            int ID = 0;
            int.TryParse(Code, out ID);
            switch (ID.ToString().Length)
            {
                case 1:
                    Code = "00000000000" + ID.ToString();
                    break;
                case 2:
                    Code = "0000000000" + ID.ToString();
                    break;
                case 3:
                    Code = "000000000" + ID.ToString();
                    break;
                case 4:
                    Code = "00000000" + ID.ToString();
                    break;
                case 5:
                    Code = "0000000" + ID.ToString();
                    break;
                case 6:
                    Code = "000000" + ID.ToString();
                    break;
                case 7:
                    Code = "00000" + ID.ToString();
                    break;
                case 8:
                    Code = "0000" + ID.ToString();
                    break;
                case 9:
                    Code = "000" + ID.ToString();
                    break;
                case 10:
                    Code = "00" + ID.ToString();
                    break;
                case 11:
                    Code = "0" + ID.ToString();
                    break;
                case 12:
                    Code = ID.ToString();
                    break;
            }
            return Code;
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
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void InsertProduct(Product Product)
        {
//            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
//            SqlConnection con = new SqlConnection(constr);
//            SqlCommand cmd = new SqlCommand();
//            cmd.Connection = con;
//            string ext = Path.GetExtension(Product.Product_Image_Path);
//            Product.Product_Image_Path = "~/All-Photo/Product-Images/" + Product.Product_Code + ext;
//            string query = @"insert into IMIS_tblProduct(Product_Code, Product_Name, Product_Description, Product_Image_Path, Product_BarCode, Packing, Product_Category_ID, Product_Brand_ID, Product_Origin_ID, Unit_ID, User_ID) 
//			values('" + Product.Product_Code + "', N'" + Product.Product_Name + "', N'" + Product.Product_Description + "', '" + Product.Product_Image_Path + "', '" + Product.Product_BarCode + "', '" + Product.Packing + "', " + Product.Product_Category_ID + ", " + Product.Product_Brand_ID + ", " + Product.Product_Origin_ID + "," + Product.Unit_ID + ", N'" + Product.User_ID + "')";
//            cmd.CommandText = query;
//            con.Open();
//            cmd.ExecuteNonQuery();
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<Product> GetProductList()
        {
//            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
//            SqlConnection con = new SqlConnection(constr);
//            DataTable dt = new DataTable();
//            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        IMIS_tblProduct.Product_Code, IMIS_tblProduct.Product_Name, IMIS_tblProductCategory.Category_Name,IMIS_tblProduct.Packing, 
//                         IMIS_tblUnitOfMeasurement.Unit_Name, IMIS_tblProductOrigin.Product_Origin_Name, IMIS_tblBrand.Brand_Name,
//						 IMIS_tblProduct.Product_Image_Path
//FROM            IMIS_tblProduct INNER JOIN
//                         IMIS_tblUnitOfMeasurement ON IMIS_tblProduct.Unit_ID = IMIS_tblUnitOfMeasurement.Unit_ID INNER JOIN
//                         IMIS_tblProductCategory ON IMIS_tblProduct.Product_Category_ID = IMIS_tblProductCategory.Category_Code INNER JOIN
//                         IMIS_tblBrand ON IMIS_tblProduct.Product_Brand_ID = IMIS_tblBrand.Brand_ID INNER JOIN
//                         IMIS_tblProductOrigin ON IMIS_tblProduct.Product_Origin_ID = IMIS_tblProductOrigin.Product_Origin_ID", con);
//            da.Fill(dt);
            IList<Product> lstToReturn = new List<Product>();
            //foreach (DataRow r in dt.Rows)
            //{
            //    lstToReturn.Add(new Product
            //    {
            //        Product_Code = r["Product_Code"].ToString(),
            //        Product_Name = r["Product_Name"].ToString(),
            //        Category_Name = r["Category_Name"].ToString(),
            //        Packing = r["Packing"].ToString(),
            //        Unit_Name = r["Unit_Name"].ToString(),
            //        Product_Origin_Name = r["Product_Origin_Name"].ToString(),
            //        Brand_Name = r["Brand_Name"].ToString(),
            //        Product_Image_Path = r["Product_Image_Path"].ToString().Replace("~/", "../"),
            //    });
            //}
            return lstToReturn;
        }
    }
}

public class Product
{
   
}