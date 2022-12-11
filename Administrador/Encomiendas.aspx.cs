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
    public partial class Encomiendas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownListFiltro();
                LlenarDropDownListFiltro2();
                Session["depto"] = "";
                Session["depto2"] = "";
                DropDownListMesF.SelectedValue = mesActual.ToString();
                DropDownListAñoF.SelectedValue = añoActual.ToString();
                DropDownListMesF2.SelectedValue = mesActual.ToString();
                DropDownListAñoF2.SelectedValue = añoActual.ToString();
                Session["mes"] = int.Parse(mesActual.ToString());
                Session["año"] = int.Parse(añoActual.ToString());
                Session["mes2"] = int.Parse(mesActual.ToString());
                Session["año2"] = int.Parse(añoActual.ToString());
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
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND E.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND E.numDpto= " + DropDownListDepto2.SelectedValue;
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
                Session["depto"] = " AND E.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND E.numDpto= " + DropDownListDepto2.SelectedValue;
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
                Session["depto"] = " AND E.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND E.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Depto_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND E.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND E.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Mes_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND E.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND E.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
        protected void Año_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND E.numDpto= " + DropDownListDepto.SelectedValue;
            }

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
            if (DropDownListDepto2.SelectedValue == "0")
            {
                Session["depto2"] = "";
            }
            else
            {
                Session["depto2"] = " AND E.numDpto= " + DropDownListDepto2.SelectedValue;
            }
        }
    }
}