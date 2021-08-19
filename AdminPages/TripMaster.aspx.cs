using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class AdminPages_TripMaster : System.Web.UI.Page
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
            if (Request.QueryString["TourId"] != null)
            {
                bindData();
            }
        }
    }

    public void bindData()
    {
        if (Session["table"] != null)
        {
            DataTable dt = (DataTable)(Session["table"]);
            DataView dv = new DataView(dt);
            dv.RowFilter = "Tripid=" + Request.QueryString["TourId"];
            DataTable dtnew = dv.ToTable();
            txtOverview.InnerText = dtnew.Rows[0]["TRIPOVERVIEW"].ToString();
            inclusion.InnerText= dtnew.Rows[0]["TRIPINCLUSION"].ToString();
            Exclusion.InnerText= dtnew.Rows[0]["TRIPEXCLUSION"].ToString();
        }
    }

    [WebMethod]
    public static string getCountryList()
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_COUNTRYLIST", con);
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
    public static string getTripMaster()
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {

            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_TRIPMASTER", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            sda.Fill(ds);
            if (ds.Rows.Count > 0)
            {
                HttpContext.Current.Session["table"] = ds;
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
    public static string InsertTripDetail(string Title,string Location,string  Cost,string Tour,int TourSeat,DateTime TourDate, string Theme,string OverView,
           string Inclusion,int Status,string Exclusion,DateTime ToDate,int Days,string Country,string State,string City)
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_TRIPMASTER_DETAIL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TITLE", Title);
            cmd.Parameters.AddWithValue("@LOCATION", Location);
            cmd.Parameters.AddWithValue("@COST", Cost);
            cmd.Parameters.AddWithValue("@TOUR", Tour);
            cmd.Parameters.AddWithValue("@TOURSEAT", TourSeat);
            cmd.Parameters.AddWithValue("@TOURDATE",TourDate);
            cmd.Parameters.AddWithValue("@THEME", Theme);
            cmd.Parameters.AddWithValue("@OVERVIEW", OverView);
            cmd.Parameters.AddWithValue("@INCLUSION", Inclusion);
            cmd.Parameters.AddWithValue("@EXCLUSION", Exclusion);
            cmd.Parameters.AddWithValue("@STATUS", Status);
            cmd.Parameters.AddWithValue("@TODATE", ToDate);
            cmd.Parameters.AddWithValue("@Days", Days);
            cmd.Parameters.AddWithValue("@COUNTRY", Country);
            cmd.Parameters.AddWithValue("@STATE", State);
            cmd.Parameters.AddWithValue("@CITY", City);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {

                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]) + "_" + Convert.ToString(ds.Tables[0].Rows[0]["id"]);
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
    public static string UpdateTripDetail(string Title, string Location, string Cost, string Tour, int TourSeat, DateTime TourDate, string Theme, string OverView,
         string Inclusion, int Status, string Exclusion, DateTime ToDate, int Days, string Country, string State, string City,string TourId)
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_TRIPMASTER_DETAIL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TITLE", Title);
            cmd.Parameters.AddWithValue("@LOCATION", Location);
            cmd.Parameters.AddWithValue("@COST", Cost);
            cmd.Parameters.AddWithValue("@TOUR", Tour);
            cmd.Parameters.AddWithValue("@TOURSEAT", TourSeat);
            cmd.Parameters.AddWithValue("@TOURDATE", TourDate);
            cmd.Parameters.AddWithValue("@THEME", Theme);
            cmd.Parameters.AddWithValue("@OVERVIEW", OverView);
            cmd.Parameters.AddWithValue("@INCLUSION", Inclusion);
            cmd.Parameters.AddWithValue("@EXCLUSION", Exclusion);
            cmd.Parameters.AddWithValue("@STATUS", Status);
            cmd.Parameters.AddWithValue("@TODATE", ToDate);
            cmd.Parameters.AddWithValue("@Days", Days);
            cmd.Parameters.AddWithValue("@COUNTRY", Country);
            cmd.Parameters.AddWithValue("@STATE", State);
            cmd.Parameters.AddWithValue("@CITY", City);
            cmd.Parameters.AddWithValue("@TOURID", TourId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {

                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]) ;
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
    public static string InsertTab2(int TripId,string Theme,string  Overview)
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_TRIPMASTER_TAB2", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TRIPID", TripId);
            cmd.Parameters.AddWithValue("@THEME", Theme);
            cmd.Parameters.AddWithValue("@OVERVIEW", Overview);
           
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {

                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
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
    public static string getTripImages(string Tripid)
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_TRIPIMAGES", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TRIPID", Tripid);
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
    public static string DeleteTripImages(string ImageId)
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_TRIPIMAGES", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMAGEID", ImageId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
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

    [WebMethod]
    public static string getCityList()
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_CITYLIST", con);
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
    public static string getStateList()
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_STATELIST", con);
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
    public static string GetTripType()
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
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
            if (dt.Rows.Count > 0)
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
    public static string getThemeList()
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_TRIPTHEME", con);
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
    public static string DeleteTrip(string TripID)
    {

        string status = "";
        AdminPages_TripMaster adm = new AdminPages_TripMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_TRIP", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TRIPID", TripID);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
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
}