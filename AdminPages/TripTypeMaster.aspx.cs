using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.IO;

public partial class AdminPages_TripTypeMaster : System.Web.UI.Page
{

    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Convert.ToString(Session["user"]) == "")
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }

    [WebMethod]
    public static string GetTripType()
    {

        string status = "";
        AdminPages_TripTypeMaster adm = new AdminPages_TripTypeMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_GET_TRIP_TYPES", con);
            cmd.CommandType = CommandType.StoredProcedure;
            
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if(dt.Rows.Count>0)
            {
                status = JsonConvert.SerializeObject(dt);
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
    public static string InsertTripType(string Type)
    {

        string status = "";
        AdminPages_TripTypeMaster adm = new AdminPages_TripTypeMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_TRIPTYPE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TRIPTYPE", Type);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.ExecuteNonQuery();
            status = "1";
            //DataTable dt = new DataTable();
            //sda.Fill(dt);
            //if (dt.Rows.Count > 0)
            //{
            //    status = JsonConvert.SerializeObject(dt);
            //}

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
    public static string UpdateTripType(string Type,string TripType)
    {

        string status = "";
        AdminPages_TripTypeMaster adm = new AdminPages_TripTypeMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_TRIPTYPE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TYPEID", Type);
            cmd.Parameters.AddWithValue("@TYPENAME", TripType);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.ExecuteNonQuery();
            status = "1";
            //DataTable dt = new DataTable();
            //sda.Fill(dt);
            //if (dt.Rows.Count > 0)
            //{
            //    status = JsonConvert.SerializeObject(dt);
            //}

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
    public static string DeleteTripType(string Type)
    {

        string status = "";
        AdminPages_TripTypeMaster adm = new AdminPages_TripTypeMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_TRIPTYPE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TYPEID", Type);
            
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.ExecuteNonQuery();
            status = "1";
            //DataTable dt = new DataTable();
            //sda.Fill(dt);
            //if (dt.Rows.Count > 0)
            //{
            //    status = JsonConvert.SerializeObject(dt);
            //}

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