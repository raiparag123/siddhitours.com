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

public partial class AdminPages_CompanyMaster : System.Web.UI.Page
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
    public static string InsertCompanyName(string Name)
    {
        string status = "";
        AdminPages_CompanyMaster adm = new AdminPages_CompanyMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_INSERT_COMPANYNAME", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@COMPANYNAME", Name);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            //cmd.ExecuteNonQuery();
            //SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                //status = JsonConvert.SerializeObject(Convert.ToString(1) + "_" + Convert.ToString(ds.Tables[0].Rows[0]["ID"]));
                status = JsonConvert.SerializeObject(Convert.ToString(ds.Tables[0].Rows[0]["STATUS"]) + "_" + Convert.ToString(ds.Tables[0].Rows[0]["ID"]));
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
    public static string GetCompanyNames()
    {
        string status = "";
        AdminPages_CompanyMaster adm = new AdminPages_CompanyMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_COMPANYNAMES", con);
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
    public static string UpdateComapanyName(string CompId, string Name)
    {
        string status = "";
        AdminPages_CompanyMaster adm = new AdminPages_CompanyMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_COMPANYNAME", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@COMPID", CompId);
            cmd.Parameters.AddWithValue("@NAME", Name);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                //status = JsonConvert.SerializeObject(Convert.ToString(1) + "_" + Convert.ToString(ds.Tables[0].Rows[0]["ID"]));
                status = Convert.ToString(dt.Rows[0]["STATUS"]);
            }
            //cmd.ExecuteNonQuery();
            //status = "1";
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
    public static string DeleteTripType(string CompId)
    {
        string status = "";
        AdminPages_CompanyMaster adm = new AdminPages_CompanyMaster();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_COMPANYNAME", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@COMPID", CompId);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.ExecuteNonQuery();
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