using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;
using Model;

namespace ManagCond.Guardia
{
    public partial class Listado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //int id = 5;
            //int idCond = int.Parse(Session["idCond"].ToString());
            //Encomienda encomienda = GuardiaDAO.BuscarEncomienda(id, idCond);
            //TextBox1.Text = encomienda.Destinatario;

            if (Session["usuario"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!Session["tipoUsuario"].Equals(2))
                {
                    Response.Redirect("../Login.aspx");
                }
                else
                {
                    int tipoUsuario = (int)Session["tipoUsuario"];

                    Usuario usuario = (Usuario)Session["usuario"];

                }
            }
        }
    }
}