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
    public partial class tipoGastos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = int.Parse(ButtonModificar.Attributes["data-id"].ToString());
            Session["idTipoCargo"] = id;
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
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];

            string nombre = TextBoxNombre.Value;
            string descripcion = TextBoxDesc.Value;
            int monto = int.Parse(TextBoxMonto.Value);

            int multa = 0;
            if (MultaNo.Checked)
            {
                 multa = 1;
            }
            
            if (MultaSi.Checked)
            {
                 multa = 2;
            }
            int idCond = usuario.IdCond;



            if (OtrosGastosDao.AgregarTipoCargo(nombre, descripcion, monto, multa, idCond))
            {
                Response.Redirect("gestionCargos.aspx");
            }
            else
            {
                Response.Redirect("f.aspx");
            }
        }

        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxId.Value);
            string nombre = TextBoxNombreModal.Value;
            string descripcion = TextBoxDescModal.Value;
            int monto = int.Parse(TextBoxMontoModal.Value);
            int multa = 0;
            if (MultaNoModal.Checked)
            {
                multa = 1;
            }

            if (MultaSiModal.Checked)
            {
                multa = 2;
            }

            if (OtrosGastosDao.ModificarTipoCargo(id, nombre, descripcion, monto, multa))
            {

                Response.Redirect("gestionCargos.aspx");
            }
            else
            {
                Response.Redirect("g.aspx");
            }
        }

        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            
                Response.Redirect("g.aspx");
            
        }

    }
}