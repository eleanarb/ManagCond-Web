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
                LlenarDropDownListEstado();

                id = Request.QueryString["id"];
                int idCond = int.Parse(Session["idCond"].ToString());
                Visita visita = VisitaDao.BuscarVisita(int.Parse(id), idCond);
              
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
                else
                {
                    int tipoUsuario = (int)Session["tipoUsuario"];

                    Usuario usuario = (Usuario)Session["usuario"];
                }
            }
        }
        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            id = Request.QueryString["id"];
            int idCond = int.Parse(Session["idCond"].ToString());
            String numDpto = "1";
            String rut = "1";
            String nombres = "1";
            String apellidos = "1";
            String patente = "1";
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