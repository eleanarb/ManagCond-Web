using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace ManagCond
{
    public partial class dashboard : System.Web.UI.Page
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

        protected string obtenerGastos()
        {
            DateTime fechaActual = DateTime.Now;
            int mesActual = int.Parse(fechaActual.ToString("MM"));
            int añoActual = fechaActual.Year;
            int idCond = int.Parse(Session["idCondominio"].ToString());

            SqlConnection conexionSQL = new SqlConnection("Server=tcp:servermagcond.database.windows.net,1433;Initial Catalog=ManagCond;Persist Security Info=False;User ID=Pegazus;Password=Bala7821@#;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "EXEC sp_obtener_total_gastos @idCond = " + idCond + ", @mes = " + mesActual + ", @año = " + añoActual + " ";
            cmd.CommandType = CommandType.Text;
            cmd.Connection = conexionSQL;
            conexionSQL.Open();

            DataTable Datos = new DataTable();
            Datos.Load(cmd.ExecuteReader());
            conexionSQL.Close();

            ////Columnas
            //Datos.Columns.Add(new DataColumn("Categoría", typeof(string)));
            //Datos.Columns.Add(new DataColumn("Monto", typeof(string)));

            ////Datos de las columnas
            //Datos.Rows.Add(new Object[] { "hola", 11 });
            //Datos.Rows.Add(new Object[] { "chao", 5 });
            //Datos.Rows.Add(new Object[] { "gudbay", 50 });

            string strDatos;

            strDatos = "[['Categoría', 'Monto'],";

            foreach (DataRow dr in Datos.Rows)
            {
                strDatos = strDatos + "[";
                strDatos = strDatos + "'" + dr[0] + "'" + "," + dr[1];
                strDatos = strDatos + "],";
            }
            strDatos = strDatos + "]";

            return strDatos;
        }

        protected string obtenerBalance()
        {

            int idCond = int.Parse(Session["idCondominio"].ToString());

            SqlConnection conexionSQL = new SqlConnection("Server=tcp:servermagcond.database.windows.net,1433;Initial Catalog=ManagCond;Persist Security Info=False;User ID=Pegazus;Password=Bala7821@#;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "EXEC sp_obtener_todos_balance @idCond = " + idCond + " ";
            cmd.CommandType = CommandType.Text;
            cmd.Connection = conexionSQL;
            conexionSQL.Open();

            DataTable Datos = new DataTable();
            Datos.Load(cmd.ExecuteReader());
            conexionSQL.Close();

            string strDatos;

            strDatos = "[['Mes', 'Ingresos', 'Egresos'],";

            foreach (DataRow dr in Datos.Rows)
            {
                strDatos = strDatos + "[";
                strDatos = strDatos + dr[0] + "," + dr[1] + "," + dr[2];
                strDatos = strDatos + "],";
            }
            strDatos = strDatos + "]";

            return strDatos;
        }
    }
}