using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;

namespace ManagCond.Guardia
{
    public partial class EditarVisitaR : System.Web.UI.Page
    {
        private String id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownList();
                LlenarDropDownListEstado();

                id = Request.QueryString["id"];
                int idCond = int.Parse(Session["idCond"].ToString());
                Visita visita = VisitaDao.BuscarVisita(int.Parse(id), idCond);
                int index = 0;
                foreach (ListItem item in DropDownList.Items)
                {
                    if (item.Value == visita.IdNumDpto.ToString()) break;
                    index++;
                }

                DropDownList.SelectedIndex = index;
                TextBoxRut.Text = visita.Rut;
                TextBoxNombres.Text = visita.Nombres;
                TextBoxApellidos.Text = visita.Apellidos;
                TextBoxPatente.Text = visita.Patente;
                DropDownListEstado.SelectedValue = visita.Estado;
            }
            if (Session["usuario"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!Session["tipoUsuario"].Equals(2))
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            int idCond = int.Parse(Session["idCond"].ToString());
            String numDpto = DropDownList.SelectedValue;
            String rut = TextBoxRut.Text;
            String nombres = TextBoxNombres.Text;
            String apellidos = TextBoxApellidos.Text;
            String patente = TextBoxPatente.Text;
            String estado = DropDownListEstado.SelectedValue;


            if (VisitaDao.ModificarVisitaG(id, idCond, numDpto, rut, nombres, apellidos, patente, estado))
            {
                Response.Redirect("Visitas.aspx");
            }
            else
            {
                Response.Redirect("Visita.aspx");
            }
        }
        public void LlenarDropDownList()
        {
            int idCond = int.Parse(Session["idCond"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id_Cond = " + idCond + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownList.DataSource = ds;
            DropDownList.DataTextField = "numDpto";
            DropDownList.DataValueField = "id";
            DropDownList.DataBind();

        }
        public void LlenarDropDownListEstado()
        {
            SqlCommand cmd = new SqlCommand("SELECT * from estadoVisita where id between 2 and 3", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListEstado.DataSource = ds;
            DropDownListEstado.DataTextField = "descripcion";
            DropDownListEstado.DataValueField = "id";
            DropDownListEstado.DataBind();

        }
    }
}