using Dao;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagCond
{
    public partial class foro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListModal();
                LlenarDropDownListBuscar();
            }
        }

        protected void ButtonPublicar_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];

            string mensaje = TextBoxMensaje.Value;            
            string rut = usuario.Rut;
            string imagen = "";
            int idCond = usuario.IdCond;

            int categoria = int.Parse(DropDownListModal.SelectedValue);

            if (ForoDao.AgregarPublicacionForo(mensaje, rut, imagen, categoria, idCond))
            {
                Response.Redirect("foro.aspx");
            }
            else
            {
                Response.Redirect("f.aspx");
            }
        }

        public void LlenarDropDownListModal()
        {

            SqlCommand cmd = new SqlCommand("Select id , nombre from categoriaForo", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListModal.DataSource = ds;
            DropDownListModal.DataTextField = "nombre";
            DropDownListModal.DataValueField = "id";
            DropDownListModal.DataBind();

        }

        public void LlenarDropDownListBuscar()
        {

            SqlCommand cmd = new SqlCommand("Select id , nombre from categoriaForo", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListBuscar.DataSource = ds;
            DropDownListBuscar.DataTextField = "nombre";
            DropDownListBuscar.DataValueField = "id";
            DropDownListBuscar.DataBind();

        }
    }
}