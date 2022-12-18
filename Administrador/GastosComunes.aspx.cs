using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;
using Model;

namespace ManagCond.Administrador
{
    public partial class GastosComunes : System.Web.UI.Page
    {
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();

        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownListFiltro();
                DropDownListMesF.SelectedValue = mesActual.ToString();
                DropDownListAñoF.SelectedValue = añoActual.ToString();
                Session["depto"] = "";

                Session["mes"] = int.Parse(mesActual.ToString());
                Session["año"] = int.Parse(añoActual.ToString());
            }
            if (Session["usuario"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!Session["tipoUsuario"].Equals(1))
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            int mes = int.Parse(DateTime.Now.ToString("MM"));
            int año = int.Parse(DateTime.Now.ToString("yyyy"));
            int idCond = int.Parse(Session["idCondominio"].ToString());

            int mesN = int.Parse(DateTime.Now.ToString("MM")) -1;

            DateTimeFormatInfo formatoFecha = CultureInfo.CurrentCulture.DateTimeFormat;
            string nombreMes = formatoFecha.GetMonthName(mesN);

            if (GastosComunesDao.GenerarGastoComun(mes, año, idCond))
            {

                foreach (Model.Residente residente in ResidenteDao.GetAlObtenerDatosResidente(idCond))
                {
                    Notificacion(residente.CorreoResidente, residente.NombresResidente,nombreMes, año);
                }
                Response.Redirect("GastosComunes.aspx");
            }
            else
            {
                Response.Redirect("GastosComune.aspx");
            }
        }
        protected void Notificacion(string EmailDestino, string nombre,string mes, int año)
        {
            string EmailOrigen = "managcond@outlook.com";
            string Contraseña = "Trompeta45@";

            string fecha = DateTime.Now.ToString("dd MMMM yyyy");
            string link = string.Format("https://managcond.azurewebsites.net/Residente/Visitas.aspx");

            string body = @"<h2>Gastos Comunes</h2><p>Estimado/a,  " + nombre + ":</p><p> Hoy " + fecha + " se acaba de emitir el gasto común del periodo correspondiente a "+mes+" "+ año + "</p><p> Atentamente,</p><p> Administración </p><br><div style = 'text-align: center;'><img style='width: 100px' src = 'https://managcondstorage.blob.core.windows.net/fotos/2022/11/3/logo.png?sp=r&st=2022-10-29T04:27:40Z&se=2023-01-31T12:27:40Z&spr=https&sv=2021-06-08&sr=c&sig=D9P23%2FM2m24SojVnKloNP3KCNGM5j%2B1NiTTVZqsHd6I%3D' /> </div> ";

            SmtpClient oSmtpCliente = new SmtpClient("smtp.office365.com")
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Port = 587,
                Credentials = new NetworkCredential(EmailOrigen, Contraseña)
            };

            MailMessage oMailMessage = new MailMessage(EmailOrigen, EmailDestino, "Gastos Comunes", body)
            {
                IsBodyHtml = true
            };

            oSmtpCliente.Send(oMailMessage);

            oSmtpCliente.Dispose();
        }
        public void LlenarDropDownListFiltro()
        {
            int idCond = int.Parse(Session["idCondominio"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id_Cond = " + idCond + " and not numDpto = 'No aplica'", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListDepto.DataSource = ds;
            DropDownListDepto.DataTextField = "numDpto";
            DropDownListDepto.DataValueField = "id";
            DropDownListDepto.DataBind();
            DropDownListDepto.Items.Insert(0, new ListItem("Todos", "0"));
        }
        protected void Depto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = "AND gc.idDpto= " + DropDownListDepto.SelectedValue;
            }
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
        }
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["Depto"] = "";
            }
            else
            {
                Session["Depto"] = "AND gc.idDpto = '" + DropDownListDepto.SelectedValue + "'";
            }
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["Depto"] = "";
            }
            else
            {
                Session["Depto"] = "AND gc.idDpto = '" + DropDownListDepto.SelectedValue + "'";
            }
        }
    }
}