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
    public partial class frmPurchase : System.Web.UI.Page
    {
        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {

            DataTable dt_User = obj.GetData(@"SELECT        HRMIS_tblEmployeeInformation.EmployeeID, HRMIS_tblEmployeeInformation.FullName, aspnet_Users.UserId, aspnet_Users.UserName
FROM            HRMIS_tblEmployeeInformation INNER JOIN
                         aspnet_Users ON HRMIS_tblEmployeeInformation.EmployeeID = aspnet_Users.Registration_Number where LoweredUserName=N'" + User.Identity.Name + "'");
            hdUser.Value = dt_User.Rows[0]["UserId"].ToString();


            if(!IsPostBack)
                obj.fillDll(ddlProductUsageType, "UsageName", "UsageID", "SELECT    UsageID, UsageName FROM  IMIS_tblProductUsageType");
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetOrderNo()
        {
            Int64 ID = 0;
            String Code = "";
            string str_value = "";
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"select isnull(MAX(right(OrderNumber,6)),0) as maxID from tblStockInMain", con);
            da.Fill(dt);
            //string ordermID = dt.Rows[0]["maxID"].ToString();
            if ((dt.Rows[0][0].ToString()) == "")
            {
                ID = 0;
            }
            else
            {
                str_value = dt.Rows[0]["maxID"].ToString();
                ID = Int64.Parse(str_value);
            }
            ID = ID + 1;
            {
                string IDL = ID.ToString();
                switch (IDL.Length)
                {
                    case 1:
                        Code = "PO0000000" + ID.ToString();
                        break;
                    case 2:
                        Code = "PO000000" + ID.ToString();
                        break;
                    case 3:
                        Code = "PO00000" + ID.ToString();
                        break;
                    case 4:
                        Code = "PO0000" + ID.ToString();
                        break;
                    case 5:
                        Code = "PO000" + ID.ToString();
                        break;
                    case 6:
                        Code = "PO00" + ID.ToString();
                        break;
                    case 7:
                        Code = "PO0" + ID.ToString();
                        break;
                    case 8:
                        Code = "PO" + ID.ToString();
                        break;
                }
            }
            return Code;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<ProductList> GetProducts(string ProductUsageTypeID)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        SNO, ProductCode, ProductName, ProductDescription, ProductBarCode, ProductCategoryID, ProductBrandID, ProductOriginID, UnitID, PackingID, ColorID, SizeID, ProductImagePath, UserID, SizeName, CategoryName, 
                         GroupName, BrandName, ProductOriginName, UnitName, PackingName, ColorName, GroupID, ColorShortName, SizeShortName, UsageName, ProductUsageTypeID
FROM            IMIS_VWProducts where ProductUsageTypeID=" + ProductUsageTypeID + "", con);
            da.Fill(dt);
            IList<ProductList> toReturn = dt.ToList<ProductList>();
            return toReturn.ToArray();
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<GetProductDetail> GetProductDetail(string ProductCode)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        SNO, ProductCode, ProductName, ProductDescription, ProductBarCode, ProductCategoryID, ProductBrandID, ProductOriginID, UnitID, PackingID, ColorID, SizeID, ProductImagePath, UserID, SizeName, CategoryName, 
                         GroupName, BrandName, ProductOriginName, UnitName, PackingName, ColorName, GroupID, ColorShortName, SizeShortName, UsageName, ProductUsageTypeID
FROM            IMIS_VWProducts where ProductCode='" + ProductCode + "'", con);
            da.Fill(dt);
            IList<GetProductDetail> lstToReturn = dt.ToList<GetProductDetail>();
            return lstToReturn;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static int InsertPurchaseOrder(PurchaseOrder_Save PurchaseOrder_Save, PurchaseOrderDetail_Save[] PurchaseOrderDetail_Save)
        {
            //string OrderNo = GetOrderNo();
            int MainID = GetMaxID("Main_ID", "IMIS_tblStockInMain");
             string Date = ShamsiToGregorian(PurchaseOrder_Save.Date.ToString());
             string ext = Path.GetExtension(PurchaseOrder_Save.ScanPath);
             PurchaseOrder_Save.ScanPath = "~/All-Photo/Purchase-ScanFiles/" + MainID + ext;
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            SqlTransaction tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand();
            cmd.Transaction = tran;
            cmd.Connection = con;
            try
            {
                cmd.CommandText = @"insert into IMIS_tblStockInMain( Main_ID, OrderNumber,M7Number, ScanPath, Date, GrandTotal, UserID) values( " + MainID + ", '"+PurchaseOrder_Save.OrderNumber+"','" + PurchaseOrder_Save.M7Number + "', '" + PurchaseOrder_Save.ScanPath + "', '" + Date + "', " + PurchaseOrder_Save.GrandTotal + ", '" + PurchaseOrder_Save.User_ID + "')";
                cmd.ExecuteNonQuery();
                foreach (PurchaseOrderDetail_Save sod in PurchaseOrderDetail_Save)
                {
                    if (con.State == ConnectionState.Closed)
                        con.Open();
                    cmd.CommandText = @"insert into IMIS_tblStockInDetail( Main_ID, ProductCode, Qty, Price, Total, Status) values(" + MainID + ", '" + sod.ProductCode + "', " + sod.Quantity + ", " + sod.Price + ", " + sod.Total + ", 'Purchase')";
                    cmd.ExecuteNonQuery();

                    #region Stock Update/Insert
                    DataTable dt_Stock = new DataTable();
                    cmd.CommandText = @"SELECT  SNO, ProductCode, Quantity, AveragePrice,isnull(Quantity,0)*isnull(AveragePrice,0) as TotalStockPrice
FROM            IMIS_tblStockInHand where ProductCode='" + sod.ProductCode + "'";
                    SqlDataAdapter da1 = new SqlDataAdapter(cmd);
                    da1.Fill(dt_Stock);
                    //Condation for item exist in the stock or not
                    if (dt_Stock.Rows.Count > 0)
                    {
                        Decimal New_Qty = 0;
                        Decimal Old_Total = 0;
                        Decimal New_Total = 0;
                        Decimal total_qty = 0;
                        Decimal Avg_Price = 0;
                        New_Qty = Decimal.Parse(sod.Quantity.ToString());
                        New_Total = New_Qty * Decimal.Parse(sod.Price.ToString());
                        Old_Total = Decimal.Parse(dt_Stock.Rows[0]["TotalStockPrice"].ToString());
                        total_qty = Decimal.Parse(dt_Stock.Rows[0]["Quantity"].ToString()) + New_Qty;
                        Avg_Price = (New_Total + Old_Total) / total_qty;
                        cmd.CommandText = @"update IMIS_tblStockInHand set Quantity=Quantity+" + New_Qty + ",AveragePrice=" + Avg_Price + " where ProductCode='" + sod.ProductCode+ "'";
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        if (con.State == ConnectionState.Closed)
                            con.Open();
                        //only insert logic is here..
                        cmd.CommandText = @"insert into IMIS_tblStockInHand(ProductCode, Quantity, AveragePrice)
                        values('" + sod.ProductCode + "', " + sod.Quantity + "," + sod.Price + ")";
                        cmd.ExecuteNonQuery();
                    }
                    //end Condation for item exist in the stock or not
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

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void SetAvgPrice()
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter da = new SqlDataAdapter("select * from IMIS_tblPurchaseOrderDetail where Purchase_Order_No=(select MAX(Purchase_Order_No) from IMIS_tblPurchaseOrderMain)", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            foreach (DataRow dr in dt.Rows)
            {
                Decimal AvgPrice = GetAveragePrice(dr["Product_Code"].ToString(), dr["Purchase_Order_No"].ToString());
                string Query = "update IMIS_tblStock set Average_Price=" + AvgPrice + " where Product_Code='" + dr["Product_Code"].ToString() + "'";
                cmd.CommandText = Query;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        private static Decimal GetAveragePrice(string Product_Code, string Purchase_Order_No)
        {
            Decimal ToReturn = 0;
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"select  isnull((sum(Quantity*Base_Currency_Price)/ sum(Quantity)),0) as Avg_Price  from IMIS_tblPurchaseOrderDetail where Product_Code='" + Product_Code + "'", con);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ToReturn = Decimal.Parse(dt.Rows[0]["Avg_Price"].ToString());
            }
            return ToReturn;
        }
        private static Decimal SetQuantity(string Product_Code, Decimal NewQty, Decimal NewRate)
        {
            Decimal ToReturn = 0;
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT  Product_Code,Average_Price, isnull(sum(Quantity),0) as Total_Qty   FROM  IMIS_tblStock where Product_Code='" + Product_Code + "' group by Product_Code,Average_Price", con);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Decimal total_qty = Decimal.Parse(dt.Rows[0]["Total_Qty"].ToString()) + NewQty;
                Decimal New_Total = NewQty * NewRate;
                Decimal Old_Total = (Decimal.Parse(dt.Rows[0]["Average_Price"].ToString()) * Decimal.Parse(dt.Rows[0]["Total_Qty"].ToString()));
                ToReturn = (New_Total + Old_Total) / total_qty;
            }
            else
                ToReturn = NewRate;
            return ToReturn;
        }
        private static Decimal Get_Base_Currency_Price(Decimal Price, int Currency_ID, Decimal ExchangeRate)
        {
            Decimal BasePrice = 0;
            String Operator = "";
            Decimal Total = 0;
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt_cr = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT  Currency_ID, Currency_Name, Exchange_Operator, Is_Base_Currency FROM  tblCurrency where Currency_ID=" + Currency_ID + "", con);
            da.Fill(dt_cr);
            if (dt_cr.Rows.Count > 0)
            {
                Operator = dt_cr.Rows[0]["Exchange_Operator"].ToString();
                if (dt_cr.Rows[0]["Is_Base_Currency"].ToString() == "Yes")
                {
                    BasePrice = Price;
                }
                else
                {
                    if (Operator == "*")
                        BasePrice = Price * ExchangeRate;
                    else if (Operator == "/")
                        BasePrice = Price / ExchangeRate;
                }
            }
            return BasePrice;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetCurrencyExchangeRateInfo(string Currency_ID)
        {
            string UOM = "0";
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT  Currency_ID, isnull(Exchange_Rate,0) as Exchange_Rate FROM FMIS_tblCurrencyExchangeRate where ID=(select max(ID) from FMIS_tblCurrencyExchangeRate where Currency_ID=" + Currency_ID + ")", con);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                UOM = dt.Rows[0]["Exchange_Rate"].ToString();
            }
            return UOM;
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
    }
}
public class PurchaseOrder_Save
{
    public string Main_ID { set; get; }
    public string OrderNumber { set; get; }
    public string M7Number { set; get; }
    public string Date { set; get; }
    public Decimal GrandTotal { set; get; }
    public string User_ID { set; get; }
    public string ScanPath { set; get; }
}
public class PurchaseOrderDetail_Save
{
    public string Main_ID { set; get; }
    public string ProductCode { set; get; }
    public Decimal Price { set; get; }
    public Decimal Quantity { set; get; }
    public Decimal Total { set; get; }
    public string Status { set; get; }
    public string UserID { set; get; }

}

public class ProductList
{
    public string ProductCode { set; get; }
    public string ProductName { set; get; }
}
public class GetProductDetail
{
    public string ProductCode { set; get; }
    public string GroupName { set; get; }
    public string ProductOriginName { set; get; }
  
}