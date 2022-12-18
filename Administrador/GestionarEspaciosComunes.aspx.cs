using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.Security.Cryptography;
using System.IO;
using System.Text;

namespace ManagCond.Administrador
{
    public partial class GestionarEspaciosComunes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            string nombre = TextBoxNombre.Text;
            string descripcion = TextBoxDesc.Text;
            int monto = int.Parse(TextBoxMonto.Text);

            int idCond = int.Parse(Session["idCondominio"].ToString());

            if (EspacioComunDao.AgregarEspacioComun(nombre, descripcion, monto, idCond))
            {
                Response.Redirect("GestionarEspaciosComunes.aspx");
            }
            else
            {
                Response.Redirect("GestionarEspaciosComu.aspx");
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

        protected void ButtoEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (EspacioComunDao.EliminaEspacioComun(id))
            {
                Response.Redirect("GestionarEspaciosComunes.aspx");
            }
            else
            {
                Response.Redirect("GestionarEspas.aspx");
            }
        }
    }
}