using Dao;
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
    public partial class Egresos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = System.DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownProveedor();
                LlenarDropDownCategoria();
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

        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxId.Value);
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
            }else if (estadoT.Equals("Pendiente"))
            {
                estado = 1;
            }

            if (EgresosDao.ModificarEgreso(id, proveedor, descripcion, categoria, fecha2, monto, estado))
            {
                Response.Redirect("Egresos.aspx");
            }
            else
            {
                Response.Redirect("f.aspx");
            }
        }
        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (EgresosDao.EliminarEgreso(id))
            {
                Response.Redirect("Egresos.aspx");
            }
            else
            {
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