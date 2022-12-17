using Dao;
using Model;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
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
    public partial class Egresos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime fechaActual = System.DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            if (!IsPostBack)
            {
                LlenarDropDownProveedor();
                LlenarDropDownCategoria();
                DropDownListMes.SelectedValue = mesActual.ToString();
                DropDownListAño.SelectedValue = añoActual.ToString();
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

        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxId.Value);
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
            }else if (estadoT.Equals("Pendiente"))
            {
                estado = 1;
            }

            int idF = int.Parse(TextBoxId.Value);
            int idCondF = int.Parse(Session["idCondominio"].ToString());
            string año = fecha.ToString("yyyy");
            string mes = fecha.ToString("MM");

            string fileNameBDCobro = "";
            string fileNameCobro = "";
            Stream filestreamCobro = FileUploadCobro.PostedFile.InputStream;

            string fileNameBDComprobante = "";
            string fileNameComprobante = "";
            Stream filestreamComprobante = FileUploadComprobante.PostedFile.InputStream;

            if (FileUploadCobro.Value != "" && FileUploadComprobante.Value != "")
            {
                fileNameBDCobro = FileUploadCobro.Value;
                fileNameCobro = año + "/" + mes + "/" + fileNameBDCobro;
                filestreamCobro = FileUploadCobro.PostedFile.InputStream;

                fileNameBDComprobante = FileUploadComprobante.Value;
                fileNameComprobante = año + "/" + mes + "/" + fileNameBDComprobante;
                filestreamComprobante = FileUploadComprobante.PostedFile.InputStream;


                if (EgresosDao.BuscarDocumentoCobro(fileNameBDCobro, idCondF))
                {
                    int counter = 1;
                    string tempfileName = "(" + counter.ToString() + ") " + fileNameBDCobro;
                    while (EgresosDao.BuscarDocumentoCobro(tempfileName, idCondF))
                    {

                        tempfileName = "(" + counter.ToString() + ") " + fileNameBDCobro;
                        counter++;
                    }

                    fileNameBDCobro = tempfileName;
                    fileNameCobro = año + "/" + mes + "/" + fileNameBDCobro;
                }

                if (EgresosDao.BuscarComprobante(fileNameBDComprobante, idCondF))
                {
                    int counter = 1;
                    string tempfileName = "(" + counter.ToString() + ") " + fileNameBDComprobante;
                    while (EgresosDao.BuscarComprobante(tempfileName, idCondF))
                    {

                        tempfileName = "(" + counter.ToString() + ") " + fileNameBDComprobante;
                        counter++;
                    }

                    fileNameBDComprobante = tempfileName;
                    fileNameComprobante = año + "/" + mes + "/" + fileNameBDComprobante;
                }
            }

            if (FileUploadCobro.Value != "" && FileUploadComprobante.Value == "")
            {
                fileNameBDCobro = FileUploadCobro.Value;
                fileNameCobro = año + "/" + mes + "/" + fileNameBDCobro;
                filestreamCobro = FileUploadCobro.PostedFile.InputStream;

                Model.Egresos egreso = EgresosDao.BuscarEgreso(idF, idCondF);
                fileNameBDComprobante = egreso.Comprobante;

                if (EgresosDao.BuscarDocumentoCobro(fileNameBDCobro, idCondF))
                {
                    int counter = 1;
                    string tempfileName = "(" + counter.ToString() + ") " + fileNameBDCobro;
                    while (EgresosDao.BuscarDocumentoCobro(tempfileName, idCondF))
                    {

                        tempfileName = "(" + counter.ToString() + ") " + fileNameBDCobro;
                        counter++;
                    }

                    fileNameBDCobro = tempfileName;
                    fileNameCobro = año + "/" + mes + "/" + fileNameBDCobro;
                }
            }

            if (FileUploadCobro.Value == "" && FileUploadComprobante.Value != "")
            {
                Model.Egresos egreso = EgresosDao.BuscarEgreso(idF, idCondF);
                fileNameBDCobro = egreso.DocumentoCobro;

                fileNameBDComprobante = FileUploadComprobante.Value;
                fileNameComprobante = año + "/" + mes + "/" + fileNameBDComprobante;
                filestreamComprobante = FileUploadComprobante.PostedFile.InputStream;

                if (EgresosDao.BuscarComprobante(fileNameBDComprobante, idCondF))
                {
                    int counter = 1;
                    string tempfileName = "(" + counter.ToString() + ") " + fileNameBDComprobante;
                    while (EgresosDao.BuscarComprobante(tempfileName, idCondF))
                    {

                        tempfileName = "(" + counter.ToString() + ") " + fileNameBDComprobante;
                        counter++;
                    }

                    fileNameBDComprobante = tempfileName;
                    fileNameComprobante = año + "/" + mes + "/" + fileNameBDComprobante;
                }
            }

            if (FileUploadCobro.Value == "" && FileUploadComprobante.Value == "")
            {
                Model.Egresos egreso = EgresosDao.BuscarEgreso(idF, idCondF);

                fileNameBDCobro = egreso.DocumentoCobro;

                fileNameBDComprobante = egreso.Comprobante;
            }

            if (EgresosDao.ModificarEgreso(id, proveedor, descripcion, categoria, fecha2, monto, estado, fileNameBDCobro, fileNameBDComprobante))
            {
                if (FileUploadCobro.Value != "" && FileUploadComprobante.Value != "")
                {
                    _ = UploadBlop(fileNameCobro, filestreamCobro);
                    _ = UploadBlop2(fileNameComprobante, filestreamComprobante);
                }

                if (FileUploadCobro.Value != "" && FileUploadComprobante.Value == "")
                {
                    _ = UploadBlop(fileNameCobro, filestreamCobro);
                }
                if (FileUploadCobro.Value == "" && FileUploadComprobante.Value != "")
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
        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            int id = int.Parse(TextBoxIdEliminar.Value);
            if (EgresosDao.EliminarEgreso(id))
            {
                Response.Redirect("Egresos.aspx");
            }
            else
            {
            }
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
        protected void Mes_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMes.SelectedValue);
            Session["año"] = int.Parse(DropDownListAño.SelectedValue);
        }
        protected void Año_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["mes"] = int.Parse(DropDownListMes.SelectedValue);
            Session["año"] = int.Parse(DropDownListAño.SelectedValue);
        }
    }
}