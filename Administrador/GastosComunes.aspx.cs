﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;

namespace ManagCond.Administrador
{
    public partial class GastosComunes : System.Web.UI.Page
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
            int mes = int.Parse(DateTime.Now.ToString("MM"));
            int año = int.Parse(DateTime.Now.ToString("yyyy"));
            int idCond = int.Parse(Session["idCondominio"].ToString());

            if (GastosComunesDao.GenerarGastoComun(mes, año, idCond))
            {
                Response.Redirect("GastosComunes.aspx");
            }
            else
            {
                Response.Redirect("GastosComune.aspx");
            }
        }
    }
}