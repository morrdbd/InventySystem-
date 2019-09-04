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
using Inventory_Manager_Lib;
namespace Municipality_MIS.HRMIS_Pages
{
    public partial class frmDepartmentTree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
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
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool AddChildNode(int ParentNodeID, string NodeText)
        {
            clsDbGeneral db = new clsDbGeneral();
            int NodeID = db.GetMaxID("Department_Code", "HRMIS_tblDepartment");
            string query = "INSERT INTO [HRMIS_tblDepartment](Department_Code, Department_Name, Parent_Department_Code) VALUES(" + NodeID + ",N'" + NodeText + "' ," + ParentNodeID + ")";
            db.ExecuteQuery(query);
            return true;
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool UpdateNode(int NodeID, string NodeText)
        {
            clsDbGeneral db = new clsDbGeneral();
            string query = "Update [HRMIS_tblDepartment] set Department_Name=N'" + NodeText + "' where Department_Code=" + NodeID;
            db.ExecuteQuery(query);
            return true;
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
    }
}