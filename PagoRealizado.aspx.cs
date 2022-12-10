using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khipu.Api;
using Khipu.Client;
using Khipu.Model;
using Newtonsoft.Json;

namespace ManagCond
{
    public partial class PagoRealizado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Configuration.ReceiverId = 432730;
            Configuration.Secret = "21e14d913cd4ee4bd3176fb1808130c6b7c23ca9";

            string notificationToken = HttpContext.Current.Request.Form["notification_token"];
            string apiVersion = "1.3";
            Page.Response.Write("<script>console.log('"+ Configuration.Secret + "');</script>");
            double amount = 100;
            Page.Response.Write("<script>console.log('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');</script>");
            string[] keys = Request.Form.AllKeys;
            Page.Response.Write("<script>console.log('"+ Request.Form.AllKeys + "');</script>");
            for (int i = 0; i < keys.Length; i++)
            {
                Response.Write(keys[i] + ": " + Request.Form[keys[i]] + "<br>");
                Page.Response.Write("<script>console.log('" +  Request.Form[keys[i]] + "');</script>");
                Page.Response.Write("<script>console.log('dddddddddddddddddddddddddddddddddddddddddddd');</script>");
            }

            if (apiVersion.Equals("1.3"))
            {
                PaymentsApi a = new PaymentsApi();
                try
                {
                    PaymentsResponse response = a.PaymentsGet(notificationToken);
                    if (response.ReceiverId.Equals(Configuration.ReceiverId)
                           && response.Status.Equals("done") && response.Amount == amount)
                    {
                        
                    }
                    else
                    {
                    }
                    Page.Response.Write("<script>console.log('"+response.Status+"');</script>");
                    TextBoxNombre.Value = response.Status;
                }
                catch (ApiException ev)
                {
                    Console.WriteLine(ev);
                }
            }
        }
    }
}