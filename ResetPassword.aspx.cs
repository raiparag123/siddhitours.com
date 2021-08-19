using System;
using System.Web.UI.WebControls;
using System.Web.Services;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.IO;

public partial class ResetPassword : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Convert.ToString(Request.QueryString["tokenId"]) != "")
            {
                GetTokenValue();
            }
        }
    }

    public void GetTokenValue()
    {
        SqlConnection con = new SqlConnection(conn);
        try
        {


            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_TOKEN_DETAIL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@tokenId", Convert.ToString(Request.QueryString["tokenId"]));


            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                DateTime dtCreate = Convert.ToDateTime(dt.Rows[0]["CreatedDate"].ToString());
                DateTime dtNow = DateTime.Now;
                DateTime dtExp = dtCreate.AddDays(1);
                if (dtNow > dtExp)
                {
                    expiry.Visible = true;
                    displayPassword.Visible = false;
                }
                else
                {
                    expiry.Visible = false;
                    displayPassword.Visible = true;
                }
            }

            

          
            //con.Close();

        }
        catch (Exception ex)
        {
            ResetPassword ret = new ResetPassword();
            ret.WriteErrorLog(ex.GetBaseException());
            ret.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
           
        }
        finally
        {
            con.Dispose();
            con.Close();
            SqlConnection.ClearPool(con);
        }
    }
    [WebMethod]
    public static string ResetPass(string password)
    {

        string status = "";
        ResetPassword log = new ResetPassword();
        SqlConnection con = new SqlConnection(conn);
        try
        {


            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_ADMIN_PASSWORD", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PASSWORD", password);


            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            int success = cmd.ExecuteNonQuery();
          
                log.sendmail(password);

            status = "1";  
            
            
            //con.Close();

        }
        catch (Exception ex)
        {
            ResetPassword ret = new ResetPassword();
            ret.WriteErrorLog(ex.GetBaseException());
            ret.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
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
    public void sendmail( string password)
    {

        try
        {
            string id = "mailtofourlance@gmail.com";
            string pass = "fourl@nce789";
            MailMessage Mail = new MailMessage();
            Mail.From = new MailAddress("mailtofourlance@gmail.com");
            Mail.Subject = "Password changed successfully";
            string body = "<b>Password changed successfully.</b>";
            body += "<br/>Congratulation..Your password changed Successfully";
            Mail.IsBodyHtml = true;
            Mail.To.Add(new MailAddress("dhwanij0@gmail.com"));
            SmtpClient smtp = new SmtpClient();
            Mail.Body = body;
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            smtp.Credentials = new System.Net.NetworkCredential(id, pass);
            //System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
            //NetworkCred.UserName = "mailtofourlance@gmail.com";
            //NetworkCred.Password = "fourl@nce789";
            // smtp.UseDefaultCredentials = true;
            //smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(Mail);
        }
        catch (Exception ex)
        {
            ResetPassword ret = new ResetPassword();
            ret.WriteErrorLog(ex.GetBaseException());
            ret.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
           
        }

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
