using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;

namespace ManagCond.Administrador
{
    public partial class GestionarEspaciosComunes : System.Web.UI.Page
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

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            string nombre = TextBoxNombre.Text;
            string descripcion = TextBoxDesc.Text;
            int monto = int.Parse(TextBoxMonto.Text);

            string horaInicio = DropDownListHoraIncio.SelectedItem.ToString();
            string horaFin = DropDownListHoraFin.SelectedItem.ToString();
            string rangoHorario = horaInicio+"-"+horaFin;

            int idCond = int.Parse(Session["idCondominio"].ToString());

            if (EspacioComunDao.AgregarEspacioComun(nombre, descripcion, monto, rangoHorario, idCond))
            {
                Response.Redirect("GestionarEspaciosComunes.aspx");
            }
            else
            {
                Response.Redirect("GestionarEspaciosComu.aspx");
            }
        }

        protected void ButtoEliminar_Click(object sender, EventArgs e)
        {

        }
    }
}