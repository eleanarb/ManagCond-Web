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

namespace ManagCond
{
    public partial class reservas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListFiltro();
                Session["depto"] = "";
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

        protected void ButtonAprobar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(idReserva.Value);

            if (ReservaDao.AprobarReserva(id))
            {
                Response.Redirect("reservas.aspx");
            }
            else
            {
                string script = String.Format(@"<script type='text/javascript'>alert('No se puede aprobar la reserva, la fecha está ocupada' );</script>");
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                Response.Redirect("reservas.aspx");
            }

        }
        protected void ButtonRechazar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(idReserva.Value);

            if (ReservaDao.RechazarReserva(id))
            {
                Response.Redirect("reservas.aspx");
            }
            else
            {
                string script = String.Format(@"<script type='text/javascript'>alert('No se puede aprobar la reserva, la fecha está ocupada' );</script>");
                ScriptManager.RegisterStartupScript(this, typeof(Page), "alerta", script, false);
                Response.Redirect("reservas.aspx");
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
        protected void Depto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownListDepto.SelectedValue == "0")
            {
                Session["depto"] = "";
            }
            else
            {
                Session["depto"] = " AND R.numDpto= " + DropDownListDepto.SelectedValue;
            }
        }
    }
}