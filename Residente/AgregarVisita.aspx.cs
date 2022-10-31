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
using System.Drawing;


namespace ManagCond.Residente
{
    public partial class AgregarVisita : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

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
                else
                {
                    int tipoUsuario = (int)Session["tipoUsuario"];

                    Usuario usuario = null;
                    usuario = (Usuario)Session["usuario"];

                }
            }
        }

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            string numDpto = Session["numDpto"].ToString();
            String rut = TextBoxRut.Text;
            String nombres = TextBoxNombres.Text;
            String apellidos = TextBoxApellidos.Text;
            String patente = TextBoxPatente.Text;
            int id_Cond = int.Parse(Session["idCond"].ToString());

            if (VisitaDao.AgregarVisitaR(numDpto, rut, nombres, apellidos, patente, id_Cond))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                Response.Redirect("Visitas.apx");
            }
        }
    }
}
