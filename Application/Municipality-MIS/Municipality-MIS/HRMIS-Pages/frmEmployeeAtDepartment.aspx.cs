using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRMIS_Lib;
using Inventory_Manager_Lib;
using System.Reflection;
using System.Threading.Tasks;
namespace Municipality_MIS.HRMIS_Pages
{
    public partial class frmEmployeeAtDepartment : System.Web.UI.Page
    {
       
        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["EmpNo"] != null)
                hdEmployeeID.Value = Session["EmpNo"].ToString();

            if (!IsPostBack)
            {
                obj.fillDll(ddlPosition,"Position_Name", "Position_ID",@"SELECT  Position_ID,Position_Name_English +' - '+Position_Name_Dari as Position_Name FROM    HRMIS_tblPosition");
                obj.fillDll(ddlPresentProvince, "Province_Name", "Province_ID", "SELECT Province_ID, Province_Name FROM  Provinces");
                obj.fillDll(ddlEducationGarde,"E_Grade_Name","E_Grade_ID","SELECT E_Grade_ID, E_Grade_Name FROM  HRMIS_tblEducationGrade");
                DataTable dt_User = obj.GetData(@"select  UserId from aspnet_Users where LoweredUserName=N'" + User.Identity.Name + "'");
                hdUser.Value = dt_User.Rows[0]["UserId"].ToString();
            }


        }

        #region Tree View Code Start Here..
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<BootstrapTreeNode> GetAllNodes()
        {

            List<BootstrapTreeNode> MyNodes = new List<BootstrapTreeNode>();
            // dbGeneral db = new dbGeneral();
            clsDbGeneral db = new clsDbGeneral();
            DataTable dt = db.GetData("SELECT   Department_Code, Department_Name, Parent_Department_Code FROM   HRMIS_tblDepartment where Parent_Department_Code=0");
            foreach (DataRow row in dt.Rows)
            {
                BootstrapTreeNode nd = new BootstrapTreeNode();
                nd.text = row["Department_Name"].ToString();
                if (HaveChildNodes((int)row["Department_Code"]))
                {
                    nd.nodes = GetChilds((int)row["Department_Code"]);
                    nd.selectable = true;
                    nd.id = (int)row["Department_Code"];
                }
                else
                {
                    nd.selectable = true;
                    nd.id = (int)row["Department_Code"];
                }
                MyNodes.Add(nd);
            }
            return MyNodes;
        }
        public static bool HaveChildNodes(int nodeid)
        {
            clsDbGeneral db = new clsDbGeneral();
            return db.GetData("SELECT   Department_Code, Department_Name, Parent_Department_Code FROM   HRMIS_tblDepartment where Parent_Department_Code=" + nodeid).Rows.Count > 0 ? true : false;
        }
        public static List<BootstrapTreeNode> GetChilds(int nodeid)
        {
            clsDbGeneral db = new clsDbGeneral();
            DataTable dt = db.GetData("SELECT   Department_Code, Department_Name, Parent_Department_Code FROM   HRMIS_tblDepartment where Parent_Department_Code=" + nodeid);
            List<BootstrapTreeNode> toreturn = new List<BootstrapTreeNode>();
            foreach (DataRow row in dt.Rows)
            {
                BootstrapTreeNode nd = new BootstrapTreeNode();
                nd.text = row["Department_Name"].ToString();
                if (HaveChildNodes((int)row["Department_Code"]))
                {
                    nd.nodes = GetChilds((int)row["Department_Code"]);
                    nd.selectable = true;
                    nd.id = (int)row["Department_Code"];
                }
                else
                {
                    nd.selectable = true;
                    nd.id = (int)row["Department_Code"];
                }

                toreturn.Add(nd);
            }
            return toreturn;
        }
        #endregion
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<GetEmployee> GetEmployeeInfo(string EmpID)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployee> details = new List<GetEmployee>();
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
                GetEmployee obj = new GetEmployee();
                obj.Employee_ID = dtrow["EmployeeID"].ToString();
                obj.Name = dtrow["Name"].ToString();
                obj.Father_Name = dtrow["Father_Name"].ToString();
                obj.Grand_Father_Name = dtrow["Grand_Father_Name"].ToString();
               
                obj.Date_Of_Birth = dtrow["DateOfBirth"].ToString();
                obj.Gender = dtrow["Gender"].ToString();
                obj.Marital_Status = dtrow["MaritalStatus"].ToString();
                obj.Photo = dtrow["Photo"].ToString().Replace("~/", "../");
                obj.National_ID_Card_NO = dtrow["NationalIDCardNO"].ToString();
                details.Add(obj);
            }
            // Newtonsoft.Json.js
            return details;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<GetEmployee> GetReportingToEmployeeByID(string Employee_ID)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployee> details = new List<GetEmployee>();
            SqlDataAdapter da = new SqlDataAdapter(@" SELECT        EmployeeID, Name, Father_Name, Grand_Father_Name, Gender, MaritalStatus
FROM            HRMIS_VW_EmployeeInformation where EmployeeID='" + Employee_ID + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                GetEmployee obj = new GetEmployee();
                obj.Employee_ID = dtrow["EmployeeID"].ToString();
                obj.Name = dtrow["Name"].ToString();
                details.Add(obj);
            }
            // Newtonsoft.Json.js
            return details;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<GetEmployee> GetReportingToEmployee(string EmployeeName)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployee> details = new List<GetEmployee>();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT        EmployeeID, Name, Father_Name, Grand_Father_Name, Gender, MaritalStatus
FROM            HRMIS_VW_EmployeeInformation where Name like N'%" + EmployeeName + "%'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                GetEmployee obj = new GetEmployee();
                obj.Employee_ID = dtrow["EmployeeID"].ToString();
                obj.Name = dtrow["Name"].ToString();
                obj.Father_Name = dtrow["Father_Name"].ToString();
                obj.Grand_Father_Name = dtrow["Grand_Father_Name"].ToString();
                obj.Gender = dtrow["Gender"].ToString();
                details.Add(obj);
            }
            // Newtonsoft.Json.js
            return details;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void SaveEmpAtDepartment(GetEmployee Employee)
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
                cmd.CommandText = "HRMIS_tblEmployeeAtDepartment_Insert";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Employee_ID", SqlDbType.VarChar).Value = Employee.Employee_ID;
                cmd.Parameters.Add("@Department_ID", SqlDbType.Int).Value = Employee.Department_ID;
                cmd.Parameters.Add("@Position_ID", SqlDbType.Int).Value = Employee.Position_ID;
                cmd.Parameters.Add("@Reporting_To", SqlDbType.VarChar).Value = string.IsNullOrEmpty(Employee.ReportingTo)?"0":Employee.ReportingTo;
                cmd.Parameters.Add("@Status", SqlDbType.NVarChar).Value = Employee.Status;
                cmd.Parameters.Add("@User_ID", SqlDbType.NVarChar).Value = Employee.User_ID;
                cmd.ExecuteNonQuery();
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
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static IList<Districts> getDistricts(int Province_ID)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT  District_Id, District_Name, Province_ID FROM  Districts where Province_ID=" + Province_ID + "", con);
            da.Fill(dt);
            IList<Districts> toReturn = dt.ToList<Districts>();
            return toReturn;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static List<GetEmployee> EmpAdvanceSearchByName(GetEmployee Employee)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployee> details = new List<GetEmployee>();
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
                GetEmployee obj = new GetEmployee();
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
        public static List<GetEmployee> EmpAdvanceSearchByEducation(GetEmployee Employee)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployee> details = new List<GetEmployee>();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "[HRMIS_ProEmpAdvanceSearchByEducation]";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.Parameters.Add("@Education_Grade_ID", SqlDbType.Int).Value = Employee.Education_Grade_ID;
            cmd.Parameters.Add("@Main_Course_of_Study", SqlDbType.NVarChar).Value = Employee.Main_Course_of_Study;
            cmd.Parameters.Add("@Specialization", SqlDbType.NVarChar).Value = Employee.Specialization;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                GetEmployee obj = new GetEmployee();
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
        public static List<GetEmployee> EmpAdvanceSearchByAddress(GetEmployee Employee)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<GetEmployee> details = new List<GetEmployee>();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "[HRMIS_ProEmpAdvanceSearchByAddress]";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.Parameters.Add("@Present_Province_ID", SqlDbType.Int).Value = Employee.Present_Province_ID;
            cmd.Parameters.Add("@Present_District_ID", SqlDbType.Int).Value = Employee.Present_District_ID;
            cmd.Parameters.Add("@Present_Village", SqlDbType.NVarChar).Value = Employee.Present_Village;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                GetEmployee obj = new GetEmployee();
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
        public static List<EmpAtDepartmentView> EmpatDepartmentView(string EmpNO)
        {
            SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            List<EmpAtDepartmentView> details = new List<EmpAtDepartmentView>();
            string Query = @"SELECT        HRMIS_tblEmployeeAtDepartment.ID, HRMIS_tblEmployeeAtDepartment.Employee_ID, HRMIS_tblEmployeeAtDepartment.Department_ID, HRMIS_tblDepartment.Department_Name, HRMIS_tblDepartment.Department_Location, 
                         ISNULL(HRMIS_tblPosition.Position_Name_English, N'') + ' ' + ISNULL(HRMIS_tblPosition.Position_Name_Dari, N'') AS Position, HRMIS_tblEmployeeAtDepartment.Position_ID, HRMIS_tblEmployeeAtDepartment.Reporting_To , 
                        isnull(HRMIS_tblEmployeeInformation.FullName,'')  +' '+  isnull(HRMIS_tblEmployeeInformation.NameLocal,'') as Reporting_To_Name, HRMIS_tblEmployeeAtDepartment.Status, Convert(varchar(12),HRMIS_tblEmployeeAtDepartment.System_Date,107) as System_Date
FROM            HRMIS_tblEmployeeAtDepartment INNER JOIN
                         HRMIS_tblPosition ON HRMIS_tblEmployeeAtDepartment.Position_ID = HRMIS_tblPosition.Position_ID INNER JOIN
                         HRMIS_tblDepartment ON HRMIS_tblEmployeeAtDepartment.Department_ID = HRMIS_tblDepartment.Department_Code LEFT OUTER JOIN
                         HRMIS_tblEmployeeInformation ON HRMIS_tblEmployeeAtDepartment.Reporting_To = HRMIS_tblEmployeeInformation.EmployeeID
						 where HRMIS_tblEmployeeAtDepartment.Employee_ID='" + EmpNO.Trim() + "' order by HRMIS_tblEmployeeAtDepartment.ID desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dtrow in dt.Rows)
            {
                EmpAtDepartmentView obj = new EmpAtDepartmentView();
                obj.ID = dtrow["ID"].ToString();
                obj.Department_Name = dtrow["Department_Name"].ToString();
                obj.Department_Location = dtrow["Department_Location"].ToString();
                obj.Position = dtrow["Position"].ToString();
                obj.Reporting_To = dtrow["Reporting_To_Name"].ToString();
                obj.Status = dtrow["Status"].ToString();
                obj.System_Date = dtrow["System_Date"].ToString();
                details.Add(obj);
            }
            return details;
        }
        
    }
}
public static class clsExtensions
{
    public static IList<T> ToList<T>(this DataTable table) where T : new()
    {
        var props = typeof(T).GetProperties().ToList();
        var result = new List<T>();
        Parallel.ForEach(table.AsEnumerable(), row => result.Add(DataRowToObject<T>(row, props)));
        return result;
    }
    private static T DataRowToObject<T>(DataRow row, IList<PropertyInfo> props) where T : new()
    {
        T item = new T();
        foreach (var prop in props)
        {
            if (row.Table.Columns.Contains(prop.Name))
            {
                Type proptype = prop.PropertyType;
                var targetType = IsNullableType(prop.PropertyType) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType;
                var propertyVal = row[prop.Name];
                try
                {
                    propertyVal = Convert.ChangeType(propertyVal, targetType);
                    prop.SetValue(item, propertyVal, null);
                }
                catch (InvalidCastException ae)
                {
                    propertyVal = 0;
                }
            }
        }
        return item;
    }
    private static bool IsNullableType(Type type)
    {
        return type.IsGenericType && type.GetGenericTypeDefinition().Equals(typeof(Nullable<>));
    }
    public static bool HasProperty(this object obj, string propertyName)
    {
        return obj.GetType().GetProperty(propertyName) != null;
    }
}
public class GetEmployee
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
public class EmpAtDepartmentView
{
    public string ID { set; get; }
    public string Employee_ID { set; get; }
    public string Department_Name { set; get; }
    public string Department_Location { set; get; }
    public string Position { set; get; }
    public string Reporting_To { set; get; }
    public string Status { set; get; }
    public string System_Date { set; get; }
}