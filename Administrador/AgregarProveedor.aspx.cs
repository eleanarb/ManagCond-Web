using Dao;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagCond.Administrador
{
    public partial class AgregarProveedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownRegion();
            }
        }

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];
            int idCond = usuario.IdCond;

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

            if (ProveedorDao.AgregarProveedor(idCond, nombre, telefono, correo, direccion,idComuna, nombrePago, rut, banco, tipoCuenta, tipoPago, numCuenta))
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