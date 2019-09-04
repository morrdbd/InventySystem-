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
    public partial class frmPC5 : System.Web.UI.Page
    {

        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Request["ID"] != null)
                    {
                        hdMainID.Value = Request["ID"].ToString();
                    }
                }
                catch (Exception ex)
                {
                }
            }
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<clsPC5> GetAssetDetail(string MainID)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<clsPC5> details = new List<clsPC5>();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT        IMIS_tblAssignAssetToEmployeeDetail.ID, IMIS_tblAssignAssetToEmployeeDetail.MainID, IMIS_tblAssignAssetToEmployeeDetail.ProductCode, IMIS_tblAssignAssetToEmployeeDetail.SerialNumber, 
                         IMIS_tblAssignAssetToEmployeeDetail.Quantity, IMIS_tblAssignAssetToEmployeeDetail.AveragePrice, IMIS_tblAssignAssetToEmployeeDetail.Total, IMIS_tblAssignAssetToEmployeeDetail.AssetStatus, 
                         IMIS_VWProducts.ProductName, IMIS_VWProducts.UnitName, HRMIS_tblEmployeeInformation.NameLocal
FROM            IMIS_tblAssignAssetToEmployeeDetail INNER JOIN
                         IMIS_VWProducts ON IMIS_tblAssignAssetToEmployeeDetail.ProductCode = IMIS_VWProducts.ProductCode INNER JOIN
                         IMIS_tblAssignAssetToEmployeeMain ON IMIS_tblAssignAssetToEmployeeDetail.MainID = IMIS_tblAssignAssetToEmployeeMain.MainID INNER JOIN
                         HRMIS_tblEmployeeInformation ON IMIS_tblAssignAssetToEmployeeMain.EmpID = HRMIS_tblEmployeeInformation.EmployeeID
 where IMIS_tblAssignAssetToEmployeeDetail.MainID=" + MainID + "";
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsPC5 obj = new clsPC5();
                obj.ProductCode = dtrow["ProductCode"].ToString();
                obj.ProductName = dtrow["ProductName"].ToString();
                obj.UnitName = dtrow["UnitName"].ToString();
                obj.SerialNumber = dtrow["SerialNumber"].ToString();
                obj.Quantity = dtrow["Quantity"].ToString();
                obj.Price = dtrow["AveragePrice"].ToString();
                obj.Total = dtrow["Total"].ToString();
                obj.EmpName = dtrow["NameLocal"].ToString();
                obj.SubTotal = GetSubTotal(MainID).ToString();
                details.Add(obj);
            }
            return details;
        }


        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<clsPC5> GetAssetMain(string MainID)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<clsPC5> details = new List<clsPC5>();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = @"SELECT        IMIS_tblAssignAssetToEmployeeMain.MainID, IMIS_tblAssignAssetToEmployeeMain.EmpID, IMIS_tblAssignAssetToEmployeeMain.RequestNumber, IMIS_tblAssignAssetToEmployeeMain.RequestByDepartment, 
                       dbo.ToPersianDate(IMIS_tblAssignAssetToEmployeeMain.RequestDate) as RequestDate , IMIS_tblAssignAssetToEmployeeMain.TicketNumber, IMIS_tblAssignAssetToEmployeeMain.AssgineDepartment, dbo.ToPersianDate(IMIS_tblAssignAssetToEmployeeMain.SystemDate) as SystemDate, 
                         IMIS_tblAssignAssetToEmployeeMain.Remarks, HRMIS_tblEmployeeInformation.NameLocal
FROM            IMIS_tblAssignAssetToEmployeeMain INNER JOIN
                         HRMIS_tblEmployeeInformation ON IMIS_tblAssignAssetToEmployeeMain.EmpID = HRMIS_tblEmployeeInformation.EmployeeID
						 where IMIS_tblAssignAssetToEmployeeMain.MainID=" +MainID+"";
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                clsPC5 obj = new clsPC5();
                obj.EmpID = dtrow["EmpID"].ToString();
                obj.EmpName = dtrow["NameLocal"].ToString();
                obj.RequestNumber = dtrow["RequestNumber"].ToString();
                obj.RequestDate = dtrow["RequestDate"].ToString();
                obj.RequestByDepartment = dtrow["RequestByDepartment"].ToString();
                obj.TicketNumber = dtrow["TicketNumber"].ToString();
                obj.AssgineDepartment = dtrow["AssgineDepartment"].ToString();
                obj.SystemDate = dtrow["SystemDate"].ToString();
                
                details.Add(obj);
            }

            // Newtonsoft.Json.js
            return details;
        }


        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static Decimal GetSubTotal(string MainID)
        {
            Decimal SubTotal = 0;
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<clsPC5> details = new List<clsPC5>();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select sum(total) as SubTotal from IMIS_tblAssignAssetToEmployeeDetail  where MainID=" + MainID + " and AssetStatus='Assigned'";
            cmd.Connection = con;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                SubTotal = Decimal.Parse(dt.Rows[0]["SubTotal"].ToString());
            }

            return SubTotal;
        }
        //
    }
}