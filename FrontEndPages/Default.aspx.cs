using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Web;
using System.Web.Services;

public partial class _Default : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    public string flag = "";
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    public DataTable dtbanner;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["CurrencyFlag"]) != "")
        {
            currValue.Value = Session["CurrencyFlag"].ToString();
        }
        else
        {
            currValue.Value = "1";
            Session["CurrencyFlag"] = "1";
        }
        if (!IsPostBack)
        {
            getHomeBanners();
            getSubmenu();
        }
        
    }
    public void getSubmenu()
    {
        string status = "";

        _Default adm = new _Default();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_GETMENU_FRONT", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            sda.Fill(ds);
            string strMenu = "";
            if (ds.Rows.Count > 0)
            {
                strMenu += "<a href = '../frontendpages/trip.aspx' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='false'>Tours<span class='caret'></span></a><ul  class='dropdown-menu'>";
                for(int i = 0; i <= ds.Rows.Count - 1; i++)
                {
                    strMenu += "<li><a rel='external' href='../Frontendpages/trip.aspx?CategoryId=" + ds.Rows[i][0] + "'>" + ds.Rows[i][1] + "</li>";
                }
                strMenu += " <li><a rel='external' href ='../Frontendpages/Trending.aspx'> Trending</a> </li></ul></li>";
                category.InnerHtml = strMenu;
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
        //return status;
    }

    public void getHomeBanners()
    {
        string status = "";

        _Default adm = new _Default();
       
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_GETBANNER_FRONT", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            dtbanner = new DataTable();
            sda.Fill(dtbanner);
            string strbanner = "";
            if (dtbanner.Rows.Count > 0)
            {
                for (int i = 0; i <= dtbanner.Rows.Count - 1; i++) {
                    if (i == 0)
                    {
                        strbanner += "<div class='item active'>";
                    }
                    else
                    {
                        strbanner += "<div class='item'>";
                    }
                    
                   strbanner += "<div class='fill' style='background-image:url("+dtbanner.Rows[i]["ImagePath"]+");'></div>";
                    strbanner += "<div class='carousel-caption'>";
                    strbanner += "<h1>Siddhi Tours</h1>";

                    strbanner += "<h4>Discover our World Class Travel Experience</h4>";

                    strbanner += "<a href = '"+dtbanner.Rows[i]["ImagePath"]+"' class='btn btn-default btn-lg'>Go Explore</a>";
                    strbanner += " </div></div>";
                }
                banner.InnerHtml=strbanner;

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
       // return status;
    }


    [System.Web.Script.Services.ScriptMethod()]

    [System.Web.Services.WebMethod]

    public static List<string> GetSearchTrip(string prefixText)

    {
        List<string> CountryNames = new List<string>();
        try
        {

            using (SqlConnection sqlconn = new SqlConnection(conn))

            {

                sqlconn.Open();

                SqlCommand cmd = new SqlCommand("select distinct t as location from (" +
    "select  country as t from tripmaster where country != '0' " +
    "union " +
    "select distinct state as t from tripmaster where state != '0'" +
    "union  " +
    "select distinct city as t from tripmaster where city != '0'" +
    ") as a where a.t like '" + prefixText + "%' ", sqlconn);

                // cmd.Parameters.AddWithValue("@Loc", prefixText);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

               
                for (int i = 0; i < dt.Rows.Count; i++)


                {

                    CountryNames.Add(dt.Rows[i]["location"].ToString());

                }
            }
        }
        catch (Exception e)
        {

        }
            return CountryNames;

        

    }

    [WebMethod]
    public static string getHomeBanner()
    {
        string status = "";

        _Default adm = new _Default();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_GETBANNER_FRONT", con);
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
    public static string getTourPackage()
    {
        string status = "";

        _Default adm = new _Default();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_GETTOURPACKAGE_FRONT", con);
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
    public static string getServices()
    {
        string status = "";

        _Default adm = new _Default();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_GETSERVICE_FRONT", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                string rent = "";
                string b2b = "";
                string visa = "";
                string cruise = "";
                if (ds.Tables[0] != null)
                {
                    rent = JsonConvert.SerializeObject(ds.Tables[0]);
                }

                if (ds.Tables[1] != null)
                {
                    b2b = JsonConvert.SerializeObject(ds.Tables[1]);
                }

                if (ds.Tables[2] != null)
                {
                    visa = JsonConvert.SerializeObject(ds.Tables[2]);
                }
                if (ds.Tables[3] != null)
                {
                    cruise = JsonConvert.SerializeObject(ds.Tables[3]);
                }
                status = rent + "~" + b2b + "~" + visa+"~"+cruise;
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
    public static string getDestination()
    {
        string status = "";

        _Default adm = new _Default();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_DESTINATION_FRONT", con);
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
    public static string getMenu()
    {
        string status = "";

        _Default adm = new _Default();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_GETMENU_FRONT", con);
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
    public static string SetSession(string Value)
    {
        string status = "";

        _Default adm = new _Default();
        SqlConnection con = new SqlConnection(conn);
        try
        {

            HttpContext.Current.Session["CurrencyFlag"] = Value;


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

    [System.Web.Services.WebMethod]
    public static string SendMail(string Name, string Email, string Phone, string Message)
    {
       _Default adm = new _Default();
        string status = "";
        try
        {

            string id = "mailtofourlance@gmail.com";
            string pass = "fourl@nce789";
            MailMessage Mail = new MailMessage();
            Mail.From = new MailAddress("mailtofourlance@gmail.com");
            Mail.Subject = "Siddhi Tours";
            string body = "<b>Dear " + Name + "</b>";
            body += "<br/>Thank you for choosing Siddhi Tours";
            body += "<br/>We will get back to you as soon as possible";
            Mail.IsBodyHtml = true;
            Mail.To.Add(new MailAddress(Email));
            SmtpClient smtp = new SmtpClient();
            Mail.Body = body;
            smtp.Host = "relay-hosting.secureserver.net";
            smtp.EnableSsl = false;
            smtp.Credentials = new NetworkCredential(id, pass);
            //System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
            //NetworkCred.UserName = "mailtofourlance@gmail.com";
            //NetworkCred.Password = "fourl@nce789";
            // smtp.UseDefaultCredentials = true;
            //smtp.Credentials = NetworkCred;
            smtp.Port = 25;
            smtp.Send(Mail);


            MailMessage EMail = new MailMessage();
            EMail.From = new MailAddress("mailtofourlance@gmail.com");
            EMail.Subject = "Enquiry";
            string Ebody = "<table style='border:1px solid black'>";
            Ebody += "<tr><th>Name</th><th>Phone</th><th>Email</th><th>Message</th></tr>";
            Ebody += "<tr><td>" + Name + "</td><td>" + Phone + "</td><td>" + Email + "</td><td>" + Message + "</td></tr></table>";

            EMail.IsBodyHtml = true;
            EMail.To.Add(new MailAddress("dhwanij0@gmail.com"));
            SmtpClient Esmtp = new SmtpClient();
            EMail.Body = Ebody;
            Esmtp.Host = "relay-hosting.secureserver.net";
            Esmtp.EnableSsl = false;
            Esmtp.Credentials = new NetworkCredential(id, pass);
            //System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
            //NetworkCred.UserName = "mailtofourlance@gmail.com";
            //NetworkCred.Password = "fourl@nce789";
            // smtp.UseDefaultCredentials = true;
            //smtp.Credentials = NetworkCred;
            Esmtp.Port = 25;
            Esmtp.Send(EMail);
            status = "1";
        }
        catch (Exception ex)
        {

            adm.WriteErrorLog(ex.GetBaseException());
            adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            status = "" ;
        }
        finally
        {

        }
        return status;
    }

    [WebMethod]
    public static string GetContactUs()
    {
        string status = "";
        _Default adm = new _Default();
        string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_CONTACTUS_FOOTER", con);
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
            //adm.WriteErrorLog(ex.GetBaseException());
            //adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
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
}