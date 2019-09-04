using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRMIS_Lib;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.IO;
using Inventory_Manager_Lib;
namespace Municipality_MIS.HRMIS_Pages
{
    public partial class frmEmployeeView : System.Web.UI.Page
    {
        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<EmpAtDepartmentList> EmpatDepartmentViewByName(string EmpName)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<EmpAtDepartmentList> details = new List<EmpAtDepartmentList>();
            string Query = @"SELECT        HRMIS_tblEmployeeAtDepartment.ID, HRMIS_tblEmployeeAtDepartment.Employee_ID, HRMIS_tblEmployeeInformation_1.NameLocal, HRMIS_tblEmployeeInformation_1.FatherNameLocal, 
                         HRMIS_tblEmployeeAtDepartment.Department_ID, HRMIS_tblDepartment.Department_Location, HRMIS_tblPosition.Position_Name_Dari AS Position, 
                         HRMIS_tblEmployeeAtDepartment.Position_ID, HRMIS_tblEmployeeAtDepartment.Reporting_To, ISNULL(HRMIS_tblEmployeeInformation.FullName, N'') + ' ' + ISNULL(HRMIS_tblEmployeeInformation.NameLocal, N'') 
                         AS Reporting_To_Name, HRMIS_tblEmployeeAtDepartment.Status, CONVERT(varchar(12), HRMIS_tblEmployeeAtDepartment.System_Date, 107) AS System_Date, HRMIS_tblEmployeeInformation_1.Photo, 
                         HRMIS_tblDepartment.Department_Name
FROM            HRMIS_tblEmployeeAtDepartment INNER JOIN
                         HRMIS_tblPosition ON HRMIS_tblEmployeeAtDepartment.Position_ID = HRMIS_tblPosition.Position_ID INNER JOIN
                         HRMIS_tblDepartment ON HRMIS_tblEmployeeAtDepartment.Department_ID = HRMIS_tblDepartment.Department_Code LEFT OUTER JOIN
                         HRMIS_tblEmployeeInformation ON HRMIS_tblEmployeeAtDepartment.Reporting_To = HRMIS_tblEmployeeInformation.EmployeeID RIGHT OUTER JOIN
                         HRMIS_tblEmployeeInformation AS HRMIS_tblEmployeeInformation_1 ON HRMIS_tblEmployeeAtDepartment.Employee_ID = HRMIS_tblEmployeeInformation_1.EmployeeID
WHERE        (HRMIS_tblEmployeeAtDepartment.Status = 'Active') and HRMIS_tblEmployeeInformation.NameLocal like N'%" + EmpName + "%'";
            SqlDataAdapter da = new SqlDataAdapter(Query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                EmpAtDepartmentList obj = new EmpAtDepartmentList();
                obj.Employee_ID = dtrow["Employee_ID"].ToString();
                obj.Name = dtrow["NameLocal"].ToString();
                obj.FName = dtrow["FatherNameLocal"].ToString();
                obj.Department_Name = dtrow["Department_Name"].ToString();
                obj.Department_Location = dtrow["Department_Location"].ToString();
                obj.Position = dtrow["Position"].ToString();
                obj.Reporting_To = dtrow["Reporting_To_Name"].ToString();
                obj.Status = dtrow["Status"].ToString();
                obj.Photo = dtrow["Photo"].ToString().Replace("~/", "../");
                details.Add(obj);
            }
            return details;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<EmpAtDepartmentList> EmpatDepartmentViewAll()
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<EmpAtDepartmentList> details = new List<EmpAtDepartmentList>();
            string Query = @"SELECT    top 20    HRMIS_tblEmployeeAtDepartment.ID, HRMIS_tblEmployeeAtDepartment.Employee_ID, HRMIS_tblEmployeeInformation_1.NameLocal, HRMIS_tblEmployeeInformation_1.FatherNameLocal, 
                         HRMIS_tblEmployeeAtDepartment.Department_ID, HRMIS_tblDepartment.Department_Location, HRMIS_tblPosition.Position_Name_Dari AS Position, 
                         HRMIS_tblEmployeeAtDepartment.Position_ID, HRMIS_tblEmployeeAtDepartment.Reporting_To, ISNULL(HRMIS_tblEmployeeInformation.FullName, N'') + ' ' + ISNULL(HRMIS_tblEmployeeInformation.NameLocal, N'') 
                         AS Reporting_To_Name, HRMIS_tblEmployeeAtDepartment.Status, CONVERT(varchar(12), HRMIS_tblEmployeeAtDepartment.System_Date, 107) AS System_Date, HRMIS_tblEmployeeInformation_1.Photo, 
                         HRMIS_tblDepartment.Department_Name
FROM            HRMIS_tblEmployeeAtDepartment INNER JOIN
                         HRMIS_tblPosition ON HRMIS_tblEmployeeAtDepartment.Position_ID = HRMIS_tblPosition.Position_ID INNER JOIN
                         HRMIS_tblDepartment ON HRMIS_tblEmployeeAtDepartment.Department_ID = HRMIS_tblDepartment.Department_Code LEFT OUTER JOIN
                         HRMIS_tblEmployeeInformation ON HRMIS_tblEmployeeAtDepartment.Reporting_To = HRMIS_tblEmployeeInformation.EmployeeID RIGHT OUTER JOIN
                         HRMIS_tblEmployeeInformation AS HRMIS_tblEmployeeInformation_1 ON HRMIS_tblEmployeeAtDepartment.Employee_ID = HRMIS_tblEmployeeInformation_1.EmployeeID
WHERE        (HRMIS_tblEmployeeAtDepartment.Status = 'Active')";
            SqlDataAdapter da = new SqlDataAdapter(Query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                EmpAtDepartmentList obj = new EmpAtDepartmentList();
                obj.Employee_ID = dtrow["Employee_ID"].ToString();
                obj.Name = dtrow["NameLocal"].ToString();
                obj.FName = dtrow["FatherNameLocal"].ToString();
                obj.Department_Name = dtrow["Department_Name"].ToString();
                obj.Department_Location = dtrow["Department_Location"].ToString();
                obj.Position = dtrow["Position"].ToString();
                obj.Reporting_To = dtrow["Reporting_To_Name"].ToString();
                obj.Status = dtrow["Status"].ToString();
                obj.Photo = dtrow["Photo"].ToString().Replace("~/", "../");
                details.Add(obj);
            }
            return details;
        }
    }
}