using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace ManagCond
{
    public partial class RecuperarClave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //mensajeError.Visible = false;
            //mensajeExitoso.Visible = false;
            string mensaje = (string)Session["mensaje"];
            if (mensaje == "1")
            {
                mensajeExitoso.Visible = true;
                mensajeError.Visible = false;
            }
            else if (mensaje == "2")
            {
                mensajeError.Visible = true;
                mensajeExitoso.Visible = false;
            }
            if (!IsPostBack)
            {
                Session["mensaje"] = "0";
            }
        }

        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {

            String correo = TextBoxUsuario.Text;

            int resul = 0;
            resul = UsuarioDao.BuscarUsuario(correo);
            Usuario usuario = UsuarioDao.ObtenerDatosUsuarioCorreo(correo);

            if (resul > 0)
            {
                string emailDestino = HttpUtility.UrlEncode(Encrypt(correo));
                Notificacion(emailDestino, usuario.Nombres, correo);
                Session["mensaje"] = "1";
                Response.Redirect("RecuperarClave.aspx");
            }
            else
            {
                Session["mensaje"] = "2";
                Response.Redirect("RecuperarClave.aspx");
            }


        }

        private string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        public static string MakeExpiryHash(DateTime expiry)
        {
            const string salt = "3256";
            byte[] bytes = Encoding.UTF8.GetBytes(salt + expiry.ToString("s"));
            using (var sha = System.Security.Cryptography.SHA1.Create())
                return string.Concat(sha.ComputeHash(bytes).Select(b => b.ToString("x2"))).Substring(8);
        }

        protected void Notificacion(string EmailDestino, string nombre, string EmailSinEncriptar)
        {
            string EmailOrigen = "managcond@outlook.com";
            string Contraseña = "Trompeta45@";
            string fecha = DateTime.Now.ToString("dd MMMM");

            DateTime expires = DateTime.Now + TimeSpan.FromHours(8);
            string hash = MakeExpiryHash(expires);
            string link = string.Format("https://managcond.azurewebsites.net/CambiarClave.aspx?correo=" + EmailDestino + "&exp={0}&k={1}", expires.ToString("s"), hash);

            string body = @"<h2>Recuperar contraseña</h2><p>Estimado/a,  " + nombre + ":</p><p> El " + fecha + " solicitó el restablecimiento de la contraseña de su cuenta registrada en ManagCond. Para completar el proceso, haz clic en el siguiente enlace.</p><a href=" + link + "> Restablecer </a><p> Si no realizaste esta modificación o si cree que alguien ha accedido a su cuenta sin autorización, visita <a href = 'https://managcond.azurewebsites.net/CambiarClave.aspx?correo=" + EmailDestino + "' > ManagCond </a> para restablecer su contraseña inmediatamente</p><p> Si necesita ayuda adicional, comunícate con Soporte técnico de ManagCond.</p><p> Atentamente,</p><p> Soporte técnico de ManagCond </p><br><div style = 'text-align: center;'><img style='width: 100px' src = 'https://managcondstorage.blob.core.windows.net/fotos/2022/11/3/logo.png?sp=r&st=2022-10-29T04:27:40Z&se=2023-01-31T12:27:40Z&spr=https&sv=2021-06-08&sr=c&sig=D9P23%2FM2m24SojVnKloNP3KCNGM5j%2B1NiTTVZqsHd6I%3D' /> </div> ";

            SmtpClient oSmtpCliente = new SmtpClient("smtp.office365.com")
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Port = 587,
                Credentials = new NetworkCredential(EmailOrigen, Contraseña)
            };

            MailMessage oMailMessage = new MailMessage(EmailOrigen, EmailSinEncriptar, "Recuperar contraseña", body)
            {
                IsBodyHtml = true
            };

            oSmtpCliente.Send(oMailMessage);

            oSmtpCliente.Dispose();
        }
    }
}