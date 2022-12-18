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
    public partial class Foro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListModal();
                LlenarDropDownListBuscar();
                DropDownListBuscar.SelectedValue = "0";
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

        protected void ButtonPublicar_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];

            string mensaje = TextBoxMensaje.Value;
            string rut = usuario.Rut;
            string imagen = "";
            int idCond = usuario.IdCond;

            int categoria = int.Parse(DropDownListModal.SelectedValue);

            if (ForoDao.AgregarPublicacionForo(mensaje, rut, imagen, categoria, idCond))
            {
                Response.Redirect("foro.aspx");
            }
            else
            {
                Response.Redirect("f.aspx");
            }
        }

        public void LlenarDropDownListModal()
        {

            SqlCommand cmd = new SqlCommand("Select id , nombre from categoriaForo", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListModal.DataSource = ds;
            DropDownListModal.DataTextField = "nombre";
            DropDownListModal.DataValueField = "id";
            DropDownListModal.DataBind();

        }

        public void LlenarDropDownListBuscar()
        {

            SqlCommand cmd = new SqlCommand("Select id , nombre from categoriaForo", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListBuscar.DataSource = ds;
            DropDownListBuscar.DataTextField = "nombre";
            DropDownListBuscar.DataValueField = "id";
            DropDownListBuscar.DataBind();
            DropDownListBuscar.Items.Insert(0, new ListItem("Todos", "0"));

        }

        protected void Categeoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["categoria"] = int.Parse(DropDownListBuscar.SelectedValue);

            if (DropDownListBuscar.SelectedValue == "0")
            {
                Session["categoria"] = "";
            }
            else
            {
                Session["categoria"] = "and cf.id =  '" + DropDownListBuscar.SelectedValue + "'";
            }
        }
    }
}