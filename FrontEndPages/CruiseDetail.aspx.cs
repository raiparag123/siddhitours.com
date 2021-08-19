using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Net.Mail;

public partial class FrontEndPages_CruiseDetail : System.Web.UI.Page
{
    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    public string flag = "";
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string getCruiseDetail(string cruiseId,string Date)
    {

        string status = "";

        FrontEndPages_CruiseDetail adm = new FrontEndPages_CruiseDetail();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_CRUISE_DETAIL_FRONT", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CRUISEID", cruiseId);
            cmd.Parameters.AddWithValue("@DATE", Convert.ToDateTime(Date));
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables.Count > 0)
            {
                string CruiseMaster = "";
                string CabinPrice = "";
                string itenary = "";
                string onBoard = "";
                string Ship = "";
                if (ds.Tables[0].Rows.Count > 0)
                {
                    CruiseMaster = JsonConvert.SerializeObject(ds.Tables[0]);

                }
                if (ds.Tables[1].Rows.Count > 0)
                {
                    CabinPrice = JsonConvert.SerializeObject(ds.Tables[1]);

                }
                if (ds.Tables[2].Rows.Count > 0)
                {
                    itenary = JsonConvert.SerializeObject(ds.Tables[2]);

                }
                if (ds.Tables[3].Rows.Count > 0)
                {
                    onBoard = JsonConvert.SerializeObject(ds.Tables[3]);

                }
                if (ds.Tables[4].Rows.Count > 0)
                {
                    Ship = JsonConvert.SerializeObject(ds.Tables[4]);

                }
                status = CruiseMaster + "~" + CabinPrice + "~" + itenary + "~" + onBoard + "~" + Ship;
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

}