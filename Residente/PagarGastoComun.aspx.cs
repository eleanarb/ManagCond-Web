using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Khipu.Api;
using Khipu.Client;
using Khipu.Model;
using Dao;
using Model;

namespace ManagCond.Residente
{
    public partial class PagarGastoComun : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!Session["tipoUsuario"].Equals(3))
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        protected void ButtonPagar_Click(object sender, EventArgs e)
        {
            int idCondominio = (int)Session["idCond"];
            int id = int.Parse(Request.QueryString["id"]);
            Model.GastosComunes gc = GastosComunesDao.ObtenerDatosGastoComun(idCondominio, id);

            string mes = "";
            if (gc.MesCobro == 1) { mes = "Enero"; }
            if (gc.MesCobro == 2) { mes = "Febrero"; }
            if (gc.MesCobro == 3) { mes = "Marzo"; }
            if (gc.MesCobro == 4) { mes = "Abril"; }
            if (gc.MesCobro == 5) { mes = "Mayo"; }
            if (gc.MesCobro == 6) { mes = "Junio"; }
            if (gc.MesCobro == 7) { mes = "Julio"; }
            if (gc.MesCobro == 8) { mes = "Agosto"; }
            if (gc.MesCobro == 9) { mes = "Septiembre"; }
            if (gc.MesCobro == 10) { mes = "Octubre"; }
            if (gc.MesCobro == 11) { mes = "Noviembre"; }
            if (gc.MesCobro == 12) { mes = "Diciembre"; }

            Configuration.ReceiverId = 432730;
            Configuration.Secret = "21e14d913cd4ee4bd3176fb1808130c6b7c23ca9";
            PaymentsApi a = new PaymentsApi();


            try
            {
                DateTime dt = DateTime.Now;
                dt = dt.AddDays(5);
                PaymentsCreateResponse response = a.PaymentsPost(
                    "Pago "+mes+" "+ gc.AñoCobro,
                    "CLP",
                    gc.TotalPagar,
                    transactionId: "FACT2001",
                    expiresDate: dt,
                    body: "Descripción de la compra",
                    pictureUrl: "",
                    returnUrl: "https://localhost:44338/Residente/PagoRealizado.aspx?id=" + gc.Id,
                    cancelUrl: "http://mi-ecomerce.com/backend/cancel",
                    notifyUrl: "http://mi-ecomerce.com/backend/notify",
                    notifyApiVersion: "1.3"
                 );
                Response.Redirect(response.PaymentUrl);
                var token = response.PaymentId;
                Page.Response.Write("<script>console.log('" + response.PaymentId + "');</script>");
                Page.Response.Write("<script>console.log('" + response.AppUrl + "');</script>");
                Page.Response.Write("<script>console.log('" + response.PaymentUrl + "');</script>");
            }
            catch (ApiException ev)
            {
                Console.WriteLine(ev);
            }


        }
    }
}