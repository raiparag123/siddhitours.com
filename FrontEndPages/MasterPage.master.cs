using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class FrontEndPages_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["CurrencyFlag"]) != "")
        {
            currValue.Value = Session["CurrencyFlag"].ToString();
        }
        else
        {
            currValue.Value = "1";
        }
    }

    [System.Web.Services.WebMethod]
    public static string SendMail(string Name,string Email,string Phone,string Message)
    {
        string status = "";
        string id = "mailtofourlance@gmail.com";
        string pass = "fourl@nce789";
        MailMessage Mail = new MailMessage();
        Mail.From = new MailAddress("mailtofourlance@gmail.com");
        Mail.Subject = "Siddhi Tours";
        string body = "<b>Dear "+Name+"</b>";
        body += "<br/>Thank you for choosing Siddhi Tours";
        body += "<br/>We will get back to you as soon as possible";
        Mail.IsBodyHtml = true;
        Mail.To.Add(new MailAddress(Email));
        SmtpClient smtp = new SmtpClient();
        Mail.Body = body;
        smtp.Host = "relay-hosting.secureserver.net";
        //smtp.EnableSsl = true;
        smtp.Credentials = new NetworkCredential(id, pass);
        //System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
        //NetworkCred.UserName = "mailtofourlance@gmail.com";
        //NetworkCred.Password = "fourl@nce789";
        // smtp.UseDefaultCredentials = true;
        //smtp.Credentials = NetworkCred;
        smtp.Port = 25;
        smtp.Send(Mail);
        return status;
    }
}
