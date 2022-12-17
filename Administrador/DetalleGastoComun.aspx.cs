using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagCond.Administrador
{
    public partial class DetalleGastoComun : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = System.DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                DropDownListMes.SelectedValue = mesActual.ToString();
                DropDownListAño.SelectedValue = añoActual.ToString();
                Session["mes"] = int.Parse(mesActual.ToString());
                Session["año"] = int.Parse(añoActual.ToString());
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

        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMes.SelectedValue);
            Session["año"] = int.Parse(DropDownListAño.SelectedValue);
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMes.SelectedValue);
            Session["año"] = int.Parse(DropDownListAño.SelectedValue);
        }
    }
}