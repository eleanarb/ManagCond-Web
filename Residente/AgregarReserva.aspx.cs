using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.Data.SqlClient;
using System.Data;

namespace ManagCond.Residente.Template
{
    public partial class AgregarReserva : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListDpto();
                LlenarDropDownListEspaciComun();
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

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {

            int numDpto = int.Parse(DropDownListDpto.SelectedValue);
            DateTime fecha = DateTime.Parse(inputFecha.Value);
            string fecha2 = fecha.ToString("yyyy-MM-dd");
            string rangofecha = DropDownRangoHorario.SelectedItem.Text;
            int espacioComun = int.Parse(DropDownListEspaciComun.SelectedValue);
            string solicitante = TextBoxSolicitante.Text;
            int idCond = int.Parse(Session["idCond"].ToString());


            if (ReservaDao.AgregarReserva(numDpto, fecha2, rangofecha, espacioComun, solicitante, idCond))
            {
                Response.Redirect("Reservas.aspx");
            }
            else
            {
                Response.Redirect("Reserva.aspx");
            }
        }
        protected void EspacioSeleccionado(object sender, EventArgs e)
        {
            int idEspacio = Convert.ToInt32(DropDownListEspaciComun.SelectedValue);

            LlenarDropDownRangoHorario(idEspacio);

        }
        public void LlenarDropDownListDpto()
        {
            int idCond = int.Parse(Session["idCond"].ToString());
            int numDpto = int.Parse(Session["numDpto"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id = " + numDpto + " and id_Cond = " + idCond + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListDpto.DataSource = ds;
            DropDownListDpto.DataTextField = "numDpto";
            DropDownListDpto.DataValueField = "id";
            DropDownListDpto.DataBind();
        }
        public void LlenarDropDownListEspaciComun()
        {
            int idCond = int.Parse(Session["idCond"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , nombre from espaciosComunes where id_Cond = " + idCond + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListEspaciComun.DataSource = ds;
            DropDownListEspaciComun.DataTextField = "nombre";
            DropDownListEspaciComun.DataValueField = "id";
            DropDownListEspaciComun.DataBind();
            DropDownListEspaciComun.Items.Insert(0, new ListItem("Seleccione Espacio Comun", "0"));
        }
        public void LlenarDropDownRangoHorario(int idEspacio)
        {
            SqlCommand cmd = new SqlCommand("Select id , rango  from rangoEspacioComun where idEspacioComun = " + idEspacio + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownRangoHorario.DataSource = ds;
            DropDownRangoHorario.DataTextField = "rango";
            DropDownRangoHorario.DataValueField = "id";
            DropDownRangoHorario.DataBind();
        }
    }
}