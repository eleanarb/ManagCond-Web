using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using Microsoft.WindowsAzure.Storage;
using System.Configuration;
using Microsoft.WindowsAzure.Storage.Blob;
using System.Threading.Tasks;

namespace ManagCond.Guardia
{
    public partial class EditarEncomienda : System.Web.UI.Page
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
                Encomienda encomienda = EncomiendaDao.BuscarEncomienda(int.Parse(id), idCond);
                int index = 0;
                foreach (ListItem item in DropDownList.Items)
                {
                    if (item.Value == encomienda.IdNumDpto.ToString()) break;
                    index++;
                }

                DropDownList.SelectedIndex = index;
                TextBoxDestinatario.Text = encomienda.Destinatario;
                TextBoxDescripcion.Text = encomienda.Descripcion;
                //FileUploadEncomienda.Value = encomienda.Imagen;
                DropDownListEstado.SelectedValue = encomienda.Estado;
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
            string idE = Request.QueryString["id"];
            int idCond = int.Parse(Session["idCond"].ToString());
            String numDpto = DropDownList.SelectedValue;
            String destinatario = TextBoxDestinatario.Text;
            String descripcion = TextBoxDescripcion.Text;
            String fileName = DateTime.Now.Year + "/" + DateTime.Now.Month + "/" + numDpto + "/" + FileUploadEncomienda.Value;
            String fileNameBD = FileUploadEncomienda.Value;
            Stream filestream = FileUploadEncomienda.PostedFile.InputStream;
            String estado = DropDownListEstado.Text.ToLower();
            estado = estado.Equals("pendiente") ? "1" : "2";

            if (EncomiendaDao.ModificarEncomienda(idE, idCond, numDpto, destinatario, descripcion, fileNameBD, estado))
            {
                _ = UploadBlop(fileName, filestream);
                Response.Redirect("Encomiendas.aspx");
            }
            else
            {
            }
        }
        public Boolean UploadBlop(String filename, Stream filestream)
        {
            try
            {
                string storageAccount_connectionString = ConfigurationManager.AppSettings["connectionStringSA"].ToString();
                string containerName = ConfigurationManager.AppSettings["containerSA"].ToString();

                CloudStorageAccount mycloudStorageAccount = CloudStorageAccount.Parse(storageAccount_connectionString);
                CloudBlobClient blobClient = mycloudStorageAccount.CreateCloudBlobClient();
                CloudBlobContainer container = blobClient.GetContainerReference(containerName);

                string file_extension = Path.GetExtension(filename);
                string filename_withExtension = filename;

                CloudBlockBlob cloudBlockBlob = container.GetBlockBlobReference(filename_withExtension);
                cloudBlockBlob.Properties.ContentType = file_extension;
                cloudBlockBlob.UploadFromStream(filestream);
                filestream.Dispose();
            }
            catch (Exception)
            {
                return false;
            }
            return true;
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
            SqlCommand cmd = new SqlCommand("SELECT * from estadoEncomienda", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListEstado.DataSource = ds;
            DropDownListEstado.DataTextField = "descripcion";
            DropDownListEstado.DataValueField = "descripcion";
            DropDownListEstado.DataBind();

        }
    }
}