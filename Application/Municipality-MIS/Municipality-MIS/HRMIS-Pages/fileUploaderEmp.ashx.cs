using System;
using System.Web;
using System.IO;

namespace ACCRA.TMS.Pages
{
    /// <summary>
    /// Summary description for fileUploaderEmp
    /// </summary>
    public class fileUploaderEmp : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string state = context.Request["state"];
            int postedFile = context.Request.Files.Count;
            try
            {
                string dirFullPath = HttpContext.Current.Server.MapPath("~/All-Photo/Emp-Photo");
                if (!Directory.Exists(HttpContext.Current.Server.MapPath("~/All-Photo/Emp-Photo")))
                {
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/All-Photo/Emp-Photo"));
                }
                string pathtoSave = "";
                if (state.ToLower() == "insert")
                {
                    string ProductCode = context.Request["EmpID"];
                    foreach (string s in context.Request.Files)
                    {
                        HttpPostedFile file = context.Request.Files[s];
                        string fileName = file.FileName;
                        string fileExtension = file.ContentType;
                        if (!string.IsNullOrEmpty(fileName))
                        {
                            fileExtension = System.IO.Path.GetExtension(fileName);
                            pathtoSave = ProductCode + fileExtension;
                            pathtoSave = HttpContext.Current.Server.MapPath("~/All-Photo/Emp-Photo/") + pathtoSave;
                            file.SaveAs(pathtoSave);
                        }
                    }
                }
                else if (state.ToLower() == "edit")
                {
                    string ProductCode = context.Request["EmpID"];
                    foreach (string s in context.Request.Files)
                    {
                        HttpPostedFile file = context.Request.Files[s];
                        string fileName = file.FileName;
                        string fileExtension = file.ContentType;
                        if (!string.IsNullOrEmpty(fileName))
                        {
                            fileExtension = System.IO.Path.GetExtension(fileName);
                            pathtoSave = ProductCode + fileExtension;
                            pathtoSave = HttpContext.Current.Server.MapPath("~/All-Photo/Emp-Photo/") + pathtoSave;
                            file.SaveAs(pathtoSave);
                        }
                    }
                }
            }
            catch (Exception ac)
            {
            }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}