using Newtonsoft.Json;
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

public partial class AdminPages_CruiseMaster : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["CruiseId"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["CruiseId"]);
                bindData(id);
            }
        }
    }

    public void bindData(int CruiseId)
    {
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_CRUISEDATABYID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            Session["cruise"] = ds;
            inclusion.InnerText = ds.Tables[0].Rows[0]["Inclusions"].ToString();
            exclusion.InnerText = ds.Tables[0].Rows[0]["Exclusions"].ToString();

            DataView dv1 = new DataView(ds.Tables[1]);
            dv1.RowFilter = "CruiseCabinId = 1";
            DataTable dt1 = dv1.ToTable();
            intdetail.InnerText = dt1.Rows[0]["Description"] != DBNull.Value ? dt1.Rows[0]["Description"].ToString() : string.Empty;

            DataView dv2 = new DataView(ds.Tables[1]);
            dv2.RowFilter = "CruiseCabinId = 2";
            DataTable dt2 = dv2.ToTable();
            oceanviewdetails.InnerText = dt2.Rows[0]["Description"] != DBNull.Value ? dt2.Rows[0]["Description"].ToString() : string.Empty;

            DataView dv3 = new DataView(ds.Tables[1]);
            dv3.RowFilter = "CruiseCabinId = 3";
            DataTable dt3 = dv3.ToTable();
            balconydetail.InnerText = dt3.Rows[0]["Description"] != DBNull.Value ? dt3.Rows[0]["Description"].ToString() : string.Empty;

            DataView dv4 = new DataView(ds.Tables[1]);
            dv4.RowFilter = "CruiseCabinId = 4";
            DataTable dt4 = dv4.ToTable();
            suitesdetail.InnerText = dt4.Rows[0]["Description"] != DBNull.Value ? dt4.Rows[0]["Description"].ToString() : string.Empty;

        }
        catch (Exception ex)
        {
            adm.WriteErrorLog(ex.GetBaseException());
            adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
        }
            //if (Session["CruiseTable"] != null)
            //{
            //    DataTable dt = (DataTable)(Session["CruiseTable"]);
            //    DataView dv = new DataView(dt);
            //    dv.RowFilter = "Tripid=" + Request.QueryString["CruiseId"];
            //    DataTable dtnew = dv.ToTable();

            //    //txtOverview.InnerText = dtnew.Rows[0]["TRIPOVERVIEW"].ToString();
            //    //inclusion.InnerText = dtnew.Rows[0]["TRIPINCLUSION"].ToString();
            //    //Exclusion.InnerText = dtnew.Rows[0]["TRIPEXCLUSION"].ToString();
            //}
        }

    [WebMethod]
    public static string getCountryList()
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
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
    public static string getCompanyList()
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_COMPANYLIST", con);
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
    public static string getOnBoardList()
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_ONBOARDACTIVITES", con);
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
    public static string InsertCruiseDetail(string Title, int days, int nights, string AlisaName, int Company, int Tax, int GAdult, int GChild, string Source, string Destination, string Inclusion, string Exclusion)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_CRUISE_DETAIL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TITLE", Title);
            cmd.Parameters.AddWithValue("@NODAYS", days);
            cmd.Parameters.AddWithValue("@NONIGHTS", nights);
            cmd.Parameters.AddWithValue("@ALIASNAME", AlisaName);
            cmd.Parameters.AddWithValue("@COMPANY", Company);
            cmd.Parameters.AddWithValue("@TAX", Tax);
            cmd.Parameters.AddWithValue("@GADULT", GAdult);
            cmd.Parameters.AddWithValue("@GCHILD", GChild);
            cmd.Parameters.AddWithValue("@PORTSOURCENAME", Source);
            cmd.Parameters.AddWithValue("@PORTDESTINATIONNAME", Destination);
            cmd.Parameters.AddWithValue("@INCLUSION", Inclusion);
            cmd.Parameters.AddWithValue("@EXCLUSION", Exclusion);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                status = JsonConvert.SerializeObject(Convert.ToString(ds.Tables[0].Rows[0]["status"]) + "_" + Convert.ToString(ds.Tables[0].Rows[0]["id"]));
                //status = Convert.ToString(ds.Tables[0].Rows[0]["status"]) + "_" + Convert.ToString(ds.Tables[0].Rows[0]["id"]);
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
    public static string UpdateCruiseDetail(int CruiseId, string Title, int days, int nights, string AlisaName, int Company, int Tax, int GAdult, int GChild, string Source, string Destination, string Inclusion, string Exclusion)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_CRUISE_DETAIL", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
            cmd.Parameters.AddWithValue("@TITLE", Title);
            cmd.Parameters.AddWithValue("@NODAYS", days);
            cmd.Parameters.AddWithValue("@NONIGHTS", nights);
            cmd.Parameters.AddWithValue("@ALIASNAME", AlisaName);
            cmd.Parameters.AddWithValue("@COMPANY", Company);
            cmd.Parameters.AddWithValue("@TAX", Tax);
            cmd.Parameters.AddWithValue("@GADULT", GAdult);
            cmd.Parameters.AddWithValue("@GCHILD", GChild);
            cmd.Parameters.AddWithValue("@PORTSOURCENAME", Source);
            cmd.Parameters.AddWithValue("@PORTDESTINATIONNAME", Destination);
            cmd.Parameters.AddWithValue("@INCLUSION", Inclusion);
            cmd.Parameters.AddWithValue("@EXCLUSION", Exclusion);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
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
    public static string InsertCabinPricing(int CruiseId, int [] CabinType, string [] Startdate, string [] Enddate, string [] price)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            int cnt = Startdate.Count();
            for (int i = 0; i < cnt;i++)
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_INSERT_CABIN_PRICE", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
                cmd.Parameters.AddWithValue("@CABINTYPE", CabinType[i]);
                cmd.Parameters.AddWithValue("@STARTDATE", Convert.ToDateTime(Startdate[i]));
                cmd.Parameters.AddWithValue("@ENDDATE", Convert.ToDateTime(Enddate[i]));
                cmd.Parameters.AddWithValue("@PRICE", Convert.ToDecimal(price[i]));
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
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
    public static string UpdateCabinPricing(int CruiseId, int[] CabinType, string[] Startdate, string[] Enddate, string[] price, int [] CabPriceId)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            int cnt = Startdate.Count();
            for (int i = 0; i < cnt; i++)
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_UPDATE_CABIN_PRICE", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
                cmd.Parameters.AddWithValue("@CABINTYPE", CabinType[i]);
                cmd.Parameters.AddWithValue("@STARTDATE", Convert.ToDateTime(Startdate[i]));
                cmd.Parameters.AddWithValue("@ENDDATE", Convert.ToDateTime(Enddate[i]));
                cmd.Parameters.AddWithValue("@PRICE", Convert.ToDecimal(price[i]));
                cmd.Parameters.AddWithValue("@CURCABPRICEID", Convert.ToDecimal(CabPriceId[i]));

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
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
    public static string InsertItenaryDetails(int CruiseId, int[] Days, string[] Details, string[] Arrival, string[] Depart)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            int cnt = Days.Count();
            for (int i = 0; i < cnt; i++)
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_INSERT_ITINEARY_DETAIL", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
                cmd.Parameters.AddWithValue("@DAY", Days[i]);
                cmd.Parameters.AddWithValue("@DETAIL", Details[i]);
                cmd.Parameters.AddWithValue("@ARRIVAL", Arrival[i]);
                cmd.Parameters.AddWithValue("@DEPART", Depart[i]);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
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
    public static string UpdateItenaryDetails(int CruiseId, int[] Days, string[] Details, string[] Arrival, string[] Depart, int [] ItenCurId)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            int cnt = Days.Count();
            for (int i = 0; i < cnt; i++)
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_UPDATE_ITINEARY_DETAIL", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
                cmd.Parameters.AddWithValue("@DAY", Days[i]);
                cmd.Parameters.AddWithValue("@DETAIL", Details[i]);
                cmd.Parameters.AddWithValue("@ARRIVAL", Arrival[i]);
                cmd.Parameters.AddWithValue("@DEPART", Depart[i]);
                cmd.Parameters.AddWithValue("@ITINERARYID", ItenCurId[i]);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
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
    public static string InsertOnboardActivities(int CruiseId, string[] OnboardCatId, string Flag)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            int cnt = OnboardCatId.Count();
            for (int i = 0; i < cnt; i++)
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_INSERT_ONBOARD_ACTIVITIES", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
                cmd.Parameters.AddWithValue("@ONBOARDCATEGORYID", Convert.ToInt32(OnboardCatId[i]));
                cmd.Parameters.AddWithValue("@FLAG", Flag);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
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
    public static string InsertCabinDescription(int CruiseId, int[] CabinId, string [] CabinDescription)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            int cnt = CabinId.Count();
            for (int i = 0; i < cnt; i++)
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_UPDATE_CABIN_DESCRIPTION", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
                cmd.Parameters.AddWithValue("@CABINID", CabinId[i]);
                cmd.Parameters.AddWithValue("@DESCRIPTION", CabinDescription[i]);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
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
    public static string InsertShipInfo(int CruiseId, int[] ShipId, string[] ShipDetail, string Flag)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            int cnt = ShipId.Count();
            for (int i = 0; i < cnt; i++)
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_INSERT_SHIPINFO", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
                cmd.Parameters.AddWithValue("@SHIPID", ShipId[i]);
                cmd.Parameters.AddWithValue("@DETAIL", ShipDetail[i]);
                cmd.Parameters.AddWithValue("@FLAG", Flag);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
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
    public static string GetCruiseMaster()
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_CRUISEMASTER", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            DataSet DT = new DataSet();
            sda.Fill(ds);
            if (ds.Rows.Count > 0)
            {
                HttpContext.Current.Session["CruiseTable"] = ds;
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
    public static string getCruiseImages(int CruiseId)
    {

        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_CRUISEIMAGES", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CRUISEID", CruiseId);
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
    public static string DeleteCruiseImages(int ImageId)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_CRUISEIMAGES", con);
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
    public static string GetCruiseMasterDetail(int CruiseId)
    {
        string status = "";
        AdminPages_CruiseMaster adm = new AdminPages_CruiseMaster();
        try
        {
            if (HttpContext.Current.Session["cruise"] != null)
            {
                DataSet ds = (DataSet)(HttpContext.Current.Session["cruise"]);
                status = JsonConvert.SerializeObject(ds.Tables[0]);
                status += "~" + JsonConvert.SerializeObject(ds.Tables[1]);
                status += "~" + JsonConvert.SerializeObject(ds.Tables[2]);
                status += "~" + JsonConvert.SerializeObject(ds.Tables[3]);
                status += "~" + JsonConvert.SerializeObject(ds.Tables[4]);
            }
        }
        catch (Exception ex)
        {
            adm.WriteErrorLog(ex.GetBaseException());
            adm.ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            status = "";
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