using Dao;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagCond.Administrador
{
    public partial class AgregarEgreso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownProveedor();
                LlenarDropDownCategoria();
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

        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            Usuario usuario = new Usuario();
            usuario = (Usuario)Session["usuario"];
            int idCond = usuario.IdCond;

            int categoria = int.Parse(DropDownListCategoria.SelectedValue);
            int proveedor = int.Parse(DropDownListProveedor.SelectedValue);
            DateTime fecha = DateTime.Parse(TextBoxFechaModal.Value);
            string fecha2 = fecha.ToString("yyyy-MM-dd");
            string descripcion = (TextBoxDescModal.Value).TrimEnd(' ');
            int monto = int.Parse((TextBoxMontoModal.Value).TrimEnd(' '));
            string estadoT = DropDownListEstado.SelectedValue;
            int estado = 0;
            if (estadoT.Equals("Pagado"))
            {
                estado = 2;
            }
            else if (estadoT.Equals("Pendiente"))
            {
                estado = 1;
            }

            string año = fecha.ToString("yyyy");
            string mes = fecha.ToString("MM");

            string fileNameBDCobro = "";
            string fileNameCobro = "";
            Stream filestreamCobro = FileUploadCobro.PostedFile.InputStream;
            if (FileUploadCobro.Value != "")
            {
                fileNameBDCobro = FileUploadCobro.Value;
                fileNameCobro = año + "/" + mes + "/" + fileNameBDCobro;
                filestreamCobro = FileUploadCobro.PostedFile.InputStream;
            }

            string fileNameBDComprobante = "";
            string fileNameComprobante = "";
            Stream filestreamComprobante = FileUploadComprobante.PostedFile.InputStream;
            if (FileUploadComprobante.Value != "")
            {
                fileNameBDComprobante = FileUploadComprobante.Value;
                fileNameComprobante = año + "/" + mes + "/" + fileNameBDComprobante;
                filestreamComprobante = FileUploadComprobante.PostedFile.InputStream;
            }

            if (EgresosDao.BuscarDocumentoCobro(fileNameBDCobro, idCond))
            {
                int counter = 1;
                string tempfileName = "(" + counter.ToString() + ") " + fileNameBDCobro;
                while (EgresosDao.BuscarDocumentoCobro(tempfileName, idCond))
                {

                    tempfileName = "(" + counter.ToString() + ") " + fileNameBDCobro;
                    counter++;
                }

                fileNameBDCobro = tempfileName;
                fileNameCobro = año + "/" + mes + "/" + fileNameBDCobro;
            }

            if (EgresosDao.BuscarComprobante(fileNameBDComprobante, idCond))
            {
                int counter = 1;
                string tempfileName = "(" + counter.ToString() + ") " + fileNameBDComprobante;
                while (EgresosDao.BuscarComprobante(tempfileName, idCond))
                {

                    tempfileName = "(" + counter.ToString() + ") " + fileNameBDComprobante;
                    counter++;
                }

                fileNameBDComprobante = tempfileName;
                fileNameComprobante = año + "/" + mes + "/" + fileNameBDComprobante;
            }

            if (EgresosDao.AgregarEgreso(proveedor, descripcion, categoria, fecha2, monto, estado, fileNameBDCobro, fileNameBDComprobante, idCond))
            {
                if (FileUploadCobro.Value != "")
                {
                    _ = UploadBlop(fileNameCobro, filestreamCobro);
                }
                if (FileUploadComprobante.Value != "")
                {
                    _ = UploadBlop2(fileNameComprobante, filestreamComprobante);
                }
                Response.Redirect("Egresos.aspx");
            }
            else
            {
                Response.Redirect("f.aspx");
            }
        }
        public Boolean UploadBlop2(String filename, Stream filestream)
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
        public void LlenarDropDownProveedor()
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("SELECT  id, nombre  FROM proveedores WHERE idCond = '" + idCondominio + "' ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListProveedor.DataSource = ds;
            DropDownListProveedor.DataTextField = "nombre";
            DropDownListProveedor.DataValueField = "id";
            DropDownListProveedor.DataBind();
            DropDownListProveedor.Items.Insert(0, new ListItem("Seleccione proveedor", "0"));

        }

        public void LlenarDropDownCategoria()
        {
            int idCondominio = 0;
            idCondominio = (int)Session["idCondominio"];

            SqlCommand cmd = new SqlCommand("SELECT  id, descripcion  FROM categoriaEgresos WHERE idCond = '" + idCondominio + "' ", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListCategoria.DataSource = ds;
            DropDownListCategoria.DataTextField = "descripcion";
            DropDownListCategoria.DataValueField = "id";
            DropDownListCategoria.DataBind();
            DropDownListCategoria.Items.Insert(0, new ListItem("Seleccione categoría", "0"));

        }
    }
}