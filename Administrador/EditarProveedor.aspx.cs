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

namespace ManagCond.Administrador
{
    public partial class EditarProveedor : System.Web.UI.Page
    {
        private int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownRegion();

                id = int.Parse(Request.QueryString["id"]);
                Proveedor proveedor = ProveedorDao.ObtenerDatosProveedor(id);

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


        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(Request.QueryString["id"]); 
            int idPago = int.Parse(Request.QueryString["idPago"]);
            int idDireccion = int.Parse(Request.QueryString["idDireccion"]);
            
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

            if (ProveedorDao.ModificarProveedor(id, nombre, telefono, correo, direccion, idDireccion, idComuna, idPago, nombrePago, rut, banco, tipoCuenta, tipoPago, numCuenta))
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