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

namespace ManagCond.Administrador
{
    public partial class AgregarEgreso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownProveedor();
                LlenarDropDownCategoria();
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

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];
            int idCond = usuario.IdCond;

            int categoria = int.Parse(DropDownListCategoria.SelectedValue);
            int proveedor = int.Parse(DropDownListProveedor.SelectedValue);
            DateTime fecha = DateTime.Parse(TextBoxFechaModal.Value);
            string fecha2 = fecha.ToString("yyyy-MM-dd");
            string descripcion = (TextBoxDescModal.Value).TrimEnd(' ');
            int monto = int.Parse((TextBoxMontoModal.Value).TrimEnd(' '));
            string estadoT = DropDownListEstado.SelectedValue;
            int estado = 0;
            if (estadoT.Equals("Pagado"))
            {
                estado = 2;
            }
            else if (estadoT.Equals("Pendiente"))
            {
                estado = 1;
            }

            if (EgresosDao.AgregarEgreso( proveedor, descripcion, categoria, fecha2, monto, estado, idCond))
            {
                Response.Redirect("Egresos.aspx");
            }
            else
            {
                Response.Redirect("f.aspx");
            }


        }



        public void LlenarDropDownProveedor()
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("SELECT  id, nombre  FROM proveedores WHERE idCond = '" + idCondominio + "' ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListProveedor.DataSource = ds;
            DropDownListProveedor.DataTextField = "nombre";
            DropDownListProveedor.DataValueField = "id";
            DropDownListProveedor.DataBind();
            DropDownListProveedor.Items.Insert(0, new ListItem("Seleccione proveedor", "0"));

        }

        public void LlenarDropDownCategoria()
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("SELECT  id, descripcion  FROM categoriaEgresos WHERE idCond = '" + idCondominio + "' ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListCategoria.DataSource = ds;
            DropDownListCategoria.DataTextField = "descripcion";
            DropDownListCategoria.DataValueField = "id";
            DropDownListCategoria.DataBind();
            DropDownListCategoria.Items.Insert(0, new ListItem("Seleccione categoría", "0"));

        }
    }
}