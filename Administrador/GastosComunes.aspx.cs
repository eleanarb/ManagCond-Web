using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dao;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Model;

namespace ManagCond.Administrador
{
    public partial class GastosComunes : System.Web.UI.Page
    {
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();

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
        protected void ButtonAgregar_Click(object sender, EventArgs e)
        {
            int mes = int.Parse(DateTime.Now.ToString("MM"));
            int año = int.Parse(DateTime.Now.ToString("yyyy"));
            int idCond = int.Parse(Session["idCondominio"].ToString());

            if (GastosComunesDao.GenerarGastoComun(mes, año, idCond))
            {
                Response.Redirect("GastosComunes.aspx");
            }
            else
            {
                Response.Redirect("GastosComune.aspx");
            }
        }

        protected void ButtonGenerarPdf_Click(object sender, EventArgs e)
        {
            Usuario usuario = (Usuario)Session["usuario"];
            string EmailDestino = usuario.Correo;
            Notificacion(EmailDestino);

            Document document = new Document();
            _ = PdfWriter.GetInstance(document, HttpContext.Current.Response.OutputStream);
            DataTable dt = DtAlumno();
            if (dt.Rows.Count > 0)
            {
                document.Open();
                Font fontTitle = FontFactory.GetFont(FontFactory.COURIER_BOLD, 25);
                Font font9 = FontFactory.GetFont(FontFactory.TIMES, 9);

                PdfPTable table = new PdfPTable(dt.Columns.Count);
                document.Add(new Paragraph(20, "Gastos Comunes", fontTitle));
                document.Add(new Chunk("\n"));

                float[] widths = new float[dt.Columns.Count];
                for (int i = 0; i < dt.Columns.Count; i++)
                    widths[i] = 4f;

                table.SetWidths(widths);
                table.WidthPercentage = 110;
                _ = new PdfPCell(new Phrase("columns"))
                {
                    Colspan = dt.Columns.Count
                };

                foreach (DataColumn c in dt.Columns)
                {
                    table.AddCell(new Phrase(c.ColumnName, font9));
                }

                foreach (DataRow r in dt.Rows)
                {
                    if (dt.Rows.Count > 0)
                    {
                        for (int h = 0; h < dt.Columns.Count; h++)
                        {
                            table.AddCell(new Phrase(r[h].ToString(), font9));
                        }
                    }
                }
                document.Add(table);
            }
            else 
            {
                document.Open();
                Font fontTitle = FontFactory.GetFont(FontFactory.COURIER_BOLD, 25);
                Font font9 = FontFactory.GetFont(FontFactory.TIMES, 12);

                document.Add(new Paragraph(50, "Gastos Comunes", fontTitle));
                document.Add(new Paragraph(25, "No hay gastos comunes en este mes", font9));
                document.Add(new Chunk("\n"));
            }
            document.Close();

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=GastosComunes" + ".pdf");
            HttpContext.Current.Response.Write(document);
            Response.Flush();
            Response.End();
        }

        public DataTable DtAlumno()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand
                {
                    CommandType = CommandType.StoredProcedure,
                    CommandText = "sp_gastosComunes",
                    Connection = conn
                };
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                da.Dispose();
            }
            return dt;
        }
        protected void Notificacion(string EmailDestino)
        {
            string EmailOrigen = "managcond@outlook.com";
            string Contraseña = "Trompeta45@";
            string body = @"<h2>Se restableció la contraseña de su cuenta registrada en ManagCond </h2>

                            <p>Estimado/a, Fulano:</p>

                            <p> El 27 de noviembre se restableció la contraseña de su cuenta registrada en ManagCond </p>
                            <p> Si no realizaste esta modificación o si cree que alguien ha accedido a su cuenta sin autorización, visita wwww.hola.com para restablecer su contraseña inmediatamente </p>

                            <p> Si necesita ayuda adicional, comunícate con Soporte técnico de ManagCond.</p>

                            <p>Atentamente,</p>
                            <p>Soporte técnico de ManagCond</p>

                            <br>

                            <div style='text - align: center;'>
                            <img style = 'width: 100px' src = '..\assets\img\logo.png' />
                            </div> ";

            SmtpClient oSmtpCliente = new SmtpClient("smtp.office365.com")
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Port = 587,
                Credentials = new NetworkCredential(EmailOrigen, Contraseña)
            };

            MailMessage oMailMessage = new MailMessage(EmailOrigen, EmailDestino, "Gastos Comunes", body)
            {
                IsBodyHtml = true
            };

            oSmtpCliente.Send(oMailMessage);

            oSmtpCliente.Dispose();
        }
    }
}