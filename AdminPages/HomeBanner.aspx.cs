using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Configuration;
using System.IO;
using System.Web.Services;

public partial class AdminPages_HomeBanner : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            Session["Time"] = DateTime.Now.ToString();
        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["Time"] = Session["Time"];
    }

    [WebMethod]
    public static string getDestination()
    {
        string status = "";
        AdminPages_HomeBanner adm = new AdminPages_HomeBanner();
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
    public static string getHomeBanner()
    {
        string status = "";
        AdminPages_HomeBanner adm = new AdminPages_HomeBanner();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_HOME_BANNER", con);
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
    public static string getDestinationTour()
    {
        string status = "";
        AdminPages_HomeBanner adm = new AdminPages_HomeBanner();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_TOUR_LIST", con);
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        if (file1.HasFile)
        {
            string FileName = Server.MapPath("~/Images/HomeBanner/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file1.FileName);
            string path = ConfigurationManager.AppSettings["filePath"] + "HomeBanner/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file1.PostedFile.FileName;
            file1.PostedFile.SaveAs(FileName);

            SqlConnection con = new SqlConnection(conn);
            try
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_INSERT_HOME_BANNER", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@STRING", hdnDestination.Value);
                cmd.Parameters.AddWithValue("@IMAGEPATH", path);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable ds = new DataTable();
                sda.Fill(ds);
                if (ds.Rows.Count > 0)
                {

                }
                string script = "window.onload = function() { showsuccess('Banner inserted successfully'); };";
                ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", script, true);
               // Response.Redirect("Homebanner.aspx", false);
            }
            
            catch (Exception ex)
            {

                WriteErrorLog(ex.GetBaseException());
                ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
                string script = "window.onload = function() { showerror('Error while inserting banner '); };";
                ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", script, true);

            }
            finally
            {
                con.Dispose();
                con.Close();
                SqlConnection.ClearPool(con);
            }
            hdnDestination.Value = "";
        }
    
    }

    [WebMethod]
    public static string getBanner()
    {
        string status = "";
        AdminPages_HomeBanner adm = new AdminPages_HomeBanner();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_HOME_BANNER", con);
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
    public static string DeleteBanner(string bannerid)
    {
        string status = "";
        AdminPages_HomeBanner adm = new AdminPages_HomeBanner();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_HOME_BANNER", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@BANNERID", bannerid);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            sda.Fill(ds);
            if (ds.Rows.Count > 0)
            {
               
            }
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



}