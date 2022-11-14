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
    public class IngresosDao
    {
        private static readonly List<Ingreso> alIngresos = new List<Ingreso>();
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        public static List<Ingreso> GetAlIngresos(int idCond)
        {
            ObtenerDatosIngresos(idCond);
            return alIngresos;
        }
        public static void ObtenerDatosIngresos(int idCond)
        {
            alIngresos.Clear();
            string strSql = String.Format("SELECT * FROM ingresos where idCond= {0} ORDER BY fecha DESC", idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string nombre = sdr["nombre"].ToString();
                    string comentario = sdr["comentario"].ToString();
                    int monto = int.Parse(sdr["monto"].ToString());
                    int mes = int.Parse(sdr["mes"].ToString());
                    int año = int.Parse(sdr["año"].ToString());
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    string documento = sdr["documento"].ToString();

                    Ingreso ingreso = new Ingreso(id, nombre, comentario, monto, mes, año,fecha, documento, idCond);

                    alIngresos.Add(ingreso);
                }
                con.Close();
            }
        }
        public static int ObtenerTotalIngresos(int idCondominio)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT count(*) FROM ingresos WHERE idCond ='" + idCondominio + "' ";
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
                    totalRespuestas = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return totalRespuestas;
        }
        public static bool AgregarIngreso(string nombre, string comentario, int monto, int mes, int año, string fecha, string documento, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (nombre != null && comentario != null && monto != 0 && mes != 0 && año != 0 && documento != null && idCond != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_ingreso @nombre = '"+ nombre + "', @comentario = '"+ comentario + "', @monto = "+ monto + ", @mes = '"+ mes + "', @año = '"+ año + "', @fecha = '"+ fecha + "', @documento = '"+ documento + "', @idCond = "+ idCond + "";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    estado = true;

                    ObtenerTotalIngresos(idCond);

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }
        public static bool ModificarIngreso(int id, string nombre, string comentario, int monto, int mes, int año, string fecha, string documento, int idCond)
        {
            bool estado = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_modificar_ingreso @id = "+ id + ", @nombre = '"+ nombre + "', @comentario = '"+ comentario + "', @monto = "+ monto + ", @mes = '"+ mes + "', @año = '"+ año + "', @fecha = '"+ fecha + "', @documento = '"+ documento + "', @idCond = "+ idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);


                estado = true;

                ObtenerTotalIngresos(idCond);
            }
            catch (Exception)
            {

            }
            return estado;
        }
        public static Ingreso BuscarIngreso(int id, int idCond)
        {

            Ingreso ingreso = null;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "SELECT * FROM ingresos where id = "+ id +" and idCond= "+ idCond +"";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                string nombre = dt.Rows[0][1].ToString();
                string comentario = dt.Rows[0][2].ToString();
                int monto = int.Parse(dt.Rows[0][3].ToString());
                int mes = int.Parse(dt.Rows[0][4].ToString());
                int año = int.Parse(dt.Rows[0][5].ToString());
                DateTime fecha = DateTime.Parse(dt.Rows[0][6].ToString());
                string documento = dt.Rows[0][7].ToString();

                ingreso = new Ingreso(id, nombre, comentario, monto, mes, año, fecha, documento, idCond);

            }
            catch (Exception)
            {

            }

            return ingreso;
        }
        public static bool EliminarIngreso(int id)
        {
            bool estado = true;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();


                string sSel = "delete from ingresos where id = " + id + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);
            }
            catch (Exception)
            {
                estado = false;
            }

            return estado;
        }
    }
}
