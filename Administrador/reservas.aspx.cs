using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;

namespace ManagCond
{
    public partial class reservas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
    }
}