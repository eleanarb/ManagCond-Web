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
    public class DepartamentoDao
    {

        private static readonly List<Departamento> alDepartamentos = new List<Departamento>();

        public static Departamento ObtenerDatosDepartamento(int idDpto)
        {
            alDepartamentos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            Departamento departamento = null;

            string sSel = "select * from departamento where id = '" + idDpto + "' ";
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

                    string numDpto = dt.Rows[fila][1].ToString();
                    int numEstac = int.Parse(dt.Rows[fila][2].ToString());
                    int numBod = int.Parse(dt.Rows[fila][3].ToString());
                    int id_cond = int.Parse(dt.Rows[fila][4].ToString());
                    decimal prorrateo = decimal.Parse(dt.Rows[fila][5].ToString());

                    departamento = new Departamento(idDpto, numDpto, numEstac, numBod, id_cond, prorrateo);

                    alDepartamentos.Add(departamento);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return departamento;
        }
    }
}
