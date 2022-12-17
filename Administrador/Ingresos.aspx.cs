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
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                DropDownListMesF.SelectedValue = mesActual.ToString();
                DropDownListAñoF.SelectedValue = añoActual.ToString();
                Session["mes"] = int.Parse(mesActual.ToString());
                Session["año"] = int.Parse(añoActual.ToString());
            }
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

                if (IngresosDao.BuscarDocumento(fileNameBD, idCond))
                {
                    int counter = 1;
                    string tempfileName = "(" + counter.ToString() + ") " + fileNameBD;
                    while (IngresosDao.BuscarDocumento(tempfileName, idCond))
                    {

                        tempfileName = "(" + counter.ToString() + ") " + fileNameBD;
                        counter++;
                    }

                    fileNameBD = tempfileName;
                    fileName = año + "/" + mes + "/" + fileNameBD;
                }

            }
            if (FileUploadDocumento.Value == "")
            {
                Ingreso ingreso = IngresosDao.BuscarIngreso(id, idCond);
                fileNameBD = ingreso.Documento;
            }

            if (IngresosDao.ModificarIngreso(id, nombre, comentario, monto, mes, año, fecha2, fileNameBD, idCond))
            {
                if (FileUploadDocumento.Value != "")
                {
                    _ = UploadBlop(fileName, filestream);
                }
                Response.Redirect("Ingresos.aspx");
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
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMesF.SelectedValue);
            Session["año"] = int.Parse(DropDownListAñoF.SelectedValue);
        }
    }
}