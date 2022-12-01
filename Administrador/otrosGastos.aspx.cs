using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;

namespace ManagCond.Administrador
{
    public partial class otrosGastos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownDepartamentos();
                int mesActualC = int.Parse(fechaActual.ToString("MM"));
                DropDownListMesF.SelectedValue = mesActualC.ToString();
                DropDownListAñoF.SelectedValue = añoActual.ToString();
                DropDownListDepto.SelectedValue = "0";

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
            DropDownListDepto.Items.Insert(0, new ListItem("Todos", "0"));

        }

        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (OtrosGastosDao.EliminarOtroGasto(id))
            {
                Response.Redirect("otrosGastos.aspx");
            }
            else
            {
            }
        }
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = "AND og.idDpto = " + DropDownListDepto.SelectedValue;
            }
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = "AND og.idDpto = " + DropDownListDepto.SelectedValue;
            }
        }

        protected void Depto_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = "AND og.idDpto = " + DropDownListDepto.SelectedValue;
            }
        }
    }
}