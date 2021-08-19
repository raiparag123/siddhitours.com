using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using TinifyAPI;

public partial class AdminPages_TourPackage : System.Web.UI.Page
{

    static string conn = ConfigurationManager.ConnectionStrings["ConnectDBString"].ConnectionString;
    public string flag = "";
    private string sLogFormat;
    private string sErrorTime;
    private string sErrorBody;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if (Convert.ToString(Session["user"]) == "")
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }

    

    public void insertPackage1()
    {
      
            SqlConnection con = new SqlConnection(conn);
            try
            {
            string compress = "";
            if (file1.HasFile)
            {

                string FileName = Server.MapPath("~/Images/BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file1.FileName);
                string path = ConfigurationManager.AppSettings["filePath"] + "BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file1.PostedFile.FileName;
                file1.PostedFile.SaveAs(FileName);
                compress = Server.MapPath(ConfigurationManager.AppSettings["filePath"] + "/CompressedBusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file1.PostedFile.FileName);
                using (var client = new HttpClient())
                {

                    // compress = "/Images/CompressedTripImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName;
                  
                    Tinify.Key = "a1llxbLnwsDD8SvNichjX616BCGko2zq";
                    //    //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.
                    //    Tinify.Proxy = "http://192.168.0.1:8080";
                    var source = Tinify.FromFile(FileName);
                    var resized = source.Resize(new
                    {
                        method = "fit",
                        width = 550,
                        height = 550
                    });
                    resized.ToFile(compress).Wait();
                }

            }
          
            
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand("SP_ADD_TOURPACKAGE", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PACKAGEID", hdnpackid1.Value);
                cmd.Parameters.AddWithValue("@PACKAGE", tripcost1.Text);
                cmd.Parameters.AddWithValue("@IMAGEPATH", compress);
                cmd.Parameters.AddWithValue("@FLAG", flag);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);
                // int value=cmd.ExecuteNonQuery();
                if (ds.Tables.Count > 0)
                {

                }
                //DataTable dt = new DataTable();
                //sda.Fill(dt);
                //if (dt.Rows.Count > 0)
                //{
                //    status = JsonConvert.SerializeObject(dt);
                //}

            }
            catch (System.Exception ex)
            {

                WriteErrorLog(ex.GetBaseException());
                ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));

            }
            finally
            {
                con.Dispose();
                con.Close();
                SqlConnection.ClearPool(con);
            }
        
    }

    //public void insertPackage2()
    //{
      
    //        SqlConnection con = new SqlConnection(conn);
    //        try
    //        {
    //        string compress = "";
    //        if (file2.HasFile)
    //        {
    //            string FileName = Server.MapPath("~/Images/BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file2.FileName);
    //            string path = ConfigurationManager.AppSettings["filePath"] + "BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file2.PostedFile.FileName;
    //            file1.PostedFile.SaveAs(FileName);
                
    //            using (var client = new HttpClient())
    //            {

    //                // compress = "/Images/CompressedTripImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName;
    //                compress = Server.MapPath(ConfigurationManager.AppSettings["filePath"] + "/CompressedBusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file2.PostedFile.FileName);
    //                Tinify.Key = "a1llxbLnwsDD8SvNichjX616BCGko2zq";
    //                //    //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.
    //                //    Tinify.Proxy = "http://192.168.0.1:8080";
    //                var source = Tinify.FromFile(FileName);
    //                var resized = source.Resize(new
    //                {
    //                    method = "fit",
    //                    width = 550,
    //                    height = 550
    //                });
    //                resized.ToFile(compress).Wait();
    //            }
    //        }

    //            if (con.State != ConnectionState.Open)
    //            {
    //                con.Open();
    //            }
    //            SqlCommand cmd = new SqlCommand("SP_ADD_TOURPACKAGE", con);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@PACKAGEID", hdnpackid2.Value);
    //            cmd.Parameters.AddWithValue("@PACKAGE", tripcost2.Text);
    //            cmd.Parameters.AddWithValue("@IMAGEPATH", compress);
    //            cmd.Parameters.AddWithValue("@FLAG", flag);
    //            SqlDataAdapter sda = new SqlDataAdapter(cmd);
    //            DataSet ds = new DataSet();

    //            sda.Fill(ds);
    //            // int value=cmd.ExecuteNonQuery();
    //            if (ds.Tables.Count > 0)
    //            {

    //            }
    //            //DataTable dt = new DataTable();
    //            //sda.Fill(dt);
    //            //if (dt.Rows.Count > 0)
    //            //{
    //            //    status = JsonConvert.SerializeObject(dt);
    //            //}

    //        }
    //        catch (SystemException ex)
    //        {

    //            WriteErrorLog(ex.GetBaseException());
    //            ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));

    //        }
    //        finally
    //        {
    //            con.Dispose();
    //            con.Close();
    //            SqlConnection.ClearPool(con);
    //        }
        
    //}

    //public void insertPackage3()
    //{

    //        SqlConnection con = new SqlConnection(conn);
    //        try
    //        {
    //        string compress = "";
    //        if (file3.HasFile)
    //        {
    //            string FileName = Server.MapPath("~/Images/BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file3.FileName);
    //            string path = ConfigurationManager.AppSettings["filePath"] + "BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file3.PostedFile.FileName;
    //            file1.PostedFile.SaveAs(FileName);
               
    //            using (var client = new HttpClient())
    //            {

    //                // compress = "/Images/CompressedTripImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName;
    //                compress = Server.MapPath(ConfigurationManager.AppSettings["filePath"] + "/CompressedBusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file3.PostedFile.FileName);
    //                Tinify.Key = "a1llxbLnwsDD8SvNichjX616BCGko2zq";
    //                //    //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.
    //                //    Tinify.Proxy = "http://192.168.0.1:8080";
    //                var source = Tinify.FromFile(FileName);
    //                var resized = source.Resize(new
    //                {
    //                    method = "fit",
    //                    width = 550,
    //                    height = 550
    //                });
    //                resized.ToFile(compress).Wait();
    //            }
    //        }
    //            if (con.State != ConnectionState.Open)
    //            {
    //                con.Open();
    //            }
    //            SqlCommand cmd = new SqlCommand("SP_ADD_TOURPACKAGE", con);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@PACKAGEID", hdnpackid3.Value);
    //            cmd.Parameters.AddWithValue("@PACKAGE", tripcost3.Text);
    //            cmd.Parameters.AddWithValue("@IMAGEPATH", compress);
    //            cmd.Parameters.AddWithValue("@FLAG", flag);

    //            SqlDataAdapter sda = new SqlDataAdapter(cmd);
    //            DataSet ds = new DataSet();

    //            sda.Fill(ds);
    //            // int value=cmd.ExecuteNonQuery();
    //            if (ds.Tables.Count > 0)
    //            {

    //            }
    //            //DataTable dt = new DataTable();
    //            //sda.Fill(dt);
    //            //if (dt.Rows.Count > 0)
    //            //{
    //            //    status = JsonConvert.SerializeObject(dt);
    //            //}

    //        }
    //        catch (SystemException ex)
    //        {

    //            WriteErrorLog(ex.GetBaseException());
    //            ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));

    //        }
    //        finally
    //        {
    //            con.Dispose();
    //            con.Close();
    //            SqlConnection.ClearPool(con);
    //        }
        
    //}

    //public void insertPackage4()
    //{

    //    SqlConnection con = new SqlConnection(conn);
    //    try
    //    {
    //        string compress = "";
    //        if (file3.HasFile)
    //        {
    //            string FileName = Server.MapPath("~/Images/BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file4.FileName);
    //            string path = ConfigurationManager.AppSettings["filePath"] + "BusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file4.PostedFile.FileName;
    //            file1.PostedFile.SaveAs(FileName);

    //            using (var client = new HttpClient())
    //            {

    //                // compress = "/Images/CompressedTripImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + PostedFile.FileName;
    //                compress = Server.MapPath(ConfigurationManager.AppSettings["filePath"] + "/CompressedBusinessImages/" + DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + file4.PostedFile.FileName);
    //                Tinify.Key = "a1llxbLnwsDD8SvNichjX616BCGko2zq";
    //                //    //Tinify.FromFile(Server.MapPath(path)).ToFile(Server.MapPath(compress)).Wait();.
    //                //    Tinify.Proxy = "http://192.168.0.1:8080";
    //                var source = Tinify.FromFile(FileName);
    //                var resized = source.Resize(new
    //                {
    //                    method = "fit",
    //                    width = 550,
    //                    height = 550
    //                });
    //                resized.ToFile(compress).Wait();
    //            }
    //        }
    //        if (con.State != ConnectionState.Open)
    //        {
    //            con.Open();
    //        }
    //        SqlCommand cmd = new SqlCommand("SP_ADD_TOURPACKAGE", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@PACKAGEID", hdnpackid3.Value);
    //        cmd.Parameters.AddWithValue("@PACKAGE", tripcost3.Text);
    //        cmd.Parameters.AddWithValue("@IMAGEPATH", compress);
    //        cmd.Parameters.AddWithValue("@FLAG", flag);

    //        SqlDataAdapter sda = new SqlDataAdapter(cmd);
    //        DataSet ds = new DataSet();

    //        sda.Fill(ds);
    //        // int value=cmd.ExecuteNonQuery();
    //        if (ds.Tables.Count > 0)
    //        {

    //        }
    //        //DataTable dt = new DataTable();
    //        //sda.Fill(dt);
    //        //if (dt.Rows.Count > 0)
    //        //{
    //        //    status = JsonConvert.SerializeObject(dt);
    //        //}

    //    }
    //    catch (SystemException ex)
    //    {

    //        WriteErrorLog(ex.GetBaseException());
    //        ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));

    //    }
    //    finally
    //    {
    //        con.Dispose();
    //        con.Close();
    //        SqlConnection.ClearPool(con);
    //    }

    //}


    [WebMethod]
    public static string GetTourPackage()
    {
        string status = "";

        AdminPages_TourPackage adm = new AdminPages_TourPackage();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_FE_TOURPACKAGE", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            sda.Fill(ds);
            if (ds.Rows.Count > 0)
            {
                status = JsonConvert.SerializeObject(ds);
            }



        }
        catch (SystemException ex)
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
    public static string DeletePackage(string PackageId)
    {

        string status = "";
        AdminPages_TourPackage adm = new AdminPages_TourPackage();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_DELETE_TOURPACKAGE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@COUNTRYNAME", CountryName);
            cmd.Parameters.AddWithValue("@PACKAGEID", PackageId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            sda.Fill(ds);
            status = "1";

        }
        catch (System.Exception ex)
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
    public static string EditPackage(string PackageId)
    {

        string status = "";
        AdminPages_TourPackage adm = new AdminPages_TourPackage();
        SqlConnection con = new SqlConnection(conn);
        try
        {
            if (con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlCommand cmd = new SqlCommand("SP_UPDATE_TOURPACKAGE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@COUNTRYNAME", CountryName);
            cmd.Parameters.AddWithValue("@PACKAGEID", PackageId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            sda.Fill(ds);
            status = "1";

        }
        catch (System.Exception ex)
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

    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        try
        {
            flag = "A";
            if (tripcost1.Text != "")
            {
                insertPackage1();
            }
            //if (tripcost2.Text != "")
            //{
            //    insertPackage2();
            //}
            //if (tripcost3.Text != "")
            //{
            //    insertPackage3();
            //}

            //if (tripcost4.Text != "")
            //{
            //    insertPackage4();
            //}



            string script = "window.onload = function() { showsuccess('TourPackage inserted successfully'); };";
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", script, true);
        }
        catch (System.Exception ex)
        {

           WriteErrorLog(ex.GetBaseException());
            ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            string script = "window.onload = function() { showerror('Error while inserting tourpackage '); };";
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", script, true);
        }
        

        tripcost1.Text = "";
        //tripcost2.Text = "";
        //tripcost3.Text = "";
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            flag = "E";

            if (tripcost1.Text != "")
            {
                insertPackage1();
            }
            //if (tripcost2.Text != "")
            //{
            //    insertPackage2();
            //}
            //if (tripcost3.Text != "")
            //{
            //    insertPackage3();
            //}
            string script = "window.onload = function() { showsuccess('TourPackage updated successfully'); };";
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", script, true);
            Response.Redirect("TourPackage.aspx");
        }
        catch (System.Exception ex)
        {

            WriteErrorLog(ex.GetBaseException());
            ErrorLog(System.Web.HttpContext.Current.ApplicationInstance.Server.MapPath("~/Logs/"));
            string script = "window.onload = function() { showerror('Error while updating tourpackage '); };";
            ClientScript.RegisterStartupScript(this.GetType(), "showsuccess", script, true);
        }
        tripcost1.Text = "";
        //tripcost2.Text = "";
        //tripcost3.Text = "";
    }
}