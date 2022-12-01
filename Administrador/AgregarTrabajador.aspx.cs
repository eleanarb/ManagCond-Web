using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using Dao;
using Model;

namespace ManagCond.Administrador
{
    public partial class AgregarTrabajador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListCargo();
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
            string rut = TextBoxRut.Text;
            int idCond = int.Parse(Session["idCondominio"].ToString());
            string nombres = TextBoxNombres.Text;
            string apellidos = TextBoxApellidos.Text;
            DateTime fechaNac = DateTime.Parse(inputFecha.Value);
            string fechaNac2 = fechaNac.ToString("yyyy-MM-dd");
            string correo = TextBoxCorreo.Text;
            string telefono = TextBoxTelefono.Text;
            int cargo = int.Parse(DropDownListCargo.SelectedValue);

            if (LiquidacionesDao.AgregarTrabajador(rut, idCond, nombres, apellidos, fechaNac2, correo, telefono, cargo))
            {
                Response.Redirect("Liquidaciones.aspx");
            }
            else
            {
                Response.Redirect("Liquidacione.aspx");
            }
        }
        public void LlenarDropDownListCargo()
        {
            SqlCommand cmd = new SqlCommand("Select id , descripcion from cargo WHERE NOT id = 4", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListCargo.DataSource = ds;
            DropDownListCargo.DataTextField = "descripcion";
            DropDownListCargo.DataValueField = "id";
            DropDownListCargo.DataBind();
            DropDownListCargo.Items.Insert(0, new ListItem("Seleccione cargo", "0"));

        }
    }
}