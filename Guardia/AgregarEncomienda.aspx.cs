using Dao;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;

namespace ManagCond.Guardia
{
    public partial class AgregarEncomienda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownList();
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

                    Usuario usuario = null;
                    usuario = (Usuario)Session["usuario"];

                }
            }
        }

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            

            String montaje = FileUploadEncomienda.FileName;
            String numDpto = DropDownList.Text;
            String destinatario = TextBoxDestinatario.Text;
            String descripcion = TextBoxDescripcion.Text;

            string pathToCheck = HttpContext.Current.Server.MapPath("\\img\\" + montaje);
            string tempfileName = "";
            if (System.IO.File.Exists(pathToCheck))
            {
                int counter = 1;
                while (System.IO.File.Exists(pathToCheck))
                {

                    tempfileName = "(" + counter.ToString() + ") " + montaje;
                    pathToCheck = HttpContext.Current.Server.MapPath("\\img\\" + tempfileName);
                    counter++;
                }

                montaje = tempfileName;
            }

            if (UsuarioDao.AgregarEncomienda(numDpto, destinatario, descripcion, montaje))
            {
                Limpiar();
                //FileUploadEncomienda.SaveAs(HttpContext.Current.Server.MapPath("\\img\\" + montaje));
                Response.Redirect("Encomiendas.aspx");
            }
            else
            {
                Response.Redirect("Encomienda.aspx");
                //LabelMensaje.Text = "Error, usuario no agregado";
            }
        }
        public void Limpiar()
        {
            DropDownList.SelectedIndex = 0;
            TextBoxDestinatario.Text = "";
            TextBoxDescripcion.Text = "";
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
    }
}