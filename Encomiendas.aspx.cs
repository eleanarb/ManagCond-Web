using Dao;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Dao;
using System.Data;

namespace ManagCond
{
    public partial class Encomiendas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownList();
            }    
        }
        public void Limpiar()
        {
            DropDownList.SelectedIndex = 0;
            TextBoxDestinatario.Text = "";
            TextBoxFecha.Text = "";
            TextBoxHora.Text = "";
            TextBoxDescripcion.Text = "";
            TextBoxEstado.Text = "";
        }
        public void LlenarDropDownList()
        {
            SqlCommand cmd = new SqlCommand("Select numDpto from departamento", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownList.DataSource = ds;
            DropDownList.DataTextField = "numDpto";
            DropDownList.DataValueField = "numDpto";
            DropDownList.DataBind();
            DropDownList.Items.Insert(0, new ListItem("Seleccione departamento", "0"));

        }
        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            String numDpto = DropDownList.Text;
            String destinatario = TextBoxDestinatario.Text;
            String fecha = TextBoxFecha.Text;
            String hora = TextBoxHora.Text;
            String descripcion = TextBoxDescripcion.Text;
            String estado = TextBoxEstado.Text;

            Encomienda encomienda = new Encomienda(numDpto, destinatario, Convert.ToDateTime(fecha), hora, descripcion, int.Parse(estado));

            if (UsuarioDao.AgregarEncomienda(encomienda))
            {
                //LabelMensaje.Text = "Bien usuario agregado";
                Limpiar();
            }
            else
            {
                //LabelMensaje.Text = "Error, usuario no agregado";
            }
        }
    }
}