using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Net;

public partial class Login : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session.Abandon();
            Session.Clear();


            if (Request.Cookies["userid"] != null)
            {
                user.Value = Request.Cookies["userid"].Value;
            }
            if (Request.Cookies["pwd"] != null)
            {
                pass.Value = Request.Cookies["pwd"].Value;

            }
            if (Request.Cookies["userid"] != null && Request.Cookies["pwd"] != null)
            {
                hdnflag.Value = "1";
            }
            else
            {
                hdnflag.Value = "0";
            }
        }
    }

    [WebMethod]
    public static string checkLogin(string userid, string password,string Flag)
    {
        string status = "";
        Login log = new Login();
        SqlConnection con = new SqlConnection(conn);
        try
        {


            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_ADMIN_LOGIN", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@USERID", userid);
            cmd.Parameters.AddWithValue("@PASSWORD", password);


            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                HttpContext.Current.Session["user"] = ds.Tables[0].Rows[0]["username"];
                if (Flag == "1")
                {
                  
                    HttpContext.Current.Response.Cookies["userid"].Value = userid;
                    HttpContext.Current.Response.Cookies["pwd"].Value = password;
                    HttpContext.Current.Response.Cookies["userid"].Expires = DateTime.Now.AddDays(15);
                    HttpContext.Current.Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(15);
                }
                else
                {
                    HttpContext.Current.Response.Cookies["userid"].Expires = DateTime.Now.AddDays(-1);

                    HttpContext.Current.Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(-1);
                }
                //log.remember(userid,password);
                status = "1";
            }
            else
            {
                status = "0";
            }
            //con.Close();

        }
        catch (Exception ex)
        {
            Login ret = new Login();
            ret.WriteErrorLog(ex.GetBaseException());
            ret.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));

        }
        finally
        {
            con.Dispose();
            con.Close();
            SqlConnection.ClearPool(con);
        }
        return status;

    }
    public void remember(string user,string password) {
        //Page page = (Page)HttpContext.Current.Handler;
        //CheckBox check = (CheckBox)page.FindControl("rememberme");
        //if (check.Checked == true)
        //{
        //    Response.Cookies["userid"].Value = user;
        //    Response.Cookies["pwd"].Value = password;
        //    Response.Cookies["userid"].Expires = DateTime.Now.AddDays(15);
        //    Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(15);
        //}

        //else

        //{

        //    Response.Cookies["userid"].Expires = DateTime.Now.AddDays(-1);

        //    Response.Cookies["pwd"].Expires = DateTime.Now.AddDays(-1);

        //}

    }


    [WebMethod]
    public static string ResetPassword()
    {

        string status = "";
        Login log = new Login();
        SqlConnection con = new SqlConnection(conn);
        try
        {


            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_ADMIN_DETAIL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            


            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
               string admin= Convert.ToString(ds.Tables[0].Rows[0]["username"]);
                string password = Convert.ToString(ds.Tables[0].Rows[0]["password"]);
                Random ran = new Random();
                int tokenid = ran.Next(1000, 9999999);
                SqlCommand cmdinsert = new SqlCommand("SP_INSERT_RESET_TOKEN", con);
                cmdinsert.CommandType = CommandType.StoredProcedure;
                cmdinsert.Parameters.AddWithValue("@TOKENID", tokenid);
                cmdinsert.ExecuteNonQuery();
                log.sendmail(admin, password,tokenid);
                status = "1";
            }
            else
            {
                status = "0";
            }
            //con.Close();

        }
        catch (Exception ex)
        {
            Login ret = new Login();
            ret.WriteErrorLog(ex.GetBaseException());
            ret.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));

        }
        finally
        {
            con.Dispose();
            con.Close();
            SqlConnection.ClearPool(con);
        }
        return status;
    }

    public void sendmail(string userid,string password,int token)
    {
        string id = "mailtofourlance@gmail.com";
        string pass = "fourl@nce789";
        MailMessage Mail = new MailMessage();
        Mail.From = new MailAddress("mailtofourlance@gmail.com");
        Mail.Subject = "Reset password mail";
        string body = "<b>Reset Password Mail.</b>";
        body += "<br/>http://localhost:59009/resetPassword.aspx?tokenId="+token ;
        Mail.IsBodyHtml = true;
        Mail.To.Add(new MailAddress("dhwanij0@gmail.com"));
        SmtpClient smtp = new SmtpClient();
        Mail.Body = body;
        smtp.Host = "relay-hosting.secureserver.net";
        //smtp.EnableSsl = true;
        smtp.Credentials = new NetworkCredential(id, pass);
        //System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
        //NetworkCred.UserName = "mailtofourlance@gmail.com";
        //NetworkCred.Password = "fourl@nce789";
        // smtp.UseDefaultCredentials = true;
        //smtp.Credentials = NetworkCred;
        smtp.Port = 25;
        smtp.Send(Mail);
    
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

