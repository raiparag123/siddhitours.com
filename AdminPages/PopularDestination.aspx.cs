using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Net.Http;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Configuration;
using System.IO;

public partial class AdminPages_PopularDestination : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["user"]) == "")
        {
            Response.Redirect("~/Login.aspx");
        }
    }

   

//public int uploadReport()
//    {
//        if (imageUpload.HasFile)
//        {
           

//            string FileName = Server.MapPath("~/Images/PopularDestination/" + imageUpload.FileName);

//            imageUpload.SaveAs(FileName);

//            HttpContext.Current.ApplicationInstance.CompleteRequest();
//            string compress = "";
//            using (var client = new HttpClient())
//            {

//                compress = Server.MapPath("~/Images/CompressedPopularDestination/" + imageUpload.FileName);

//                Tinify.Key = "q76ItMKdlL3gL2IV-2kcyPBta5IQpLws";
//                //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.

//                var source = Tinify.FromFile(Server.MapPath(FileName));
//                var resized = source.Resize(new
//                {
//                    method = "fit",
//                    width = 550,
//                    height = 550
//                });
//                resized.ToFile(Server.MapPath(compress)).Wait();
               
//            }
//        }
//        return 1;
//    }

        [WebMethod]
    public static string getDestination()
    {
        string status = "";
        AdminPages_PopularDestination adm = new AdminPages_PopularDestination();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_POP_DESTINATION_LIST", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            sda.Fill(ds);
            if (ds.Rows.Count > 0)
            {
                status = JsonConvert.SerializeObject(ds);
            }



        }
        catch (Exception ex)
        {

            adm.WriteErrorLog(ex.GetBaseException());
            adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            status = "";
        }
        finally
        {
            con.Dispose();
            con.Close();
            SqlConnection.ClearPool(con);
        }
        return status;
    }

    [WebMethod]
    public static string getDestinationPlace()
    {
        string status = "";
        AdminPages_PopularDestination adm = new AdminPages_PopularDestination();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_DESTINATION_LIST", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            sda.Fill(ds);
            if (ds.Rows.Count > 0)
            {
                status = JsonConvert.SerializeObject(ds);
            }



        }
        catch (Exception ex)
        {

            adm.WriteErrorLog(ex.GetBaseException());
            adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            status = "";
        }
        finally
        {
            con.Dispose();
            con.Close();
            SqlConnection.ClearPool(con);
        }
        return status;
    }

    [WebMethod]
    public static string deletePlace(string popid)
    {

        string status = "";
        AdminPages_PopularDestination adm = new AdminPages_PopularDestination();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_POP_DESTINATION", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@COUNTRYNAME", CountryName);
            cmd.Parameters.AddWithValue("@POPULARID", popid);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            sda.Fill(ds);
            status = "1";

        }
        catch (Exception ex)
        {

            adm.WriteErrorLog(ex.GetBaseException());
            adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            status = "";
        }
        finally
        {
            con.Dispose();
            con.Close();
            SqlConnection.ClearPool(con);
        }
        return status;
    }

    public void WriteErrorLog(Exception ex)
    {
        //sLogFormat used to create log files format :
        // dd/mm/yyyy hh:mm:ss AM/PM ==> Log Message
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

    }

    public void ErrorLog(string sPathName)
    {
        StreamWriter sw = new StreamWriter(sPathName + sErrorTime, true);
        sw.WriteLine(sLogFormat + sErrorBody);
        sw.Flush();
        sw.Close();
    }
}