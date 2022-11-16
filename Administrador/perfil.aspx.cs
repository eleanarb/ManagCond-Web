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
    public partial class perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {               
                Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];

                TextBoxNombres.Text = usuario.Nombres;
                TextBoxApellidos.Text = usuario.Apellidos;
                TextBoxRutt.Value = usuario.Rut;
                TextBoxCorreo.Text = usuario.Correo;
                TextBoxTlf.Value = usuario.Telefono;
                TextBoxNac.Text = usuario.FechaNac.ToString("yyyy-MM-dd");
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

        public void MessageBox(string msg)
        {
            Page page = HttpContext.Current.Handler as Page;
            ScriptManager.RegisterStartupScript(page, page.GetType(), "err_msg", "alert('" + msg + "');", true);
        }

        protected void ButtonPerfil_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];
            string rut = usuario.Rut;
            string correo = TextBoxCorreo.Text;
            string telefono = TextBoxTlf.Value;

            if(UsuarioDao.ModificarPerfil(rut, correo, telefono))
            {
                Usuario usuarioN = UsuarioDao.ObtenerDatosUsuario(rut);
                Session["usuario"] = usuarioN;
                Response.Redirect("perfil.aspx");
            }
            else
            {
                Response.Redirect("perfil.aspx");
            }
        }

        protected void ButtonClave_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];
            string rut = usuario.Rut;

        }
    }
}