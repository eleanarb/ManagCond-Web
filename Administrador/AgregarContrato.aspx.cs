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


namespace ManagCond.Administrador
{
    public partial class AgregarContrato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListRutTrabajador();
                LlenarDropDownListRegion();
                LlenarDropDownListTipoContrato();
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
        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            string rutTrabajador = DropDownListRutTrabajador.SelectedValue;
            int sueldoBase = int.Parse(TextBoxSueldoBase.Text);
            int horasSemanales = int.Parse(TextBoxHorasSemanales.Text);
            int diasSemanales = int.Parse(TextBoxDiasSemanales.Text);
            int idTipoContrato = int.Parse(DropDownListTipoContrato.SelectedValue);
            DateTime fechaNacInicio = DateTime.Parse(inputFecha.Value);
            string fechaNacInicio2 = fechaNacInicio.ToString("yyyy-MM-dd");
            int asignacionMovilizacion = int.Parse(TextBoxAsignacionMovilizacion.Text);
            int asignacionColacion = int.Parse(TextBoxAsignacionColacion.Text);
            int valorHoraAdicional = int.Parse(TextBoxValorHoraAdicional.Text);
            string afp = DropDownListAFP.SelectedValue;
            string previsionSalud = DropDownListSalud.SelectedValue;
            string nombreDireccion = TextBoxDirección.Text;
            int idComuna = int.Parse(DropDownListComuna.SelectedValue);
            string nombreCuenta = TextBoxNombreCuenta.Text;
            string rut = TextBoxRut.Text;
            string banco = DropDownListBanco.SelectedValue;
            string numCuenta = TextBoxNumCuenta.Text;
            string medioPago = DropDownListPago.SelectedValue;
            string tipoCuneta = DropDownListCuenta.SelectedValue;
            if (LiquidacionesDao.AgregarContrato(rutTrabajador, sueldoBase, horasSemanales, diasSemanales, idTipoContrato, fechaNacInicio2, asignacionMovilizacion, asignacionColacion, valorHoraAdicional, afp, previsionSalud, nombreDireccion, idComuna, nombreCuenta, rut, banco, numCuenta, medioPago, tipoCuneta))
            {
                Response.Redirect("Liquidaciones.aspx");
            }
            else
            {
                Response.Redirect("Liquidacione.aspx");
            }
        }
        public void LlenarDropDownListRutTrabajador()
        {
            SqlCommand cmd = new SqlCommand("Select rut ,CONCAT(rut,' ',nombres,' ',apellidos) AS trabajador from usuario where not tipoUsuario = 3", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListRutTrabajador.DataSource = ds;
            DropDownListRutTrabajador.DataTextField = "trabajador";
            DropDownListRutTrabajador.DataValueField = "rut";
            DropDownListRutTrabajador.DataBind();
            DropDownListRutTrabajador.Items.Insert(0, new ListItem("Seleccione rut trabajador", "0"));
        }
        public void LlenarDropDownListRegion()
        {
            SqlCommand cmd = new SqlCommand("Select id , nombre from region", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListRegion.DataSource = ds;
            DropDownListRegion.DataTextField = "nombre";
            DropDownListRegion.DataValueField = "id";
            DropDownListRegion.DataBind();
            DropDownListRegion.Items.Insert(0, new ListItem("Seleccione region", "0"));
        }
        protected void DropDownListRegion_SelectedIndexChanged(object sender, EventArgs e)
        {
            int region = int.Parse(DropDownListRegion.SelectedValue);
            LlenarDropDownListComuna(region);
        }
        public void LlenarDropDownListComuna(int region)
        {
            SqlCommand cmd = new SqlCommand("Select id , nombre from comuna where region = "+ region +"", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListComuna.DataSource = ds;
            DropDownListComuna.DataTextField = "nombre";
            DropDownListComuna.DataValueField = "id";
            DropDownListComuna.DataBind();
            DropDownListComuna.Items.Insert(0, new ListItem("Seleccione comuna", "0"));
        }

        public void LlenarDropDownListTipoContrato()
        {
            SqlCommand cmd = new SqlCommand("Select id , descripcion from tipoContrato", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListTipoContrato.DataSource = ds;
            DropDownListTipoContrato.DataTextField = "descripcion";
            DropDownListTipoContrato.DataValueField = "id";
            DropDownListTipoContrato.DataBind();
            DropDownListTipoContrato.Items.Insert(0, new ListItem("Seleccione tipo de contrato", "0"));
        }

    }
}