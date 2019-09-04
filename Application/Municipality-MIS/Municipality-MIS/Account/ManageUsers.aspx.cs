using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Inventory_Manager_Lib;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Security;

namespace Inventory_Manager_ALKC.Account
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        GlobalData db = new GlobalData();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IList<AppUser> SearchUser(string username)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT       convert(nvarchar(200), aspnet_Users.UserId) as UserId, aspnet_Users.UserName, aspnet_Membership.Email,Convert(varchar(12), aspnet_Membership.LastLoginDate,107) as LastLoginDate, CASE IsLockedOut  WHEN 0 THEN 0  ELSE 1 END as IsLockedOut FROM aspnet_Users INNER JOIN   aspnet_Membership ON aspnet_Users.UserId = aspnet_Membership.UserId where UserName like N'%" + username + "%'", con);
            da.Fill(dt);
            IList<AppUser> lstToReturn = dt.ToList<AppUser>();
            return lstToReturn;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public static Roles[] GetUserRoles(string UserID)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT  Convert(nvarchar(200),RoleId)  as ID, RoleName as Name,0 as IsInRole FROM aspnet_Roles order by RoleName", con);
            da.Fill(dt);
            var roles = dt.ToList<Roles>();

            //DataTable dt1 = new DataTable();
            //SqlDataAdapter da1 = new SqlDataAdapter(@"SELECT  UserId, RoleId FROM  aspnet_UsersInRoles where UserID=N'" + UserID + "'", con);
            //da1.Fill(dt1);
            //var usersInRole = dt1.ToList<UsersInRole>();
            var toreturn = new List<Roles>();

            foreach (Roles r in roles)
            {
                bool isInRole = false;
                DataTable dt3 = new DataTable();
                SqlDataAdapter da3 = new SqlDataAdapter(@"SELECT [UserId] ,[RoleId] FROM [aspnet_UsersInRoles] where UserID=cast('" + UserID + "' as uniqueidentifier) and RoleID=CAST('" + r.ID + "' as uniqueidentifier)", con);
                //SqlDataAdapter da3 = new SqlDataAdapter(@"SELECT [UserId] ,[RoleId] FROM [aspnet_UsersInRoles] where UserID='" + UserID + "' and RoleID='" + r.ID + "'", con);
                da3.Fill(dt3);
                if (dt3.Rows.Count > 0)
                    isInRole = true;
                else
                    isInRole = false;
                toreturn.Add(new Roles() { ID = r.ID, Name = r.Name, IsInRole = isInRole });
            }
            return toreturn.ToArray();
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool AsignRoles(string UserID, string[] roles)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "delete from aspnet_UsersInRoles where [UserId]='" + UserID + "'";
            cmd.Connection = con;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            foreach (string r in roles)
            {
                cmd.CommandText = "INSERT INTO aspnet_UsersInRoles ([UserId],[RoleId]) VALUES (N'" + UserID + "',N'" + r + "')";
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            return true;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool ResetPassword(string UserID)
        {
            //db.ExecuteQuery("Update Users set PasswordHash=N'AEzLfZ2E5Vm8pgU03OoY4aH8umQCUkDWU/9sShUg/j6K7qKxwvJR7ANDID+FVut1AA==',SecurityStamp=N'145c311c-a200-45ae-bd81-6999cef0036c'  where UserID='" + UserID + "'");
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "update  aspnet_Membership  set  Password=N't877VWNp1mSPkvXezvmw6oLkAuQ=', PasswordSalt=N'SEqj/lYzMMOosRpHJYgRzQ=='where UserId=cast('" + UserID + "' as uniqueidentifier)";
            cmd.Connection = con;
            con.Open();
            cmd.ExecuteNonQuery();

            return true;
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool LockUnlock(string UserID, string Action)
        {
            string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand();
            string Query = "";
            if (Action.Trim().ToLower() == "unlock")
                Query = "Update aspnet_Membership set IsLockedOut='false'  where UserId='" + UserID + "'";
            else
                Query = "Update aspnet_Membership set IsLockedOut='true'  where UserId='" + UserID + "'";
            cmd.CommandText = Query;
            cmd.Connection = con;
            con.Open();
            cmd.ExecuteNonQuery();
            return true;
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            
            TextBox txtSearch =  CreateUserWizardStep1.ContentTemplateContainer.FindControl("txtEmployeeIDSearch") as TextBox;
            TextBox txtEmpID = CreateUserWizardStep1.ContentTemplateContainer.FindControl("txtEmployeeID") as TextBox;
            TextBox txtEmpName = CreateUserWizardStep1.ContentTemplateContainer.FindControl("txtEmployeeName") as TextBox;
            TextBox EmailLabel = CreateUserWizardStep1.ContentTemplateContainer.FindControl("Email") as TextBox;
            DataTable dt = db.GetData(@"SELECT  EmployeeID, isnull(FullName,'') +' '+isnull(NameLocal,'') as FullName, isnull(FatherName,'') +'- '+FatherNameLocal as Father_Name, isnull(GrandFatherName,'')+' - '+ GrandFatherNameLocal as Grand_Father_Name,PersonalEmailAddress
FROM            HRMIS_tblEmployeeInformation where EmployeeID='" + txtSearch.Text + "'");
            if (dt.Rows.Count > 0)
            {
                txtEmpID.Text = dt.Rows[0]["EmployeeID"].ToString();
                txtEmpName.Text = dt.Rows[0]["FullName"].ToString();
                EmailLabel.Text = dt.Rows[0]["PersonalEmailAddress"].ToString();
            }

        }
        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {

            //TextBox txtEmpID = CreateUserWizard1.ContentTemplateContainer.FindControl("txtEmployeeID") as TextBox;
            //DataTable dt = db.GetData(@"SELECT    * FROM         aspnet_Users where Registration_Number='" + txtEmpID.Text + "'");
            //if (dt.Rows.Count > 0)
            //{
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), "23@", "alert('This User Record is alreday Avialbe')", true);
            //    return;
            //}
            //else
            //{
              
            //    MembershipUser usr = Membership.GetUser(CreateUserWizard1.UserName);
            //    string UserID = usr.ProviderUserKey.ToString();
            //    DropDownList ddlUserType = CreateUserWizardStep1.ContentTemplateContainer.FindControl("ddlUserType") as DropDownList;
            //    db.ExecuteQuery("Update aspnet_Users set Registration_Number='" + txtEmpID.Text + "'where UserId=N'" + UserID + "'");
            //}
        }

        protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            TextBox txtEmpID = CreateUserWizardStep1.ContentTemplateContainer.FindControl("txtEmployeeID") as TextBox;
            DataTable dt = db.GetData(@"SELECT    * FROM         aspnet_Users where Registration_Number='" + txtEmpID.Text + "'");
            if (dt.Rows.Count > 0)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "23@", "alert('This User Record is alreday Avialbe')", true);
                return;
            }
        }
    }
}
public class AppUser
{
    public string UserId { get; set; }
    public string UserName { get; set; }
    public string Email { get; set; }
    public string LastLoginDate { get; set; }
    public Boolean IsLockedOut { get; set; }
}
public class GlobalData
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    public DataTable GetData(string query)
    {
        DataTable dt = new DataTable();
        using (SqlDataAdapter da = new SqlDataAdapter(query, con))
        {
            da.Fill(dt);
        }
        return dt;
    }
    public void ExecuteQuery(string query)
    {
        using (SqlCommand com = new SqlCommand(query, con))
        {
            if (con.State == ConnectionState.Closed)
                con.Open();
            com.ExecuteNonQuery();
            con.Close();
        }
    }
    public bool isLocked(string username)
    {
        bool isLockedOut = false;
        DataTable dt = GetData("Select * from Users where UserName=N'" + username + "'");
        if (dt.Rows.Count > 0)
            isLockedOut = (bool)dt.Rows[0]["isLocked"];

        return isLockedOut;
    }
}
public class Roles
{
    public string ID { get; set; }
    public string Name { get; set; }
    public bool IsInRole { get; set; }
}
public class UsersInRole
{
    public string UserId { get; set; }
    public string RoleId { get; set; }
}