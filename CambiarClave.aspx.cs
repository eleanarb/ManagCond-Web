using Dao;
using Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagCond
{
    public partial class CambiarClave : System.Web.UI.Page
    {
        string correo = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime expires = DateTime.Parse(Request.Params["exp"]);
            string hash = MakeExpiryHash(expires);
            if (Request.Params["k"] == hash)
            {
                if (expires < DateTime.UtcNow)
                {
                    Response.Redirect("vencio.aspx");
                }
            }
            else
            {
                Response.Redirect("invalido.aspx");
            }           
            

            if (!IsPostBack)
            {
                Session["mensaje"] = "0";
                correo = Decrypt(HttpUtility.UrlDecode(Request.QueryString["correo"]));
            }
        }

        private string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }

        protected void ButtonClave_Click(object sender, EventArgs e)
        {
            
            string clave2 = TextBoxClave2.Value;
            string clave3 = TextBoxClave3.Value;

            Usuario usuario = UsuarioDao.ObtenerDatosUsuarioCorreo(correo);
            if (usuario == null)
            {
                Session["mensaje"] = "2";
                Response.Redirect("CambiarClave.aspx?correo=" + correo + "");
            }
            else
            {
                string rut = usuario.Rut;


                    if (clave2.Equals(clave3))
                    {
                        if (UsuarioDao.CambiarClave(rut, clave3))
                        {
                            Usuario usuarioN = UsuarioDao.ObtenerDatosUsuario(rut);
                            Session["usuario"] = usuarioN;
                            string EmailDestino = usuarioN.Correo;
                            string nombre = usuario.Nombres;
                            Notificacion(EmailDestino, nombre);
                            Session["mensaje"] = "1";
                            Response.Redirect("Login.aspx");

                        }
                        else
                        {
                            Session["mensaje"] = "2";
                            Response.Redirect("Login.aspx");
                        }
                    }
                    else
                    {
                        Session["mensaje"] = "2";
                        Response.Redirect("Login.aspx");
                    }
                }           


        }
        public static string MakeExpiryHash(DateTime expiry)
        {
            const string salt = "3256";
            byte[] bytes = Encoding.UTF8.GetBytes(salt + expiry.ToString("s"));
            using (var sha = System.Security.Cryptography.SHA1.Create())
                return string.Concat(sha.ComputeHash(bytes).Select(b => b.ToString("x2"))).Substring(8);
        }

        protected void Notificacion(string EmailDestino, string nombre)
        {
            string EmailOrigen = "managcond@outlook.com";
            string Contraseña = "Trompeta45@";
            string fecha = DateTime.Now.ToString("dd MMMM");

            string body = @"<h2>Se restableció la contraseña de su cuenta registrada en ManagCond </h2>
                            <p>Estimado/a, " + nombre + ":</p><p> El " + fecha + " se restableció la contraseña de su cuenta registrada en ManagCond </p><p> Si no realizaste esta modificación o si cree que alguien ha accedido a su cuenta sin autorización, visita <a href='https://managcond.azurewebsites.net/CambiarClave.aspx?correo=" + EmailDestino + "'> ManagCond </a> para restablecer su contraseña inmediatamente </p><p> Si necesita ayuda adicional, comunícate con Soporte técnico de ManagCond.</p><p>Atentamente,</p><p>Soporte técnico de ManagCond</p><br><div style='text-align: center;'><img style = 'width: 100px' src ='https://managcondstorage.blob.core.windows.net/fotos/2022/11/3/logo.png?sp=r&st=2022-10-29T04:27:40Z&se=2023-01-31T12:27:40Z&spr=https&sv=2021-06-08&sr=c&sig=D9P23%2FM2m24SojVnKloNP3KCNGM5j%2B1NiTTVZqsHd6I%3D' /></div> ";

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