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
using Dao;

namespace ManagCond.Administrador
{
    public partial class EditarOtroGasto : System.Web.UI.Page
    {
        private int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownDepartamentos();
                LlenarDropDownListCargo();

                id = int.Parse(Request.QueryString["id"]);
                OtrosGastos otroGasto = OtrosGastosDao.ObtenerDatosOtrosGastos(id);

                DropDownListDepto.SelectedValue = otroGasto.IdDepto.ToString();
                DropDownListCargo.SelectedValue = otroGasto.IdGasto.ToString();
                TextBoxCantidad.Value = otroGasto.Cantidad.ToString();
                DropDownListMes.SelectedValue = otroGasto.Mes.ToString();
                DropDownListAño.SelectedValue = otroGasto.Año.ToString();
                TextBoxDesc.Value = otroGasto.Descripcion;

            }
        }

        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            int depto = int.Parse(DropDownListDepto.SelectedValue);
            int cargo = int.Parse(DropDownListCargo.SelectedValue);
            int cantidad = int.Parse(TextBoxCantidad.Value);
            int mes = int.Parse(DropDownListMes.SelectedValue);
            int año = int.Parse(DropDownListAño.SelectedValue);
            string descripcion = TextBoxDesc.Value;
            id = int.Parse(Request.QueryString["id"]);

            if (OtrosGastosDao.ModificarOtroGasto(id, mes, año, cargo, cantidad, depto, descripcion))
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