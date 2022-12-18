using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;
using Model;

namespace ManagCond.Guardia
{
    public partial class EditarVisita : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownList();
                LlenarDropDownListEstado();

                string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
                int idCond = int.Parse(Session["idCond"].ToString());
                Visita visita = VisitaDao.BuscarVisita(int.Parse(id), idCond);
                int index = 0;
                foreach (ListItem item in DropDownList.Items)
                {
                    if (item.Value == visita.IdNumDpto.ToString()) break;
                    index++;
                }

                DropDownList.SelectedIndex = index;
                TextBoxRut.Text = visita.Rut;
                TextBoxNombres.Text = visita.Nombres;
                TextBoxApellidos.Text = visita.Apellidos;
                TextBoxPatente.Text = visita.Patente;
                DropDownListEstado.SelectedValue = visita.Estado;
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
        protected string Decrypt(string cipherText)
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
        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
            int idCond = int.Parse(Session["idCond"].ToString());
            String numDpto = DropDownList.SelectedValue;
            String rut = TextBoxRut.Text;
            String nombres = TextBoxNombres.Text;
            String apellidos = TextBoxApellidos.Text;
            String patente = TextBoxPatente.Text;
            String estado = DropDownListEstado.SelectedValue;


            if (VisitaDao.ModificarVisitaG(id, idCond, numDpto, rut, nombres, apellidos, patente, estado))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                Response.Redirect("Visita.aspx");
            }
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

        }
        public void LlenarDropDownListEstado()
        {
            SqlCommand cmd = new SqlCommand("SELECT * from estadoVisita where id between 1 and 3", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListEstado.DataSource = ds;
            DropDownListEstado.DataTextField = "descripcion";
            DropDownListEstado.DataValueField = "id";
            DropDownListEstado.DataBind();

        }
    }
}