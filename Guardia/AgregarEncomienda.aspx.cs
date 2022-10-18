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
                //ConsultarImagenes();
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
            //Obtener datos imagen
            int tamano = FileUploadEncomienda.PostedFile.ContentLength;
            byte[] imagenOriginal = new byte[tamano];
            FileUploadEncomienda.PostedFile.InputStream.Read(imagenOriginal, 0, tamano);
            Bitmap imagenOriginalBinaria = new Bitmap(FileUploadEncomienda.PostedFile.InputStream);
            //Crear imagen Thumbnail
            System.Drawing.Image imtThumbnail;
            int tamanoThumbnail = 50;
            imtThumbnail = RedimencionarImagen(imagenOriginalBinaria, tamanoThumbnail);
            ImageConverter convertidor = new ImageConverter();
            byte[] bImagenThumbnail = (byte[])convertidor.ConvertTo(imtThumbnail, typeof(byte[]));
            string imagenDataURL64 = "data:image/jpg;base64," + Convert.ToBase64String(bImagenThumbnail);


            String numDpto = DropDownList.Text;
            String destinatario = TextBoxDestinatario.Text;
            String descripcion = TextBoxDescripcion.Text;



            if (UsuarioDao.AgregarEncomienda(numDpto, destinatario, descripcion, bImagenThumbnail.ToString()))
            {
                Limpiar();
                Response.Redirect("Encomiendas.aspx");
            }
            else
            {
                //LabelMensaje.Text = "Error, usuario no agregado";
            }

            ImagenEncomienda.ImageUrl = imagenDataURL64;
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
        public System.Drawing.Image RedimencionarImagen(System.Drawing.Image imagenOriginal, int Alto)
        {
            var radio = (double)Alto / imagenOriginal.Height;
            var nuevoAncho = (int)(imagenOriginal.Width * radio);
            var nuevoAlto = (int)(imagenOriginal.Height * radio);
            var nuevaImagenRedimencionada = new Bitmap(nuevoAncho, nuevoAlto);
            var g = Graphics.FromImage(nuevaImagenRedimencionada);
            g.DrawImage(imagenOriginal, 0, 0, nuevoAncho, nuevoAlto);
            return nuevaImagenRedimencionada;
        }
        //protected void ConsultarImagenes()
        //{
        //    String cadenaConexion = "Server=localhost\\SQLEXPRESS;Database=managcond;Trusted_Connection=True;";

        //    SqlConnection conexionSQL = new SqlConnection(cadenaConexion);
        //    SqlCommand cmd = new SqlCommand
        //    {
        //        CommandText = "SELECT numDpto,imagen FROM encomienda ORDER BY id ASC",
        //        CommandType = CommandType.Text,
        //        Connection = conexionSQL
        //    };
        //    conexionSQL.Open();

        //    DataTable imagenesBD = new DataTable();
        //    imagenesBD.Load(cmd.ExecuteReader());

        //    RepeaterImage.DataSource = imagenesBD;
        //    RepeaterImage.DataBind();
        //    conexionSQL.Close();

        //}
    }
}