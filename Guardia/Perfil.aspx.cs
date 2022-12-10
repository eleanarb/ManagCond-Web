using Dao;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagCond.Guardia
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            mensajeError.Visible = false;
            mensajeExitoso.Visible = false;
            mensajeErrorCorreo.Visible = false;
            string mensaje = (string)Session["mensaje"];
            if (mensaje == "1")
            {
                mensajeExitoso.Visible = true;
                mensajeError.Visible = false;
                mensajeErrorCorreo.Visible = false;
            }
            else if (mensaje == "2")
            {
                mensajeError.Visible = true;
                mensajeExitoso.Visible = false;
                mensajeErrorCorreo.Visible = false;
            }
            else if (mensaje == "3")
            {
                mensajeErrorCorreo.Visible = true;
                mensajeExitoso.Visible = false;
                mensajeError.Visible = false;
            }

            if (!IsPostBack)
            {
                Usuario usuario = (Usuario)Session["usuario"];
                Session["mensaje"] = "0";

                TextBoxNombres.Text = usuario.Nombres;
                TextBoxApellidos.Text = usuario.Apellidos;
                TextBoxRut.Value = usuario.Rut;
                TextBoxCorreo.Text = usuario.Correo;
                TextBoxTlf.Value = usuario.Telefono;
                TextBoxNac.Text = usuario.FechaNac.ToString("yyyy-MM-dd");

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
        public void MessageBox(string msg)
        {
            Page page = HttpContext.Current.Handler as Page;
            ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + msg + "');", true);
        }
        protected void ButtonPerfil_Click(object sender, EventArgs e)
        {
            Usuario usuario = (Usuario)Session["usuario"];
            string rut = usuario.Rut;
            string correo = TextBoxCorreo.Text;
            string telefono = TextBoxTlf.Value;

            int resultado = UsuarioDao.BuscarUsuario(correo);

            if (resultado == 0)
            {
                if (UsuarioDao.ModificarPerfil(rut, correo, telefono))
                {
                    Usuario usuarioN = UsuarioDao.ObtenerDatosUsuario(rut);
                    Session["usuario"] = usuarioN;
                    Session["mensaje"] = "1";
                    Response.Redirect("perfil.aspx");
                }
                else
                {
                    Session["mensaje"] = "2";
                    Response.Redirect("perfil.aspx");
                }
            }
            else
            {
                Session["mensaje"] = "3";
                Response.Redirect("perfil.aspx");
            }



        }
        protected void ButtonClave_Click(object sender, EventArgs e)
        {
            Usuario usuario = (Usuario)Session["usuario"];
            string rut = usuario.Rut;
            string clave1 = TextBoxClave1.Value;
            string clave2 = TextBoxClave2.Value;
            string clave3 = TextBoxClave3.Value;

            int resul = 0;
            resul = UsuarioDao.VerificarClave(rut, clave1);

            if (resul > 0)
            {
                if (clave2.Equals(clave3))
                {
                    if (UsuarioDao.ActualizarClave(rut, clave1, clave3))
                    {
                        Usuario usuarioN = UsuarioDao.ObtenerDatosUsuario(rut);
                        Session["usuario"] = usuarioN;
                        string EmailDestino = usuarioN.Correo;
                        string nombre = usuario.Nombres;
                        Notificacion(EmailDestino, nombre);
                        Session["mensaje"] = "1";
                        Response.Redirect("perfil.aspx");

                    }
                    else
                    {
                        Session["mensaje"] = "2";
                        Response.Redirect("perfil.aspx");
                    }
                }
                else
                {
                    Session["mensaje"] = "2";
                    Response.Redirect("perfil.aspx");
                }
            }
            else
            {
                Session["mensaje"] = "2";
                Response.Redirect("perfil.aspx");
            }

        }
        protected void Notificacion(string EmailDestino, string nombre)
        {
            string EmailOrigen = "managcond@outlook.com";
            string Contraseña = "Trompeta45@";
            string fecha = DateTime.Now.ToString("dd MMMM");

            string body = @"<h2>Se restableció la contraseña de su cuenta registrada en ManagCond </h2>
                            <p>Estimado/a, " + nombre + ":</p><p> El " + fecha + " se restableció la contraseña de su cuenta registrada en ManagCond </p><p> Si no realizaste esta modificación o si cree que alguien ha accedido a su cuenta sin autorización, visita <a href='https://managcond.azurewebsites.net/RecuperarClave.aspx'>Restablecer</a> para restablecer su contraseña inmediatamente </p><p> Si necesita ayuda adicional, comunícate con Soporte técnico de ManagCond.</p><p>Atentamente,</p><p>Soporte técnico de ManagCond</p><br><div style='text-align: center;'><img style = 'width: 100px' src ='https://managcondstorage.blob.core.windows.net/fotos/2022/11/3/logo.png?sp=r&st=2022-10-29T04:27:40Z&se=2023-01-31T12:27:40Z&spr=https&sv=2021-06-08&sr=c&sig=D9P23%2FM2m24SojVnKloNP3KCNGM5j%2B1NiTTVZqsHd6I%3D' /></div> ";

            SmtpClient oSmtpCliente = new SmtpClient("smtp.office365.com")
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Port = 587,
                Credentials = new NetworkCredential(EmailOrigen, Contraseña)
            };

            MailMessage oMailMessage = new MailMessage(EmailOrigen, EmailDestino, "Se restableció la contraseña de su cuenta", body)
            {
                IsBodyHtml = true
            };

            oSmtpCliente.Send(oMailMessage);

            oSmtpCliente.Dispose();
        }
    }
}