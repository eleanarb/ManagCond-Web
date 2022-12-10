using Dao;
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
    public partial class Liquidaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownListRut(); 
                DropDownListMesF.SelectedValue = mesActual.ToString();
                DropDownListAñoF.SelectedValue = añoActual.ToString();
                DropDownListRut.SelectedValue = "0";

                Session["mes"] = int.Parse(mesActual.ToString());
                Session["año"] = int.Parse(añoActual.ToString());

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

        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListRut.SelectedValue == "0")
            {
                Session["rut"] = "";
            }
            else
            {
                Session["rut"] = "AND c.rutTrabajador = '" + DropDownListRut.SelectedValue + "'";
            }
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListRut.SelectedValue == "0")
            {
                Session["rut"] = "";
            }
            else
            {
                Session["rut"] = "AND c.rutTrabajador = '" + DropDownListRut.SelectedValue + "'";
            }
        }

        protected void Rut_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListRut.SelectedValue == "0")
            {
                Session["rut"] = "";
            }
            else
            {
                Session["rut"] = "AND c.rutTrabajador = '" + DropDownListRut.SelectedValue + "'";
            }
        }

        public void LlenarDropDownListRut()
        {
            int idCondominio = (int)Session["idCondominio"];
            SqlCommand cmd = new SqlCommand("Select c.rutTrabajador, CONCAT(c.rutTrabajador, ' - ', u.nombres, ' ', u.apellidos) nombre from contrato c inner join usuario u on c.rutTrabajador = u.rut where u.id_cond = " + idCondominio + " ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListRut.DataSource = ds;
            DropDownListRut.DataTextField = "nombre";
            DropDownListRut.DataValueField = "rutTrabajador";
            DropDownListRut.DataBind();
            DropDownListRut.Items.Insert(0, new ListItem("Todos", "0"));

        }
    }
}