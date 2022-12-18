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
using System.Security.Cryptography;
using System.IO;
using System.Text;

namespace ManagCond.Administrador
{
    public partial class EditarOtroGasto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownDepartamentos();
                LlenarDropDownListCargo();

                string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));

                OtrosGastos otroGasto = OtrosGastosDao.ObtenerDatosOtrosGastos(int.Parse(id));

                DropDownListDepto.SelectedValue = otroGasto.IdDepto.ToString();
                DropDownListCargo.SelectedValue = otroGasto.IdGasto.ToString();
                TextBoxCantidad.Value = otroGasto.Cantidad.ToString();
                DropDownListMes.SelectedValue = otroGasto.Mes.ToString();
                DropDownListAño.SelectedValue = otroGasto.Año.ToString();
                TextBoxDesc.Value = otroGasto.Descripcion;

            }
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

        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            int depto = int.Parse(DropDownListDepto.SelectedValue);
            int cargo = int.Parse(DropDownListCargo.SelectedValue);
            int cantidad = int.Parse(TextBoxCantidad.Value);
            int mes = int.Parse(DropDownListMes.SelectedValue);
            int año = int.Parse(DropDownListAño.SelectedValue);
            string descripcion = TextBoxDesc.Value;

            string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));

            if (OtrosGastosDao.ModificarOtroGasto(int.Parse(id), mes, año, cargo, cantidad, depto, descripcion))
            {
                Response.Redirect("otrosGastos.aspx");
            }
            else
            {
                Response.Redirect("f.aspx");
            }
        }

        public void LlenarDropDownDepartamentos()
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("select id, numDpto from departamento where not numDpto = 'No aplica' and id_cond = '" + idCondominio + "' ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListDepto.DataSource = ds;
            DropDownListDepto.DataTextField = "numDpto";
            DropDownListDepto.DataValueField = "id";
            DropDownListDepto.DataBind();
            DropDownListDepto.Items.Insert(0, new ListItem("Seleccione departamento", "0"));

        }

        public void LlenarDropDownListCargo()
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("select id, nombre from tipoGastos where idCond = '" + idCondominio + "' ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListCargo.DataSource = ds;
            DropDownListCargo.DataTextField = "nombre";
            DropDownListCargo.DataValueField = "id";
            DropDownListCargo.DataBind();
            DropDownListCargo.Items.Insert(0, new ListItem("Seleccione cargo", "0"));

        }
    }
}