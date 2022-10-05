using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;

namespace ManagCond
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            String correo = TextBoxUsuario.Text;
            String clave = TextBoxClave.Text;

            Usuario usuario = UsuarioDao.Login(correo, clave);

            if (usuario != null)
            {
                switch (usuario.TipoUsuario)
                {
                    case 1:
                        {
                            Session["usuario"] = usuario;
                            Response.Redirect("Administrador/dashboard.aspx");
                            break;
                        }
                    case 2:
                        {
                            Session["usuario"] = usuario;
                            Response.Redirect("Guardia/Index.aspx");
                            break;
                        }
                    case 3:
                        {
                            Session["usuario"] = usuario;
                            Response.Redirect("Residente/Index.aspx");
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