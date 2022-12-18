using Dao;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using System.Security.Cryptography;
using System.IO;
using System.Text;

namespace ManagCond.Administrador
{
    public partial class EditarProveedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownRegion();

                string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
                Proveedor proveedor = ProveedorDao.ObtenerDatosProveedor(int.Parse(id));

                TextBoxNombre.Value = proveedor.Nombre;
                TextBoxTelefono.Value = proveedor.Telefono;
                TextBoxCorreo.Value = proveedor.Correo;
                TextBoxDireccion.Value = proveedor.Direccion;
                TextBoxNombrePago.Value = proveedor.NombrePago;
                TextBoxRut.Value = proveedor.Rut;
                DropDownListRegion.SelectedValue = proveedor.IdRegion.ToString();
                DropDownListBanco.SelectedValue = proveedor.Banco;
                DropDownListCuenta.SelectedValue = proveedor.TipoCuenta;
                TextBoxNumero.Value = proveedor.NumCuenta;

                LlenarDropDownComuna(proveedor.IdRegion);
                DropDownListComuna.SelectedValue = proveedor.IdComuna.ToString();
                DropDownListPago.SelectedValue = proveedor.TipoPago;

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
            string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
            string idPago = Decrypt(HttpUtility.UrlDecode(Request.QueryString["idPago"]));
            string idDireccion = Decrypt(HttpUtility.UrlDecode(Request.QueryString["idDireccion"]));
            
            string nombre = TextBoxNombre.Value;
            string telefono = TextBoxTelefono.Value;
            string correo = TextBoxCorreo.Value;
            string direccion = TextBoxDireccion.Value;
            string nombrePago = TextBoxNombrePago.Value;
            string rut = TextBoxRut.Value;
            int idComuna = int.Parse(DropDownListComuna.SelectedValue);
            string banco = DropDownListBanco.SelectedValue;
            string tipoCuenta = DropDownListCuenta.SelectedValue;
            string tipoPago = DropDownListPago.SelectedValue;
            string numCuenta = TextBoxNumero.Value;

            if (ProveedorDao.ModificarProveedor(int.Parse(id), nombre, telefono, correo, direccion, int.Parse(idDireccion), idComuna, int.Parse(idPago), nombrePago, rut, banco, tipoCuenta, tipoPago, numCuenta))
            {
                Response.Redirect("GestionProveedores.aspx");
            }
            else
            {
            }
        }

        public void LlenarDropDownRegion()
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("SELECT  id, nombre  FROM region", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListRegion.DataSource = ds;
            DropDownListRegion.DataTextField = "nombre";
            DropDownListRegion.DataValueField = "id";
            DropDownListRegion.DataBind();
            DropDownListRegion.Items.Insert(0, new ListItem("Seleccione región", "0"));

        }

        public void LlenarDropDownComuna(long idRegion)
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("SELECT  id, nombre  FROM comuna where region = " + idRegion + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListComuna.DataSource = ds;
            DropDownListComuna.DataTextField = "nombre";
            DropDownListComuna.DataValueField = "id";
            DropDownListComuna.DataBind();
            DropDownListComuna.Items.Insert(0, new ListItem("Seleccione comuna", "0"));

        }

        protected void Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownListComuna.ClearSelection();
            LlenarDropDownComuna(long.Parse(DropDownListRegion.SelectedValue));
        }

        protected void Comuna_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}