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
        static class Pretty
        {
            public static void Print<T>(T x)
            {
                string json = JsonConvert.SerializeObject(x, Formatting.Indented);
                Console.WriteLine(json);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Configuration.ReceiverId = 432730;
            Configuration.Secret = "21e14d913cd4ee4bd3176fb1808130c6b7c23ca9";

            

            string notificationToken = HttpContext.Current.Request.Form["notification_token"];
            string apiVersion = HttpContext.Current.Request.Form["api_version"];

            Pretty.Print(notificationToken);

            double amount = 100;


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