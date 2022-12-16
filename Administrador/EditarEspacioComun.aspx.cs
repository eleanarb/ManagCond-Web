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
            int idCond = int.Parse(Session["idCondominio"].ToString());


            if (EspacioComunDao.ModificarEspacioComun(id, nombre, descripcion, monto, idCond))
            {
                Response.Redirect("GestionarEspaciosComunes.aspx");
            }
            else
            {
                Response.Redirect("GestionarEspaciosComu.aspx");
            }
        }
        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            int idEspacioComun = id = int.Parse(Request.QueryString["id"]);
            string rangoHorario = DropDownListHoraIncio.SelectedValue +"-"+ DropDownListHoraFin.SelectedValue;

            if (EspacioComunDao.AgregarRangoHorario(idEspacioComun, rangoHorario))
            {
                Response.Redirect("EditarEspacioComun.aspx?id="+ idEspacioComun + "");
            }
            else
            {
                Response.Redirect("GestionarEspaciosComu.aspx");
            }
        }
        protected void ButtonModificarRango_Click(object sender, EventArgs e)
        {
            int idEspacioComun = int.Parse(Request.QueryString["id"]);
            int id = int.Parse(TextBoxId.Value);
            string rangoHorario = DropDownListHoraIncioModal.SelectedValue +"-"+ DropDownListHoraFinMdoal.SelectedValue;


            if (EspacioComunDao.ModificarRangoHorario(id, rangoHorario))
            {
                Response.Redirect("EditarEspacioComun.aspx?id=" + idEspacioComun + "");
            }
            else
            {
                Response.Redirect("GestionarEspas.aspx");
            }
        }
        protected void ButtoEliminar_Click(object sender, EventArgs e)
        {
            int idEspacioComun = int.Parse(Request.QueryString["id"]);
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (EspacioComunDao.EliminaRangoHorario(id))
            {
                Response.Redirect("EditarEspacioComun.aspx?id=" + idEspacioComun + "");
            }
            else
            {
                Response.Redirect("GestionarEspas.aspx");
            }
        }
    }
}