using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.Net.Mail;
using System.Net;

namespace ManagCond.Guardia
{
    public partial class Visitas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownList();
                LlenarDropDownListFiltro();
                LlenarDropDownListFiltro2();
                Session["depto"] = "";
                Session["depto2"] = "";
                DropDownListMesF.SelectedValue = mesActual.ToString();
                DropDownListAñoF.SelectedValue = añoActual.ToString();
                DropDownListMesF2.SelectedValue = mesActual.ToString();
                DropDownListAñoF2.SelectedValue = añoActual.ToString();
                Session["mes"] = int.Parse(mesActual.ToString());
                Session["año"] = int.Parse(añoActual.ToString());
                Session["mes2"] = int.Parse(mesActual.ToString());
                Session["año2"] = int.Parse(añoActual.ToString());
            }
            if (Session["usuario"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!Session["tipoUsuario"].Equals(2))
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            String numDpto = DropDownList.SelectedValue;
            String rut = TextBoxRut.Text;
            String nombres = TextBoxNombres.Text;
            String apellidos = TextBoxApellidos.Text;
            String patente = TextBoxPatente.Text;
            int idCond = int.Parse(Session["idCond"].ToString());

            Usuario usuario = (Usuario)Session["usuario"];
            Model.Residente residente = ResidenteDao.ObtenerDatosResidenteNotifiacion(numDpto, usuario.IdCond);
            string emailDestino = residente.CorreoResidente;
            string nombreR = residente.NombresResidente;

            if (VisitaDao.AgregarVisitaG(numDpto, rut, nombres, apellidos, patente, idCond))
            {
                Notificacion(emailDestino, nombreR, nombres, apellidos);
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                Response.Redirect("Visita.aspx");
            }
        }
        protected void Notificacion(string emailDestino, string nombreR, string nombres, string apellidos)
        {
            string EmailOrigen = "managcond@outlook.com";
            string Contraseña = "Trompeta45@";
            string fecha = DateTime.Now.ToString("dd MMMM");

            string link = string.Format("https://managcond.azurewebsites.net/Residente/Encomienda.aspx");

            string body = @"<h2>Visita</h2><p>Estimado/a,  " + nombreR + ":</p><p> Hoy " + fecha + " Ha llegado " + nombres + " " + apellidos + " para aceptar o rechazar visita ingrese al apartado de vistas de la pagina de managcond </p><a href=" + link + ">Click aqui</a><p> Atentamente,</p><p> Administración </p><br><div style = 'text-align: center;'><img style='width: 100px' src = 'https://managcondstorage.blob.core.windows.net/fotos/2022/11/3/logo.png?sp=r&st=2022-10-29T04:27:40Z&se=2023-01-31T12:27:40Z&spr=https&sv=2021-06-08&sr=c&sig=D9P23%2FM2m24SojVnKloNP3KCNGM5j%2B1NiTTVZqsHd6I%3D' /> </div> ";

            SmtpClient oSmtpCliente = new SmtpClient("smtp.office365.com")
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Port = 587,
                Credentials = new NetworkCredential(EmailOrigen, Contraseña)
            };

            MailMessage oMailMessage = new MailMessage(EmailOrigen, emailDestino, "Visita en conserjeria", body)
            {
                IsBodyHtml = true
            };

            oSmtpCliente.Send(oMailMessage);

            oSmtpCliente.Dispose();
        }
        public void LlenarDropDownList()
        {
            int idCond = int.Parse(Session["idCond"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id_Cond = " + idCond + " and not numDpto = 'No aplica'", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownList.DataSource = ds;
            DropDownList.DataTextField = "numDpto";
            DropDownList.DataValueField = "id";
            DropDownList.DataBind();
            DropDownList.Items.Insert(0, new ListItem("Seleccione departamento", "0"));
        }
        public void LlenarDropDownListFiltro()
        {
            int idCond = int.Parse(Session["idCond"].ToString());

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
        public void LlenarDropDownListFiltro2()
        {
            int idCond = int.Parse(Session["idCond"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id_Cond = " + idCond + " and not numDpto = 'No aplica'", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListDepto2.DataSource = ds;
            DropDownListDepto2.DataTextField = "numDpto";
            DropDownListDepto2.DataValueField = "id";
            DropDownListDepto2.DataBind();
            DropDownListDepto2.Items.Insert(0, new ListItem("Todos", "0"));
        }
        protected void ButtonAprobar_Click(object sender, EventArgs e)
        {

            int id = int.Parse(idVisita.Value);


            if (VisitaDao.AprobarVisita(id))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                string script = String.Format(@"<script type='text/javascript'>alert('No se puedo aprobar la visita');</script>");
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                Response.Redirect("Visitas.aspx");
            }

        }

        protected void ButtonRechazar_Click(object sender, EventArgs e)
        {

            int id = int.Parse(idVisita.Value);


            if (VisitaDao.RechazarVisita(id))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                string script = String.Format(@"<script type='text/javascript'>alert('No se puedo rechazar la visita');</script>");
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                Response.Redirect("Visitas.aspx");
            }

        }
        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (VisitaDao.EliminarVisita(id))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                Response.Redirect("Visita.aspx");
            }
        }
        protected void Depto_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Depto_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Mes_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Año_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
    }
}