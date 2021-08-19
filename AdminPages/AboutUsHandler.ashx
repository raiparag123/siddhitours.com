<%@ WebHandler Language="C#" Class="AboutUsHandler" %>

using System;
using System.Web;
using TinifyAPI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Net.Http;
using System.IO;

public class AboutUsHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //int CruiseId = Convert.ToInt32(context.Request.QueryString["CruiseId"]);
        string status = "";
        string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
        string sLogFormat;
        string sErrorTime;
        string sErrorBody;
        try
        {
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection SelectedFiles = context.Request.Files;

                for (int i = 0; i < SelectedFiles.Count; i++)
                {
                    HttpPostedFile PostedFile = SelectedFiles[i];
                    string FileName = context.Server.MapPath("~/Images/AboutUs/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName);

                    PostedFile.SaveAs(FileName);

                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                    string compress = "";
                    using (var client = new HttpClient())
                    {
                        compress = ConfigurationManager.AppSettings["filePath"] + "/CompressedAboutusImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName;

                        Tinify.Key = "a1llxbLnwsDD8SvNichjX616BCGko2zq";
                        //    //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.
                        //    Tinify.Proxy = "http://192.168.0.1:8080";
                        var source = Tinify.FromFile(FileName);
                        var resized = source.Resize(new
                        {
                            method = "fit",
                            width = 550,
                            height = 550
                        });
                        resized.ToFile(context.Server.MapPath(compress)).Wait();

                        SqlConnection con = new SqlConnection(conn);

                        if (con.State != ConnectionState.Open)
                        {
                            con.Open();
                        }
                        SqlCommand cmd = new SqlCommand("SP_UPDATE_ABOUTUS_IMAGE", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IMGPATH", compress);

                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();

                        sda.Fill(ds);
                        status = "1";
                    }
                }
            }
            context.Response.Write("1");
        }
        catch (SystemException ex)
        {
            sLogFormat = DateTime.Now + " ==> ";
            string sYear = DateTime.Now.Year.ToString();
            string sMonth = DateTime.Now.Month.ToString();
            string sDay = DateTime.Now.Day.ToString();
            sErrorTime = sYear + sMonth + sDay;

            string sMessage = ex.Message;
            string sSource = ex.Source;

            string sStackTrace = ex.StackTrace;
            sErrorBody = "\nException Message:" + sMessage + "\nSource:" + sSource + "\nStack Trace:" + sStackTrace;
            string sPathName = System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/");
            StreamWriter sw = new StreamWriter(sPathName + sErrorTime, true);
            sw.WriteLine(sLogFormat + sErrorBody);
            sw.Flush();
            sw.Close();
            context.Response.Write("0");
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