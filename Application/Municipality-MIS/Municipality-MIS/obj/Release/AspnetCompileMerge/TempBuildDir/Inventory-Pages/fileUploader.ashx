<%@ WebHandler Language="C#" Class="fileUploader" %>
using System;
using System.Web;
using System.IO;
public class fileUploader : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string state = context.Request["state"];
        int postedFile = context.Request.Files.Count;
       // string state = "insert";
        try
        {
            string dirFullPath = HttpContext.Current.Server.MapPath("~/All-Photo/Product-Images");
            if (!Directory.Exists(HttpContext.Current.Server.MapPath("~/All-Photo/Product-Images")))
            {
                Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/All-Photo/Product-Images"));
            }
            string pathtoSave = "";
            if(state.ToLower()=="insert")
            {
                string ProductCode = context.Request["ProductCode"];
                foreach (string s in context.Request.Files)
                {
                    HttpPostedFile file = context.Request.Files[s];
                    string fileName = file.FileName;
                    string fileExtension = file.ContentType;
                    if (!string.IsNullOrEmpty(fileName))
                    {
                        fileExtension = System.IO.Path.GetExtension(fileName);
                        pathtoSave = ProductCode + fileExtension;
                        pathtoSave = HttpContext.Current.Server.MapPath("~/All-Photo/Product-Images/") + pathtoSave;
                        file.SaveAs(pathtoSave);
                    }
                }
            }
            else if(state.ToLower()=="edit")
            {
                string ProductCode = context.Request["ProductCode"];
                DeletePhoto(ProductCode);
                foreach (string s in context.Request.Files)
                {
                    HttpPostedFile file = context.Request.Files[s];
                    string fileName = file.FileName;
                    string fileExtension = file.ContentType;

                    if (!string.IsNullOrEmpty(fileName))
                    {
                        fileExtension = System.IO.Path.GetExtension(fileName);
                        pathtoSave = ProductCode + fileExtension;
                        pathtoSave = HttpContext.Current.Server.MapPath("~/All-Photo/Product-Images/") + pathtoSave;
                        file.SaveAs(pathtoSave);
                    }
                }
            }
        }
        catch (Exception ac)
        {

        }
    }

    private void DeletePhoto(string EmpID)
    {
        string paht = "~/All-Photo/Product-Images/" + EmpID;
        if (File.Exists(paht + ".jpg"))
        {
            File.Delete(paht + ".jpg");
        }
        else if (File.Exists(paht + ".png"))
        {
            File.Delete(paht + ".png");
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