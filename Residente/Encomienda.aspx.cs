using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;

namespace ManagCond.Residente
{
    public partial class Encomienda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                DropDownListMesF.SelectedValue = mesActual.ToString();
                DropDownListAñoF.SelectedValue = añoActual.ToString();
                DropDownListMesF2.SelectedValue = mesActual.ToString();
                DropDownListAñoF2.SelectedValue = añoActual.ToString();
                Session["mes"] = int.Parse(mesActual.ToString());
                Session["año"] = int.Parse(añoActual.ToString());
                Session["mes2"] = int.Parse(mesActual.ToString());
                Session["año2"] = int.Parse(añoActual.ToString());
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
            }
        }
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Mes_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);

            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
        protected void Año_SelectedIndexChanged2(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
 
            Session["mes2"] = int.Parse(DropDownListMesF2.SelectedValue);
            Session["año2"] = int.Parse(DropDownListAñoF2.SelectedValue);
        }
    }
}