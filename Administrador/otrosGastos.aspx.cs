using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;

namespace ManagCond.Administrador
{
    public partial class otrosGastos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (OtrosGastosDao.EliminarOtroGasto(id))
            {
                Response.Redirect("otrosGastos.aspx");
            }
            else
            {
            }


        }
    }
}