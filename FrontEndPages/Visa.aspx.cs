using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Net.Mail;

public partial class FrontEndPages_Visa : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    public string flag = "";
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string getVisa()
    {
        string status = "";

        FrontEndPages_Visa adm = new FrontEndPages_Visa();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_VISA_FRONT", con);
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
    public static string getCountry()
    {
        string status = "";

        FrontEndPages_Visa adm = new FrontEndPages_Visa();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_COUNTRY_FRONT", con);
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

    [System.Web.Services.WebMethod]
    public static string SendMail(string Visa ,string Email, string Phone)
    {
        FrontEndPages_Visa adm = new FrontEndPages_Visa();
        string status = "";
        try
        {

            string id = "mailtofourlance@gmail.com";
            string pass = "fourl@nce789";
            MailMessage EMail = new MailMessage();
            EMail.From = new MailAddress("mailtofourlance@gmail.com");
            EMail.Subject = "Visa Enquiry";
            string Ebody = "The below user has raise a query";
             Ebody = "<table style='border:1px solid black'>";
            Ebody += "<tr><th>Email</th><th>Phone</th><th>Visa</th></tr>";
            Ebody += "<tr><td>" + Email + "</td><td>" + Phone + "</td><td>" + Visa + "</td></tr></table>";

            EMail.IsBodyHtml = true;
            EMail.To.Add(new MailAddress("dhwanij0@gmail.com"));
            SmtpClient Esmtp = new SmtpClient();
            EMail.Body = Ebody;
            Esmtp.Host = "smtp.gmail.com";
            Esmtp.EnableSsl = true;
            Esmtp.Credentials = new NetworkCredential(id, pass);
            //System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
            //NetworkCred.UserName = "mailtofourlance@gmail.com";
            //NetworkCred.Password = "fourl@nce789";
            // smtp.UseDefaultCredentials = true;
            //smtp.Credentials = NetworkCred;
            Esmtp.Port = 587;
            Esmtp.Send(EMail);
            status = "1";
        }
        catch (Exception ex) {
            status = "0";
        }
        return status;
    }


            public void WriteErrorLog(System.Exception ex)
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