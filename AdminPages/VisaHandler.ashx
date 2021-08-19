<%@ WebHandler Language="C#" Class="VisaHandler" %>

using System;
using System.Web;
using System.IO;
using System.Net.Http;
using System.Configuration;
using TinifyAPI;

public class VisaHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        string VisaId = context.Request.QueryString["VisaId"];

        string conn = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
        string sLogFormat;
        string sErrorTime;
        string sErrorBody;
        string Status = "";

        try
        {
            int cnt = context.Request.Files.Count;

            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection SelectedFiles = context.Request.Files;

                for (int i = 0; i < SelectedFiles.Count; i++)
                {
                    HttpPostedFile PostedFile = SelectedFiles[i];
                       string Files = PostedFile.FileName.Trim().Replace(" ", "");
                    string FileName = context.Server.MapPath("~/Images/Visa/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" +Files);
                   
                    PostedFile.SaveAs(FileName);

                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                    string compress = "";
                    using (var client = new HttpClient())
                    {
                              string File = PostedFile.FileName.Trim().Replace(" ", "");
                        string img = ConfigurationManager.AppSettings["filePath"] + "VisaCompressed/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + File;
                        compress = ConfigurationManager.AppSettings["filePath"] + "VisaCompressed/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + File;

                        Tinify.Key = "a1llxbLnwsDD8SvNichjX616BCGko2zq";
                        //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.

                        var source = Tinify.FromFile(FileName);
                        var resized = source.Resize(new
                        {
                            method = "fit",
                            width = 550,
                            height = 550
                        });
                        resized.ToFile(context.Server.MapPath(compress)).Wait();
                        ////Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.

                        //var source = Tinify.FromFile(context.Server.MapPath("~/Images/PopularDestination/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName));
                        //var resized = source.Resize(new
                        //{
                        //    method = "fit",
                        //    width = 550,
                        //    height = 550
                        //});
                        //resized.ToFile(context.Server.MapPath("~/Images/CompressedPopularDestination/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName)).Wait();

                        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(conn);

                        if (con.State != System.Data.ConnectionState.Open)
                        {
                            con.Open();
                        }
                        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("SP_INSERT_VISA_IMAGE", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@VisaId", VisaId);
                        cmd.Parameters.AddWithValue("@ImgPath", compress);
                        System.Data.SqlClient.SqlDataAdapter sda = new System.Data.SqlClient.SqlDataAdapter(cmd);
                        System.Data.DataSet ds = new System.Data.DataSet();

                        sda.Fill(ds);
                        if (ds.Tables.Count > 0)
                        {
                            Status = Convert.ToString(ds.Tables[0].Rows[0]["STATUS"]);
                        }
                    }
                }
                context.Response.Write("1");
            }
        }
        catch (SystemException ex)
        {
            sLogFormat = DateTime.Now + " ==> ";
            //this variable used to create log filename format "
            //for example filename : ErrorLogYYYYMMDD
            string sYear = DateTime.Now.Year.ToString();
            string sMonth = DateTime.Now.Month.ToString();
            string sDay = DateTime.Now.Day.ToString();
            sErrorTime = sYear + sMonth + sDay;

            string sMessage = ex.Message;
            string sSource = ex.Source;
            //string sForm = Form;
            //string sTargetSite = ex.TargetSite.ToString();
            string sStackTrace = ex.StackTrace;
            sErrorBody = "\nException Message:" + sMessage + "\nSource:" + sSource + "\nStack Trace:" + sStackTrace;
            string sPathName = System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/");
            System.IO.StreamWriter sw = new System.IO.StreamWriter(sPathName + sErrorTime, true);
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