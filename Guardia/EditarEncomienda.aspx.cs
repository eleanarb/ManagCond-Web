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
using System.Security.Cryptography;
using System.Text;

namespace ManagCond.Guardia
{
    public partial class EditarEncomienda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownList();
                LlenarDropDownListEstado();

                string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
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
            }
        }
        protected string Decrypt(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
        protected void ButtonAceptar_Click(object sender, EventArgs e)
        {
            string idE = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
            int idCond = int.Parse(Session["idCond"].ToString());
            String numDpto = DropDownList.SelectedValue;
            String destinatario = TextBoxDestinatario.Text;
            String descripcion = TextBoxDescripcion.Text;

            string fileNameBD = "";
            string fileName = "";
            Stream filestream = FileUploadEncomienda.PostedFile.InputStream;
            if (FileUploadEncomienda.Value != "")
            {
                fileName = DateTime.Now.Year + "/" + DateTime.Now.Month + "/" + numDpto + "/" + FileUploadEncomienda.Value;
                fileNameBD = FileUploadEncomienda.Value;
                filestream = FileUploadEncomienda.PostedFile.InputStream;

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
                    fileName = DateTime.Now.Year + "/" + DateTime.Now.Month + "/" + numDpto + "/" + fileNameBD;
                }
            }
            if (FileUploadEncomienda.Value == "")
            {
                string idF = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
                int idCondF = int.Parse(Session["idCond"].ToString());
                Encomienda encomienda = EncomiendaDao.BuscarEncomienda(int.Parse(idF), idCondF);
                fileNameBD = encomienda.Imagen;
            }


            String estado = DropDownListEstado.Text.ToLower();
            estado = estado.Equals("pendiente") ? "1" : "2";

            if (EncomiendaDao.ModificarEncomienda(idE, idCond, numDpto, destinatario, descripcion, fileNameBD, estado))
            {
                if (FileUploadEncomienda.Value != "")
                {
                    _ = UploadBlop(fileName, filestream);
                }
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