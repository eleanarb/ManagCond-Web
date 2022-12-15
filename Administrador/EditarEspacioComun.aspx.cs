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
    public partial class EditarEspacioComun : System.Web.UI.Page
    {
        private int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                id = int.Parse(Request.QueryString["id"]);
                int idCond = int.Parse(Session["idCondominio"].ToString());

                EspacioComun espacioComun = EspacioComunDao.BuscarEspacioComun(id, idCond);
                TextBoxNombre.Text = espacioComun.Nombre;
                TextBoxDesc.Text = espacioComun.Descripcion;
                TextBoxMonto.Text = espacioComun.Monto.ToString();
                string[] horario = espacioComun.RangoHorario.Split('-');
                string horariod = horario[0];
                string horario2 = horario[1];
                DropDownListHoraIncio.SelectedValue = horario[0];
                DropDownListHoraFin.SelectedValue = horario[1];
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

        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            id = int.Parse(Request.QueryString["id"]);
            string nombre = TextBoxNombre.Text;
            string descripcion = TextBoxDesc.Text;
            int monto = int.Parse(TextBoxMonto.Text);

            string horaInicio = DropDownListHoraIncio.SelectedItem.ToString();
            string horaFin = DropDownListHoraFin.SelectedItem.ToString();
            string rangoHorario = horaInicio + "-" + horaFin;

            int idCond = int.Parse(Session["idCondominio"].ToString());


            if (EspacioComunDao.ModificarEspacioComun(id, nombre, descripcion, monto, rangoHorario, idCond))
            {
                Response.Redirect("GestionarEspaciosComunes.aspx");
            }
            else
            {
                Response.Redirect("GestionarEspaciosComu.aspx");
            }
        }
    }
}