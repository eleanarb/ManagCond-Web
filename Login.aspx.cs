using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace ManagCond
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            mensajeExitoso.Visible = false;
            mensajeError.Visible = false;
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
                Session.Abandon();
                Session.Clear();
                Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));            
            }
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

        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {

            String correo = TextBoxUsuario.Text;
            String clave = Encrypt(TextBoxClave.Text).Substring(0, 20);


            Usuario usuario = UsuarioDao.Login(correo, clave);

            if (usuario != null)
            {
                switch (usuario.TipoUsuario)
                {
                    case 1:
                        {
                            Session["usuario"] = usuario;
                            Session["tipoUsuario"] = 1;
                            Session["idCondominio"] = usuario.IdCond;

                            Response.Redirect("Administrador/dashboard.aspx");
                            break;
                        }
                    case 2:
                        {
                            Session["usuario"] = usuario;
                            Session["tipoUsuario"] = 2;
                            Session["idCond"] = usuario.IdCond;
                            Response.Redirect("Guardia/Index.aspx");
                            break;
                        }
                    case 3:
                        {
                            Session["usuario"] = usuario;
                            Session["tipoUsuario"] = 3;
                            Session["idCond"] = usuario.IdCond;
                            Session["numDpto"] = usuario.NumDpto;
                            Response.Redirect("Residente/Index.aspx");
                            break;
                        }
                }
            }
            else
            {
                Response.Redirect("WebFormError.aspx");
            }

        }
    }
}