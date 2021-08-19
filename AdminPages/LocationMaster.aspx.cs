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

public partial class AdminPages_LocationMaster : System.Web.UI.Page
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

    [WebMethod]
    public static string insertCountry(string CountryName)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_COUNTRY", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@COUNTRY", CountryName);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            sda.Fill(ds);
            // int value=cmd.ExecuteNonQuery();
            if (ds.Tables.Count > 0)
            {
                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
            }
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
    public static string EditCountry(string CountryName,string countryId)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_COUNTRY", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@COUNTRYNAME", CountryName);
            cmd.Parameters.AddWithValue("@COUNTRYID", countryId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            sda.Fill(ds);
            // int value=cmd.ExecuteNonQuery();
            if (ds.Tables.Count > 0)
            {
                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
            }
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
    public static string EditState(string CountryName, string StateId, string StateName)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_STATE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@COUNTRYID", CountryName);
            cmd.Parameters.AddWithValue("@STATEID", StateId);
            cmd.Parameters.AddWithValue("@STATENAME", StateName);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            sda.Fill(ds);
            // int value=cmd.ExecuteNonQuery();
            if (ds.Tables.Count > 0)
            {
                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
            }
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
    public static string EditPlace( string StateId, string CityName,string CityId)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_CITY", con);
            cmd.CommandType = CommandType.StoredProcedure;
           
            cmd.Parameters.AddWithValue("@CITYID", CityId);
            cmd.Parameters.AddWithValue("@CITYNAME", CityName);
            cmd.Parameters.AddWithValue("@STATEID", StateId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            sda.Fill(ds);
            // int value=cmd.ExecuteNonQuery();
            if (ds.Tables.Count > 0)
            {
                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
            }
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
    public static string DeleteCountry(string countryId)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_COUNTRY", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@COUNTRYNAME", CountryName);
            cmd.Parameters.AddWithValue("@COUNTRYID", countryId);
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

    [WebMethod]
    public static string DeleteState(string Stateid)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_STATE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@COUNTRYNAME", CountryName);
            cmd.Parameters.AddWithValue("@STATEID", Stateid);
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


    [WebMethod]
    public static string DeletePlace(string CityId)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_CITY", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@COUNTRYNAME", CountryName);
            cmd.Parameters.AddWithValue("@CITYID", CityId);
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



    [WebMethod]
    public static string getCountryList()
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
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
    public static string insertState(string CountryId,string StateName)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_STATE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@COUNTRY", CountryId);
            cmd.Parameters.AddWithValue("@STATE", StateName);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
           
            sda.Fill(ds);
            // int value=cmd.ExecuteNonQuery();
            if (ds.Tables.Count > 0)
            {
                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
            }
            // cmd.ExecuteNonQuery();
            // status = "1";
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
    public static string getStateList()
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
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
    public static string insertCity(string CountryId, string StateName,string CityName)
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_CITY", con);
            cmd.CommandType = CommandType.StoredProcedure;
           
            cmd.Parameters.AddWithValue("@STATE", StateName);
            cmd.Parameters.AddWithValue("@CITY", CityName);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
           sda.Fill(ds);
           // int value=cmd.ExecuteNonQuery();
           if(ds.Tables.Count>0)
            {
                status = Convert.ToString(ds.Tables[0].Rows[0]["status"]);
            }
           
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
    public static string getCityList()
    {

        string status = "";
        AdminPages_LocationMaster adm = new AdminPages_LocationMaster();
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