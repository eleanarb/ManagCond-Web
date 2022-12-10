using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;
using Model;

namespace ManagCond.Residente
{
    public partial class EditarVisita : System.Web.UI.Page
    {
        private String id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownList();

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
                inputFecha.Value = visita.Fecha.ToString();
            }
            if (Session["usuario"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!Session["tipoUsuario"].Equals(3))
                {
                    Response.Redirect("../Login.aspx");
                }
            }
        }
        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            int idCond = int.Parse(Session["idCond"].ToString());
            string numDpto = DropDownList.SelectedValue;
            string rut = TextBoxRut.Text;
            string nombres = TextBoxNombres.Text;
            string apellidos = TextBoxApellidos.Text;
            DateTime fecha = DateTime.Parse(inputFecha.Value);
            string fecha2 = fecha.ToString("yyyy-MM-dd");
            string patente = TextBoxPatente.Text;

            if (VisitaDao.ModificarVisitaR(id, idCond, numDpto, rut, nombres, apellidos, fecha2, patente))
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
            int numDpto = int.Parse(Session["numDpto"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id = " + numDpto + " and id_Cond = " + idCond + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownList.DataSource = ds;
            DropDownList.DataTextField = "numDpto";
            DropDownList.DataValueField = "id";
            DropDownList.DataBind();
        }
    }
}