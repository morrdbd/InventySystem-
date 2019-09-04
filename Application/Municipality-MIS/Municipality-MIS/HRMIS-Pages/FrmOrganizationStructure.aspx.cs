using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Inventory_Manager_Lib;

namespace Municipality_MIS.HRMIS_Pages
{
    public partial class FrmOrganizationStructure : System.Web.UI.Page
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

    }
}