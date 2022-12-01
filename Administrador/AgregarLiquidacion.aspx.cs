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
    public partial class AgregarLiquidacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListRut();
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
            string rutTrabajador = DropDownListTrabajador.SelectedValue;
            int horasExtras = int.Parse(TextBoxHorasExtras.Text);
            int bonos = int.Parse(TextBoxBonos.Text);
            int diasNoTrabajados = int.Parse(TextBoxDiasNoTrabajados.Text);
            int otrosDescuentos = int.Parse(TextBoxOtrosDescuentos.Text);

            if (LiquidacionesDao.AgregarLiquidacion(rutTrabajador, horasExtras, bonos, diasNoTrabajados, otrosDescuentos))
            {
                Response.Redirect("Liquidaciones.aspx");
            }
            else
            {
                Response.Redirect("e.aspx");
            }
        }
        public void LlenarDropDownListRut()
        {
            int idCondominio = (int)Session["idCondominio"];
            SqlCommand cmd = new SqlCommand("Select c.rutTrabajador, CONCAT(c.rutTrabajador, ' - ', u.nombres, ' ', u.apellidos) nombre from contrato c inner join usuario u on c.rutTrabajador = u.rut where u.id_cond = " + idCondominio+" ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListTrabajador.DataSource = ds;
            DropDownListTrabajador.DataTextField = "nombre";
            DropDownListTrabajador.DataValueField = "rutTrabajador";
            DropDownListTrabajador.DataBind();
            DropDownListTrabajador.Items.Insert(0, new ListItem("Seleccione Trabajador", "0"));

        }
    }
}