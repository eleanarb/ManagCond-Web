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
        protected string Encrypt(string clearText)
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

        protected void ButtonClave_Click(object sender, EventArgs e)
        {
            string correo = Decrypt(HttpUtility.UrlDecode(Request.QueryString["correo"]));
            string clave2 = Encrypt(TextBoxClave2.Value);
            string clave3 = Encrypt(TextBoxClave3.Value);

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
            string EmailOrigen = "managcond2@hotmail.com";
            string Contraseña = "Trompeta45@";
            string fecha = DateTime.Now.ToString("dd MMMM");

            string body = @"<h2>Se restableció la contraseña de su cuenta registrada en ManagCond </h2>
                            <p>Estimado/a, " + nombre + ":</p><p> El " + fecha + " se restableció la contraseña de su cuenta registrada en ManagCond </p><p> Si no realizaste esta modificación o si cree que alguien ha accedido a su cuenta sin autorización, visita <a href='https://managcondstorages.blob.core.windows.net/fotos/2022/12/1/logo.png?sp=r&st=2022-12-19T04:30:41Z&se=2023-03-16T12:30:41Z&spr=https&sv=2021-06-08&sr=c&sig=XBx4%2BRHL6Cu9RJzFZjQo%2BhaUYsaFImM8y00Uv9npTqg%3D' /></div> ";

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