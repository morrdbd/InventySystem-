using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Inventory_Manager_Lib;

namespace Municipality_MIS.Inventory_Pages
{
    public partial class frmStock : System.Web.UI.Page
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
                FillGrid();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FillGrid(txtSearch.Text);
        }
        private void FillGrid(string ProductName)
        {


            DataTable dt = obj.GetData(@"SELECT        IMIS_VWProducts.ProductCode as [د توکي شمیره], IMIS_VWProducts.ProductName as [د توکي نوم], IMIS_VWProducts.ProductDescription as [د توکي ملاحضات	] , IMIS_VWProducts.GroupName as [د توکي کټګورۍ	], IMIS_VWProducts.CategoryName as [د توکي ګروپ], 
                         IMIS_VWProducts.ProductOriginName as [د توکي اصلي	],
                         IMIS_tblStockInHand.Quantity as [د توکي مقدار	]
FROM            IMIS_VWProducts INNER JOIN
                         IMIS_tblStockInHand ON IMIS_VWProducts.ProductCode = IMIS_tblStockInHand.ProductCode where IMIS_VWProducts.ProductName like N'%" + ProductName + "%'");
            grdProduct.DataSource = dt;
            grdProduct.DataBind();


        }
        private void FillGrid()
        {


            DataTable dt = obj.GetData(@"SELECT  top 50   IMIS_VWProducts.ProductCode as [د توکي شمیره], IMIS_VWProducts.ProductName as [د توکي نوم], IMIS_VWProducts.ProductDescription as [د توکي ملاحضات	] , IMIS_VWProducts.GroupName as [د توکي کټګورۍ	], IMIS_VWProducts.CategoryName as [د توکي ګروپ], 
                         IMIS_VWProducts.ProductOriginName as [د توکي اصلي	],
                         IMIS_tblStockInHand.Quantity as [د توکي مقدار	]
FROM            IMIS_VWProducts INNER JOIN
                         IMIS_tblStockInHand ON IMIS_VWProducts.ProductCode = IMIS_tblStockInHand.ProductCode");
            grdProduct.DataSource = dt;
            grdProduct.DataBind();


        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            Grd_Export_To_Excel(grdProduct);
        }
        private void Grd_Export_To_Excel(GridView grdName)
        {
            //-------------------------------------
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "applcation/vnd.ms-excel";
            Response.AddHeader("content-disposition", "attachment;filename=AvailableStockReport.xls");
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.Charset = "UTF-8";
            Response.OutputStream.Write(new byte[] { 0xef, 0xbb, 0xbf }, 0, 3);
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grdName.RenderControl(htw);
            //tHeader.RenderControl(htw);
            //tDetail.RenderControl(htw);
            //tFooter.RenderControl(htw);
            Response.Write
           (@"<style>
            .grdheader
            {
	            background:#58b687;
	            height:25px;
	            color:#fff;
	             text-align:center ;
	             vertical-align:middle ;
	             font-size:2.4em;
            }
            .grdrow
            {
	            background:#fcfef2;
	            color:#05141a;
	            height:23px;
	            text-align:center ;
	            vertical-align:middle;
            }
            .grdaltrow
            {
	            background:#d3eed2;
	            color:#05141a;
	            height:23px;
	            text-align:center ;
	            vertical-align:middle;
            }	</style>"
           );
            Response.Write("<meta http-equiv='content-Type' content=text/html; charset=utf-8/ >");
            if (Session["Title"] != null)
            {
                if (Session["Title"].ToString() != "")
                {
                    Response.Write("<table border='1' width='100%'><tr class='grdheader'><td colspan='22'>" + Session["Title"].ToString() + "</td></tr></table>");
                }
            }
            Response.Write(sw.ToString());
            Response.End();
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            // base.VerifyRenderingInServerForm(control);
        }
    }
}