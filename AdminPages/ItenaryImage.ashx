<%@ WebHandler Language="C#" Class="ItenaryImage" %>

using System;
using System.Web;

using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Net.Http;
using System.IO;
using TinifyAPI;
public class ItenaryImage : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        int tripID =Convert.ToInt32 (context.Request.QueryString["ItnenaryId"]);
        //string Detail= context.Request.QueryString["Detail"];   
        string status = "";
        string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
        string sLogFormat;
        string sErrorTime;
        string sErrorBody;
        string value = "";
        try
        {
            if (context.Request.Files.Count > 0)

            {

                HttpFileCollection SelectedFiles = context.Request.Files;

                for (int i = 0; i < SelectedFiles.Count; i++)

                {

                    HttpPostedFile PostedFile = SelectedFiles[i];
                         string Files = PostedFile.FileName.Trim().Replace(" ", "");
                    string FileName = context.Server.MapPath("~/Images/ItenaryImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Files);
                       
                    string path = ConfigurationManager.AppSettings["filePath"] + "ItenaryImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName;
                          
                    PostedFile.SaveAs(FileName);

                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                    string compress = "";
                    compress = ConfigurationManager.AppSettings["filePath"]+"CompressedItenaryImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Files;
                    using (var client = new HttpClient())
                    {


                        Tinify.Key = "q76ItMKdlL3gL2IV-2kcyPBta5IQpLws";
                        //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.
                        // Tinify.Proxy = "http://192.168.0.1:8080";
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
                        SqlCommand cmd = new SqlCommand("SP_UPDATE_ITENARY_IMAGE", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ITENARYID", tripID);


                        cmd.Parameters.AddWithValue("@IMAGEPATH", compress);

                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();

                        sda.Fill(ds);
                        // int value=cmd.ExecuteNonQuery();
                        if (ds.Tables.Count > 0)
                        {
                            status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
                        }

                        value = "1";
                    }

                }
            }
            else
            {
                 value = "0";
            }
        }
        catch (System.Exception ex)
        {
            sLogFormat = DateTime.Now + " ==> ";
            //this variable used to create log filename format "
            //for example filename : ErrorLogYYYYMMDD
            string sYear = DateTime.Now.Year.ToString();
            string sMonth = DateTime.Now.Month.ToString();
            string sDay = DateTime.Now.Day.ToString();
            sErrorTime = sYear + sMonth + sDay;

            string sMessage = ex.InnerException.ToString();
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
             value = "-1";
        }
            context.Response.Write(value);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}