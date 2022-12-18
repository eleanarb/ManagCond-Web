using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace ManagCond.Residente
{
    public partial class Reservas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
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
                if (!Session["tipoUsuario"].Equals(3))
                {
                    Response.Redirect("../Login.aspx");
                }
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
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Mes_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Año_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
    }
}