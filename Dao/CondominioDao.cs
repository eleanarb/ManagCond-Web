using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace Dao
{
    public class CondominioDao
    {

        private static readonly List<Condominio> alCondominios = new List<Condominio>();

        public static Condominio ObtenerDatosCondominio(int idCondominio)
        {
            alCondominios.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            Condominio condominio = null;

            string sSel = "select c.id, c.nombre, c.cant_edf, d.nombre, co.nombre, r.nombre, c.porcentajeMora, c.porcentajeFondoReserva from condominio c INNER JOIN dbo.direccion d ON c.direccion = d.id INNER JOIN dbo.comuna co ON d.comuna = co.id INNER JOIN region r ON co.region = r.id WHERE c.id = '" + idCondominio + "' ";
            SqlDataAdapter da;
            DataTable dt = new DataTable();
            try
            {
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                int totalFilas = dt.Rows.Count;
                int fila = 0;

                for (; fila < totalFilas; fila++)
                {

                    int idCond = int.Parse(dt.Rows[fila][0].ToString());
                    string nombre = dt.Rows[fila][1].ToString();
                    int cant_edf = int.Parse(dt.Rows[fila][2].ToString());
                    string direccion = dt.Rows[fila][3].ToString();
                    string comuna = dt.Rows[fila][4].ToString();
                    string region = dt.Rows[fila][5].ToString();
                    decimal porcentajeMora = decimal.Parse(dt.Rows[fila][6].ToString());
                    decimal porcentajeFondoReserva = decimal.Parse(dt.Rows[fila][7].ToString());

                    condominio = new Condominio(idCond, nombre, direccion, comuna, region, cant_edf, porcentajeMora, porcentajeFondoReserva);

                    alCondominios.Add(condominio);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return condominio;
        }
    }
}