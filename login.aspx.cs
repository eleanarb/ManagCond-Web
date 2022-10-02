using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;
using Model;

namespace ManagCond
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            String correo = TextBoxUsuario.Text;
            String clave = TextBoxClave.Text;

            Usuario usuario = UsuarioDao.Login(correo, clave);
            Page.Response.Write("<script>console.log('" + correo + clave + "');</script>");

            if (usuario != null)
            {
                switch (usuario.TipoUsuario)
                {
                    case 1:
                        {
                            //Session["usuario"] = usuario;
                            Response.Redirect("dashboard.aspx");
                            break;
                        }
                    case 2:
                        {
                            //Session["usuario"] = usuario;
                            Response.Redirect("foro.aspx");
                            break;
                        }
                }
            }
            else
            {
                Response.Redirect("WebFormError.aspx");
            }
        }
    }
}