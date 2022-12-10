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
    public partial class Visitas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListFiltro();
                LlenarDropDownListFiltro2();
                Session["depto"] = "";
                Session["depto2"] = "";
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
        public void LlenarDropDownListFiltro()
        {
            int idCond = int.Parse(Session["idCondominio"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id_Cond = " + idCond + " and not numDpto = 'No aplica'", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListDepto.DataSource = ds;
            DropDownListDepto.DataTextField = "numDpto";
            DropDownListDepto.DataValueField = "id";
            DropDownListDepto.DataBind();
            DropDownListDepto.Items.Insert(0, new ListItem("Todos", "0"));
        }
        public void LlenarDropDownListFiltro2()
        {
            int idCond = int.Parse(Session["idCondominio"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id_Cond = " + idCond + " and not numDpto = 'No aplica'", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListDepto2.DataSource = ds;
            DropDownListDepto2.DataTextField = "numDpto";
            DropDownListDepto2.DataValueField = "id";
            DropDownListDepto2.DataBind();
            DropDownListDepto2.Items.Insert(0, new ListItem("Todos", "0"));
        }
        protected void Depto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }

            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Depto_SelectedIndexChanged2(object sender, EventArgs e)
        {
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND V.numDpto= " + DropDownListDepto2.SelectedValue;
            }

            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND V.numDpto= " + DropDownListDepto.SelectedValue;
            }
        }
    }
}