<%@ WebHandler Language="C#" Class="B2B" %>


using System;
using System.Web;
using TinifyAPI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Net.Http;
using System.IO;


public class B2B : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {



        context.Response.ContentType = "text/plain";
        int businessid = Convert.ToInt32(context.Request.QueryString["BusinessId"]);
        string status = "0";
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
                         string Files = PostedFile.FileName.Trim().Replace(" ", "");
                    string FileName = context.Server.MapPath("~/Images/BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Files);

                    PostedFile.SaveAs(FileName);

                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                    string compress = "";
                    using (var client = new HttpClient())
                    {

                        // compress = "/Images/CompressedTripImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName;
                        compress = ConfigurationManager.AppSettings["filePath"]+"CompressedBusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Files;
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
                        SqlCommand cmd = new SqlCommand("SP_INSERT_BUSINESS_IMAGES", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@BUSINESSID", businessid);


                        cmd.Parameters.AddWithValue("@IMAGEPATH", compress);

                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();

                        sda.Fill(ds);
                        // int value=cmd.ExecuteNonQuery();
                        if (ds.Tables.Count > 0)
                        {
                            status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
                        }


                    }

                }
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
            StreamWriter sw = new StreamWriter(sPathName + sErrorTime, true);
            sw.WriteLine(sLogFormat + sErrorBody);
            sw.Flush();
            sw.Close();
            status = "0";

        }
        context.Response.Write(status);

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}