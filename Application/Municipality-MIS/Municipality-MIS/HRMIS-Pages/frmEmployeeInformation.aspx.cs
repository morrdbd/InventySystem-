using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Services;
using System.Web.Script.Services;
using System.Data.SqlClient;
using System.IO;
using Inventory_Manager_Lib;
using HRMIS_Lib;
namespace Municipality_MIS.HRMIS_Pages
{
    public partial class frmEmployeeInformation : System.Web.UI.Page
    {
        clsDbGeneral obj = new clsDbGeneral();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                obj.fillDll(ddlPermanentProvince,"Province_Name", "Province_ID", "SELECT Province_ID, Province_Name FROM  Provinces" );
                obj.fillDll(ddlPresentProvince, "Province_Name","Province_ID","SELECT Province_ID, Province_Name FROM  Provinces");
                obj.fillDll(ddlEducationGrade, "E_Grade_Name","E_Grade_ID","SELECT E_Grade_ID, E_Grade_Name FROM  HRMIS_tblEducationGrade");

                DataTable dt_User = obj.GetData(@"SELECT        HRMIS_tblEmployeeInformation.EmployeeID, HRMIS_tblEmployeeInformation.FullName, aspnet_Users.UserId, aspnet_Users.UserName
FROM            HRMIS_tblEmployeeInformation INNER JOIN
                         aspnet_Users ON HRMIS_tblEmployeeInformation.EmployeeID = aspnet_Users.Registration_Number where LoweredUserName=N'" + User.Identity.Name + "'");
                hdUser.Value = dt_User.Rows[0]["UserId"].ToString();


                //txtEmpID.Text= GetEmpID();
                //DataTable dt_User = obj.GetData(@"select  UserId from aspnet_Users where LoweredUserName=N'" + User.Identity.Name + "'");
                //hdUser.Value = dt_User.Rows[0]["UserId"].ToString();

            }
            //btnReset.Attributes.Add("onclick", "window.open('Tuition_Fee_Transaction.aspx?Fee_Month_ID=" +.Text + "',null,'width=350,height=700,top=100,left=10','true');");
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
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string SaveEmployee(clsEmployee Employee)
        {
            string EmpID = GetEmpID();
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            SqlTransaction tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand();
            cmd.Transaction = tran;
            cmd.Connection = con;
            try
            {
                string ext = Path.GetExtension(Employee.Photo);
                Employee.Photo = "~/All-Photo/Emp-Photo/" + EmpID + ext;
                string query = @"insert into HRMIS_tblEmployeeInformation(EmployeeID,
                NameLocal,FatherNameLocal,GrandFatherNameLocal,Gender, MaritalStatus, Photo, OtherId, DateOfBirth, PersonalMobileNumber, PersonalEmailAddress, OfficialContactNumber, OfficialEmailAddress, 
                EmergencyContactRelationship, EmergencyContactName, EmergencyContactMobile, NationalIDCardNO, EducationGradeID, MainCourseOfStudy, Specialization,PermanentProvinceID,PermanentDistrictID,PermanentVillage,PresentProvinceID,PresentDistrictID,PresentVillage,Remarks, UserID) 
                values(@EmployeeID,@NameLocal,@FatherNameLocal,@GrandFatherNameLocal,@Gender, @MaritalStatus, @Photo, @OtherId, @DateOfBirth, @PersonalMobileNumber, 
                @PersonalEmailAddress, @OfficialContactNumber, @OfficialEmailAddress, 
                @EmergencyContactRelationship, @EmergencyContactName, @EmergencyContactMobile, @NationalIDCardNO, 
                @EducationGradeID, @MainCourseOfStudy, @Specialization, @PermanentProvinceID,@PermanentDistrictID,@PermanentVillage,@PresentProvinceID,@PresentDistrictID,@PresentVillage,@Remarks, @UserID)";
                
                cmd.Parameters.Add("@EmployeeID", SqlDbType.VarChar).Value = EmpID;
                cmd.Parameters.Add("@NameLocal", SqlDbType.NVarChar).Value = Employee.Name_Local;
                cmd.Parameters.Add("@FatherNameLocal", SqlDbType.NVarChar).Value = Employee.Father_Name_Local;
                cmd.Parameters.Add("@GrandFatherNameLocal", SqlDbType.NVarChar).Value = Employee.Grand_Father_Name_Local;
                cmd.Parameters.Add("@Gender", SqlDbType.NVarChar).Value = Employee.Gender;
                cmd.Parameters.Add("@MaritalStatus", SqlDbType.NVarChar).Value = Employee.Marital_Status;
                cmd.Parameters.Add("@Photo", SqlDbType.VarChar).Value = Employee.Photo;
                cmd.Parameters.Add("@OtherId", SqlDbType.NVarChar).Value =22;
                string Date = ShamsiToGregorian(Employee.Date_Of_Birth.ToString());
                cmd.Parameters.Add("@DateOfBirth", SqlDbType.DateTime).Value = Date;
                cmd.Parameters.Add("@PersonalMobileNumber", SqlDbType.NVarChar).Value = Employee.Personal_Mobile_Number;
                cmd.Parameters.Add("@PersonalEmailAddress", SqlDbType.VarChar).Value = Employee.Personal_Email_Address;
                cmd.Parameters.Add("@OfficialContactNumber", SqlDbType.NVarChar).Value = Employee.Official_Contact_Number;
                cmd.Parameters.Add("@OfficialEmailAddress", SqlDbType.VarChar).Value = Employee.Official_Email_Address;
                cmd.Parameters.Add("@EmergencyContactRelationship", SqlDbType.NVarChar).Value = Employee.Emergency_Contact_Relationship;
                cmd.Parameters.Add("@EmergencyContactName", SqlDbType.NVarChar).Value = Employee.Emergency_Contact_Name;
                cmd.Parameters.Add("@EmergencyContactMobile", SqlDbType.NVarChar).Value = Employee.Emergency_Contact_Mobile;
                cmd.Parameters.Add("@NationalIDCardNO", SqlDbType.NVarChar).Value = Employee.National_ID_Card_NO;
                cmd.Parameters.Add("@EducationGradeID", SqlDbType.Int).Value = Employee.Education_Grade_ID;
                cmd.Parameters.Add("@MainCourseOfStudy", SqlDbType.NVarChar).Value = Employee.Main_Course_of_Study;
                cmd.Parameters.Add("@Specialization", SqlDbType.NVarChar).Value = Employee.Specialization;
                cmd.Parameters.Add("@PermanentProvinceID", SqlDbType.Int).Value = Employee.Permanent_Province_ID;
                cmd.Parameters.Add("@PermanentDistrictID", SqlDbType.Int).Value = Employee.Permanent_District_ID;
                cmd.Parameters.Add("@PermanentVillage", SqlDbType.NVarChar).Value = Employee.Permanent_Village;
                cmd.Parameters.Add("@PresentProvinceID", SqlDbType.Int).Value = Employee.Present_Province_ID;
                cmd.Parameters.Add("@PresentDistrictID", SqlDbType.Int).Value = Employee.Present_District_ID;
                cmd.Parameters.Add("@PresentVillage", SqlDbType.NVarChar).Value = Employee.Present_Village;
                cmd.Parameters.Add("@Remarks", SqlDbType.NVarChar).Value = "";
                cmd.Parameters.Add("@UserID", SqlDbType.NVarChar).Value = Employee.User_ID;
                cmd.CommandText = query;
                cmd.ExecuteNonQuery();
                tran.Commit();
                GetSavedID(EmpID);
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
            return EmpID;
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
        public static string GregorianToShamsi(string gdate)
        {
            SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand("select dbo.funGregToShamsi('" + gdate + "')", con2);
            if (con2.State == ConnectionState.Closed)
                con2.Open();
            string gd = com.ExecuteScalar().ToString();
            con2.Close();
            return gd;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool EmployeeExist(string Employee_ID)
        {
            bool Status = false;
            string con = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            List<clsEmployee> details = new List<clsEmployee>();
            SqlDataAdapter da = new SqlDataAdapter(@"select * from HRMIS_tblEmployeeInformation where Employee_ID='" + Employee_ID + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
                Status = true;
            return Status;
        }
        protected void btnNext_Click(object sender, EventArgs e)
        {
            Session["EmpNo"] = hdEmpNo.Value;
            Response.Redirect("frmEmployeeAtDepartment.aspx");
        }

        public static string GetEmpID()
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"select  isnull(MAX(right(EmployeeID,7)),0)+1 as maxID from HRMIS_tblEmployeeInformation", con);
            da.Fill(dt);
            string ordermID = dt.Rows[0]["maxID"].ToString();
            if (ordermID == "")
            {
                return "0000001";
            }
            int id = 0;
            int.TryParse(ordermID, out id);
            switch (id.ToString().Length)
            {
                case 1:
                    ordermID = "000000" + id;
                    break;
                case 2:
                    ordermID = "00000" + id; break;
                case 3:
                    ordermID = "0000" + id; break;
                case 4:
                    ordermID = "000" + id; break;
                case 5:
                    ordermID = "00" + id; break;
                case 6:
                    ordermID = "0" + id; break;
                case 7:
                    ordermID = id.ToString(); break;
            }
            return ordermID;
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static string GetSavedID(string EmpID)
        {
            return EmpID;
        }
    }
}

public class Districts
{
    public int District_Id { get; set; }
    public string District_Name { get; set; }
    public int Province_ID { get; set; }
}