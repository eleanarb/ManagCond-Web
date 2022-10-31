using Dao;
using Model;
using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Configuration;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

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
        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            int idCond = int.Parse(Session["idCond"].ToString());
            string numDpto = DropDownList.SelectedValue;
            string destinatario = TextBoxDestinatario.Text;
            string descripcion = TextBoxDescripcion.Text;

            string fileNameBD = FileUploadEncomienda.Value;
            if (EncomiendaDao.BuscarFotoEncomienda(fileNameBD, idCond))
            {
                int counter = 1;
                string tempfileName = "(" + counter.ToString() + ") " + fileNameBD;
                while (EncomiendaDao.BuscarFotoEncomienda(tempfileName, idCond))
                {

                    tempfileName = "(" + counter.ToString() + ") " + fileNameBD;
                    counter++;
                }

                fileNameBD = tempfileName;
            }
            string fileName = DateTime.Now.Year + "/" + DateTime.Now.Month + "/" + numDpto + "/" + fileNameBD;
            Stream filestream = FileUploadEncomienda.PostedFile.InputStream;

            if (EncomiendaDao.AgregarEncomienda(numDpto, destinatario, descripcion, fileNameBD, idCond))
            {
                _ = UploadBlop(fileName, filestream);
                Response.Redirect("Encomiendas.aspx");
            }
            else
            {
                Response.Redirect("Encomienda.aspx");
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
            DropDownList.Items.Insert(0, new ListItem("Seleccione departamento", "0"));

        }
    }
}