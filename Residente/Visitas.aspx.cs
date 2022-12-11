using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.Data.SqlClient;
using System.Data;

namespace ManagCond.Residente
{
    public partial class Visitas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownList();
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
                if (!Session["tipoUsuario"].Equals(3))
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            string numDpto = DropDownList.SelectedValue;
            string rut = TextBoxRut.Text;
            string nombres = TextBoxNombres.Text;
            string apellidos = TextBoxApellidos.Text;
            DateTime fecha = DateTime.Parse(TextBoxFecha.Value);
            string fecha2 = fecha.ToString("yyyy-MM-dd");
            string patente = TextBoxPatente.Text;
            int idCond = int.Parse(Session["idCond"].ToString());

            if (VisitaDao.AgregarVisitaR(numDpto, rut, nombres, apellidos, fecha2, patente, idCond))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                Response.Redirect("Visita.aspx");
            }
        }
        public void LlenarDropDownList()
        {
            int idCond = int.Parse(Session["idCond"].ToString());
            int numDpto = int.Parse(Session["numDpto"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id = " + numDpto + " and id_Cond = " + idCond + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownList.DataSource = ds;
            DropDownList.DataTextField = "numDpto";
            DropDownList.DataValueField = "id";
            DropDownList.DataBind();
        }
        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (VisitaDao.EliminarVisita(id))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                Response.Redirect("Visita.aspx");
            }
        }
        protected void ButtonAprobar_Click(object sender, EventArgs e)
        {

            int id = int.Parse(idVisita.Value);


            if (VisitaDao.AprobarVisita(id))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                string script = String.Format(@"<script type='text/javascript'>alert('No se puedo aprobar la visita');</script>");
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                Response.Redirect("Visitas.aspx");
            }

        }

        protected void ButtonRechazar_Click(object sender, EventArgs e)
        {

            int id = int.Parse(idVisita.Value);


            if (VisitaDao.RechazarVisita(id))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                string script = String.Format(@"<script type='text/javascript'>alert('No se puedo rechazar la visita');</script>");
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                Response.Redirect("Visitas.aspx");
            }

        }
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Mes_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Año_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
    }
}