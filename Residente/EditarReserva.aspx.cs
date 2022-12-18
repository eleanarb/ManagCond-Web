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
using System.Security.Cryptography;
using System.IO;
using System.Text;

namespace ManagCond.Residente
{
    public partial class EditarReserva : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarDropDownListDpto();
                LlenarDropDownListDpto();
                LlenarDropDownListEspaciComun();
                string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
                int idCond = int.Parse(Session["idCond"].ToString());
                Reserva reserva = ReservaDao.BuscarReserva(int.Parse(id), idCond);

                DropDownListDpto.SelectedIndex = int.Parse(Session["numDpto"].ToString());
                inputFecha.Value = reserva.Fecha.ToString();
                TextBoxSolicitante.Text = reserva.Solicitante;
                DropDownListEspaciComun.Text = reserva.EspacioComun.ToString();
            }
            if (Session["usuario"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                if (!Session["tipoUsuario"].Equals(3))
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
        protected void ButtonEditar_Click(object sender, EventArgs e)
        {
            string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
            int numDpto = int.Parse(DropDownListDpto.SelectedValue);
            DateTime fecha = DateTime.Parse(inputFecha.Value);
            string fecha2 = fecha.ToString("yyyy-MM-dd");
            string rangoFecha = DropDownRangoHorario.SelectedItem.Text;
            string espacioComun = DropDownListEspaciComun.Text;
            string solicitante = TextBoxSolicitante.Text;
            int idCond = int.Parse(Session["idCond"].ToString());


            if (ReservaDao.ModificarReservaR(int.Parse(id), numDpto, fecha2, rangoFecha, espacioComun, solicitante, idCond))
            {
                Response.Redirect("Reservas.aspx");
            }
            else
            {
                Response.Redirect("Reserva.aspx");
            }
        }
        protected void EspacioSeleccionado(object sender, EventArgs e)
        {
            int idEspacio = Convert.ToInt32(DropDownListEspaciComun.SelectedValue);

            LlenarDropDownRangoHorario(idEspacio);

        }
        public void LlenarDropDownListDpto()
        {
            int idCond = int.Parse(Session["idCond"].ToString());
            int numDpto = int.Parse(Session["numDpto"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , numDpto from departamento where id = " + numDpto + " and id_Cond = " + idCond + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListDpto.DataSource = ds;
            DropDownListDpto.DataTextField = "numDpto";
            DropDownListDpto.DataValueField = "id";
            DropDownListDpto.DataBind();
        }
        public void LlenarDropDownListEspaciComun()
        {
            int idCond = int.Parse(Session["idCond"].ToString());

            SqlCommand cmd = new SqlCommand("Select id , nombre from espaciosComunes where id_Cond = " + idCond + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownListEspaciComun.DataSource = ds;
            DropDownListEspaciComun.DataTextField = "nombre";
            DropDownListEspaciComun.DataValueField = "id";
            DropDownListEspaciComun.DataBind();
            DropDownListEspaciComun.Items.Insert(0, new ListItem("Seleccione Espacio Comun", "0"));
        }
        public void LlenarDropDownRangoHorario(int idEspacio)
        {
            SqlCommand cmd = new SqlCommand("Select id , rango  from rangoEspacioComun where idEspacioComun = " + idEspacio + "", Conexion.Open());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            DropDownRangoHorario.DataSource = ds;
            DropDownRangoHorario.DataTextField = "rango";
            DropDownRangoHorario.DataValueField = "id";
            DropDownRangoHorario.DataBind();
        }
    }
}