﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;
using Model;
using Khipu.Api;
using Khipu.Client;
using Khipu.Model;

namespace ManagCond.Residente
{
    public partial class GastosComunes : System.Web.UI.Page
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
            int idDpto = int.Parse((string)Session["numDpto"]);
            Model.GastosComunes gc = null;
            gc = GastosComunesDao.ObtenerDatosUltimoGastoComun(idCondominio, idDpto);

            int total = gc.TotalPagar;
            string periodo = gc.MesCobro +" - "+ gc.AñoCobro;

            Configuration.ReceiverId = 432730;
            Configuration.Secret = "21e14d913cd4ee4bd3176fb1808130c6b7c23ca9";
            PaymentsApi a = new PaymentsApi();

            try
            {
                DateTime dt = DateTime.Now;
                dt = dt.AddDays(5);
                PaymentsCreateResponse response = a.PaymentsPost(
                    "Gasto Común de "+periodo,
                    "CLP",
                    total,
                    transactionId: "FACT2001",
                    expiresDate: dt,
                    body: "Descripción de la compra",
                    pictureUrl: "https://managcondstorage.blob.core.windows.net/fotos/2022/11/3/logo.png?sp=r&st=2022-10-29T04:27:40Z&se=2023-01-31T12:27:40Z&spr=https&sv=2021-06-08&sr=c&sig=D9P23%2FM2m24SojVnKloNP3KCNGM5j%2B1NiTTVZqsHd6I%3D",
                    returnUrl: "https://localhost:44338/PagoRealizado.aspx/",
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