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

            string sSel = "select * from condominio where id = '" + idCondominio + "' ";
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
                    String nombre = dt.Rows[fila][1].ToString();
                    String direccion = dt.Rows[fila][2].ToString();
                    int cant_edf = int.Parse(dt.Rows[fila][3].ToString());

                    condominio = new Condominio(idCond, nombre, direccion, cant_edf);

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
