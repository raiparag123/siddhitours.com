<%@ WebHandler Language="C#" Class="PopularDestinationHandler" %>

using System;
using System.Web;
using TinifyAPI;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Net.Http;
using System.IO;

public class PopularDestinationHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string LocationId = context.Request.QueryString["locationid"];
        string Title = context.Request.QueryString["Title"];
        string flag= context.Request.QueryString["Flag"];
        int popularid;
        if (flag == "A")
        {
            popularid = 0;
        }
        else
        {
            popularid= Convert.ToInt32(context.Request.QueryString["popularid"]);
        }

        string status = "";
        string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
        string sLogFormat;
        string sErrorTime;
        string sErrorBody;
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
                    string FileName = context.Server.MapPath("~/Images/PopularDestination/"+ DateTime.Now.ToString("yyyyMMddHHmmss")+"_" + Files);

                    PostedFile.SaveAs(FileName);

                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                    string compress = "";
                    using (var client = new HttpClient())
                    {
                        string img = ConfigurationManager.AppSettings["filePath"] + "CompressedPopularDestination/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Files;
                        compress =ConfigurationManager.AppSettings["filePath"]+"CompressedPopularDestination/" +DateTime.Now.ToString("yyyyMMddHHmmss")+"_" + Files;

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

                        SqlConnection con = new SqlConnection(conn);

                        if (con.State != ConnectionState.Open)
                        {
                            con.Open();
                        }
                        SqlCommand cmd = new SqlCommand("SP_ADD_EDIT_POPULAR_DESTINATION", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@LOCATIONID", LocationId);
                        cmd.Parameters.AddWithValue("@TITLE", Title);

                        cmd.Parameters.AddWithValue("@IMAGEPATH", img);
                        cmd.Parameters.AddWithValue("@POPULARID", popularid);
                        cmd.Parameters.AddWithValue("@FLAG", flag);
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
            else
            {
                if(popularid>0)
                {
                    SqlConnection con1 = new SqlConnection(conn);

                    if (con1.State != ConnectionState.Open)
                    {
                        con1.Open();
                    }
                    SqlCommand cmd1 = new SqlCommand("SP_ADD_EDIT_POPULAR_DESTINATION", con1);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@LOCATIONID", LocationId);
                    cmd1.Parameters.AddWithValue("@TITLE", Title);

                    cmd1.Parameters.AddWithValue("@IMAGEPATH", "");
                    cmd1.Parameters.AddWithValue("@POPULARID", popularid);
                    cmd1.Parameters.AddWithValue("@FLAG", flag);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd1);
                    DataSet ds = new DataSet();

                    sda.Fill(ds);
                    // int value=cmd.ExecuteNonQuery();
                    if (ds.Tables.Count > 0)
                    {
                        status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
                    }
                }
            }
            context.Response.Write("1");
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