using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Dao;
using System.IO;
using System.Configuration;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace ManagCond.Administrador
{
    public partial class Ingresos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

        protected void ButtonEditar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxId.Value);
            int idCond = int.Parse(Session["idCondominio"].ToString());
            string nombre = TextBoxNombre.Text;
            string comentario = TextBoxComentario.Text;
            int monto = int.Parse(inputMonto.Value);
            int mes = int.Parse(DropDownListMes.Text);
            int año = int.Parse(DropDownListAño.Text);
            DateTime fecha = DateTime.Parse(inputFecha.Value);
            string fecha2 = fecha.ToString("yyyy-MM-dd");

            string fileNameBD = "";
            string fileName = "";
            Stream filestream = FileUploadDocumento.PostedFile.InputStream;
            if (FileUploadDocumento.Value != "")
            {
                 fileNameBD = FileUploadDocumento.Value;
                 fileName = año + "/" + mes + "/" + fileNameBD;
                 filestream = FileUploadDocumento.PostedFile.InputStream;
            }
            if (FileUploadDocumento.Value == "")
            {
                int idCondF = int.Parse(Session["idCondominio"].ToString());
                Ingreso ingreso = IngresosDao.BuscarIngreso(id, idCondF);
                fileNameBD = ingreso.Documento;
            }

            if (IngresosDao.ModificarIngreso(id, nombre, comentario, monto, mes, año, fecha2, fileNameBD, idCond))
            {
                if (FileUploadDocumento.Value != "")
                {
                    _ = UploadBlop(fileName, filestream);
                    Response.Redirect("Ingresos.aspx");
                }
                if (FileUploadDocumento.Value == "")
                {
                    Response.Redirect("Ingresos.aspx");
                }
            }
            else
            {
                Response.Redirect("Ingreso.aspx");
            }
        }
        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (IngresosDao.EliminarIngreso(id))
            {
                Response.Redirect("Ingresos.aspx");
            }
            else
            {
                Response.Redirect("Ingreso.aspx");
            }
        }
        public Boolean UploadBlop(String filename, Stream filestream)
        {
            try
            {
                string storageAccount_connectionString = ConfigurationManager.AppSettings["connectionStringSA"].ToString();
                string containerName = ConfigurationManager.AppSettings["containerArchivosSA"].ToString();

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
    }
}