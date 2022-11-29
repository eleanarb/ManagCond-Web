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
            if (!IsPostBack)
            {
                Session.Abandon();
                Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", ""));
            }
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
                            Session["tipoUsuario"] = 1;
                            Session["idCondominio"] = usuario.IdCond;

                            Response.Redirect("Administrador/dashboard.aspx");
                            break;
                        }
                    case 2:
                        {
                            Session["usuario"] = usuario;
                            Session["tipoUsuario"] = 2;
                            Session["idCond"] = usuario.IdCond;
                            Response.Redirect("Guardia/Index.aspx");
                            break;
                        }
                    case 3:
                        {
                            Session["usuario"] = usuario;
                            Session["tipoUsuario"] = 3;
                            Session["idCond"] = usuario.IdCond;
                            Session["numDpto"] = usuario.NumDpto;
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