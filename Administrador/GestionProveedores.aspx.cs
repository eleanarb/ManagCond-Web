using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;

namespace ManagCond.Administrador
{
    public partial class GestionProveedores : System.Web.UI.Page
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

        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);

            int total;
            total = ProveedorDao.ObtenerTotalEgresosProveedor(id);

            if (total == 0)
            {
                if (ProveedorDao.EliminarProveedor(id))
                {
                    Response.Redirect("GestionProveedores.aspx");
                }
                else
                {
                }
            }
            else
            {
                Response.Redirect("a.aspx");
            }

            


        }
    }
}