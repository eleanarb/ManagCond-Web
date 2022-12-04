using Khipu.Api;
using Khipu.Client;
using Khipu.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagCond
{
    public partial class PagarGastosComunes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {

            Configuration.ReceiverId = 432730;
            Configuration.Secret = "21e14d913cd4ee4bd3176fb1808130c6b7c23ca9";
            PaymentsApi a = new PaymentsApi();

            try
            {
                DateTime dt = DateTime.Now;
                dt = dt.AddDays(5);
                PaymentsCreateResponse response = a.PaymentsPost(
                    "Compra de prueba de la API",
                    "CLP",
                    100.0,
                    transactionId: "FACT2001",
                    expiresDate: dt,
                    body: "Descripción de la compra",
                    pictureUrl: "http://mi-ecomerce.com/pictures/foto-producto.jpg",
                    returnUrl: "https://managcond.azurewebsites.net/PagoRealizado.aspx/",
                    cancelUrl: "http://mi-ecomerce.com/backend/cancel",
                    notifyUrl: "https://managcond.azurewebsites.net/PagoRealizado.aspx/",
                    notifyApiVersion: "1.3"
                 );
                Response.Redirect(response.PaymentUrl);

            }
            catch (ApiException ev)
            {
                Console.WriteLine(ev);
            }


        }
    }
}