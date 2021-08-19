using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FrontEndPages_ContactUs : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string GetContactUs()
    {
        string status = "";
        FrontEndPages_ContactUs adm = new FrontEndPages_ContactUs();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_CONTACTUS_FRONT", con);
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
    public static string GetUserDetails(string Name, string Mobile, string Email, string Message)
    {
        string status = "",displayName="",MailTo="";
        FrontEndPages_ContactUs adm = new FrontEndPages_ContactUs();
        try
        {

            SqlConnection con = new SqlConnection(conn);
            SqlCommand cmd = new SqlCommand("SP_FE_MAIL_DETAIL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            sda.Fill(ds);
            if (ds.Rows.Count > 0)
            {
                displayName = ds.Rows[0][0].ToString();
                MailTo = ds.Rows[0][1].ToString();
            }

            var strContent = new StringBuilder();
            MailMessage mail = new MailMessage();
            SmtpClient smtp = new SmtpClient();
            string id = "mailtofourlance@gmail.com";
            string pass = "fourl@nce789";

            strContent.Append("<table><tr><td><div style='font-family:Calibri;border-radius:15px;font-size:16px;padding:40px 0px 20px 0px;margin-top:25px;margin-left:25px;background: #f0f9ff;background: -moz-linear-gradient(-45deg,  #f0f9ff 0%, #cbebff 47%, #a1dbff 100%);background: -webkit-linear-gradient(-45deg,  #f0f9ff 0%,#cbebff 47%,#a1dbff 100%);background: linear-gradient(135deg,  #f0f9ff 0%,#cbebff 47%,#a1dbff 100%);filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f0f9ff', endColorstr='#a1dbff',GradientType=1 );'><div style='background-color:#eee;height:5px;width:100%;'></div><div style='margin-left:40px;margin-top:20px;margin-bottom:20px;'><span>Dear <b><TO></b> </span><br/><br/>Below are the detail of the user to contact.<br /><br /><span><b><table><tr><td><b>Name:</b></td><td><NAME></td></tr><tr><td><b>Mobile No:</b></td><td><MOB></td></tr><tr><td><b>Email Id:</b></td><td><EMAIL></td></tr><tr><td><b>Message:</b></td><td><MES></td></tr></table></b></span><br/><br/><table><tr><td><div style='margin-right:40px;border:1px #cccccc solid;border-radius:5px;background: rgba(255,255,255,1);background: -moz-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: -webkit-gradient(left top, right bottom, color-stop(0%, rgba(255,255,255,1)), color-stop(100%, rgba(205,221,234,1))); background: -webkit-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: -o-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: -ms-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: linear-gradient(135deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#cdddea', GradientType=1 );'><REQ></div></td></tr></table><div style='width:100%;margin:8px 40px 8px 0px;'><PLS></div><div style='width:100%;margin:8px 40px 8px 0px;'><a tabindex='-1' href='<WS>' target='_blank' style='color: #6600ff;'><WS></a> &nbsp; &nbsp; <MNFLOW></div> <div style='width:100%;margin:8px 40px 8px 0px;'></div><div style='width:100%;margin:8px 40px 8px 0px;'></div> </div> <div style='background-color:#eee;height:5px;width:100%;'></div> <div id='divFooter'  style='font-size:11px;text-align:center;padding:10px 0px;background: rgba(255,255,255,1);background: -moz-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: -webkit-gradient(left top, right bottom, color-stop(0%, rgba(255,255,255,1)), color-stop(100%, rgba(205,221,234,1))); background: -webkit-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: -o-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: -ms-linear-gradient(-45deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);background: linear-gradient(135deg, rgba(255,255,255,1) 0%, rgba(205,221,234,1) 100%);filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#cdddea', GradientType=1 );'> Powered by <b>Fourlance</b> </div> <div style='background-color:#eee;height:5px;width:100%;'></div> </div></td></tr></table>");

            strContent.Replace("<TO>", "Admin");
            strContent.Replace("<NAME>", Name);
            strContent.Replace("<MOB>", Mobile);
            strContent.Replace("<EMAIL>", Email);
            strContent.Replace("<MES>", Message);

            mail.Subject = "Customer Details";
            mail.IsBodyHtml = true;
            mail.From = new MailAddress("mailtofourlance@gmail.com",displayName);
            mail.To.Add(new MailAddress(MailTo));
            mail.Body = Convert.ToString(strContent.Replace("\'", "\""));
            smtp.Host = "relay-hosting.secureserver.net";
            smtp.EnableSsl = false;
            smtp.Credentials = new NetworkCredential(id, pass);
            smtp.Port = 25;
            smtp.Send(mail);
            status = "1";
        }
        catch (Exception ex)
        {
            adm.WriteErrorLog(ex.GetBaseException());
            adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            status = "0";
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