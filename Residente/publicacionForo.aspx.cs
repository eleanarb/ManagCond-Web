﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;

namespace ManagCond.Residente
{
    public partial class publicacionForo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            int idForo = int.Parse(Request.QueryString["id"]);

            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];
            string rut = usuario.Rut;

            string mensaje = TextBoxMensaje.Value;
            string imagen = "";

            if (ForoDao.AgregarRespuestaForo(idForo, mensaje, rut, imagen))
            {
                Response.Redirect("publicacionForo.aspx?id=" + idForo);
            }
            else
            {
                Response.Redirect("f.aspx");
            }
        }
    }
}