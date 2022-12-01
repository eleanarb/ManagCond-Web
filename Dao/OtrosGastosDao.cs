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
    public class OtrosGastosDao
    {
        private static readonly List<OtrosGastos> alOtrosGastos = new List<OtrosGastos>();
        private static readonly List<TipoGastos> alTipoGastos = new List<TipoGastos>();

        public static List<OtrosGastos> GetAlOtrosGastosCondominio(int mes, int año, int idCond)
        {
            ObtenerOtrosGastosCondominio(mes, año, idCond);
            return alOtrosGastos;
        }

        public static List<TipoGastos> GetAlTipoGastos(int idCondominio)
        {
            ObtenerTipoGastos(idCondominio);
            return alTipoGastos;
        }

        public static void ObtenerOtrosGastosCondominio(int mes, int año, int idCond)
        {
            alOtrosGastos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT og.id, og.mes, og.año, og.idGasto, og.cantidad, og.total, og.idDpto, og.descripcion, d.numDpto, tp.monto, tp.nombre FROM otrosGastos og INNER JOIN departamento d ON og.idDpto = d.id INNER JOIN condominio c ON d.id_cond = c.id INNER JOIN tipoGastos tp ON og.idGasto = tp.id WHERE mes = "+ mes +" AND año = "+ año +" AND c.id = "+ idCond + "";
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
                    int id = int.Parse(dt.Rows[fila][0].ToString());
                    int mesO = int.Parse(dt.Rows[fila][1].ToString());
                    int añoO = int.Parse(dt.Rows[fila][2].ToString());
                    int idGasto = int.Parse(dt.Rows[fila][3].ToString());
                    int cantidad = int.Parse(dt.Rows[fila][4].ToString());
                    int total = int.Parse(dt.Rows[fila][5].ToString());
                    int idDepto = int.Parse(dt.Rows[fila][6].ToString());
                    String descripcion = dt.Rows[fila][7].ToString();
                    String depto = dt.Rows[fila][8].ToString();
                    int monto = int.Parse(dt.Rows[fila][9].ToString());
                    String gasto = dt.Rows[fila][10].ToString();

                    OtrosGastos otrosGastos = new OtrosGastos(id, idDepto, depto, mesO, añoO, idGasto, gasto, monto, cantidad, total, descripcion);

                    alOtrosGastos.Add(otrosGastos);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static void ObtenerTipoGastos(int idCondominio)
        {
            alTipoGastos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT *  FROM tipoGastos WHERE idCond = '" + idCondominio + "' ";
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
                    int id = int.Parse(dt.Rows[fila][0].ToString());
                    String nombre = dt.Rows[fila][1].ToString();
                    String descripcion = dt.Rows[fila][2].ToString();
                    int monto = int.Parse(dt.Rows[fila][3].ToString());
                    int multa = int.Parse(dt.Rows[fila][4].ToString());
                    int idCond = int.Parse(dt.Rows[fila][5].ToString());

                    TipoGastos tipoGastos = new TipoGastos(id, nombre, descripcion, monto, multa, idCond);

                    alTipoGastos.Add(tipoGastos);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static OtrosGastos ObtenerDatosOtrosGastos(int id)
        {
            alOtrosGastos.Clear();
            OtrosGastos otroGasto = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT og.id, og.mes, og.año, og.idGasto, og.cantidad, og.total, og.idDpto, og.descripcion, d.numDpto, tp.monto, tp.nombre FROM otrosGastos og INNER JOIN departamento d ON og.idDpto = d.id INNER JOIN condominio c ON d.id_cond = c.id INNER JOIN tipoGastos tp ON og.idGasto = tp.id WHERE og.id = '" + id + "'";
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
                    int mes = int.Parse(dt.Rows[fila][1].ToString());
                    int año = int.Parse(dt.Rows[fila][2].ToString());
                    int idGasto = int.Parse(dt.Rows[fila][3].ToString());
                    int cantidad = int.Parse(dt.Rows[fila][4].ToString());
                    int total = int.Parse(dt.Rows[fila][5].ToString());
                    int idDepto = int.Parse(dt.Rows[fila][6].ToString());
                    String descripcion = dt.Rows[fila][7].ToString();
                    String depto = dt.Rows[fila][8].ToString();
                    int monto = int.Parse(dt.Rows[fila][9].ToString());
                    String gasto = dt.Rows[fila][10].ToString();

                    otroGasto = new OtrosGastos(id, idDepto, depto, mes, año, idGasto, gasto, monto, cantidad, total, descripcion);


                }
            }
            catch (Exception)
            {

            }
            return otroGasto;
        }

        public static int ObtenerTotalOtrosGastosCondominio(int mes, int año, int idCond)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT count(*) FROM otrosGastos og INNER JOIN departamento d ON og.idDpto = d.id INNER JOIN condominio c ON d.id_cond = c.id INNER JOIN tipoGastos tp ON og.idGasto = tp.id WHERE mes = " + mes + " AND año = " + año + " AND c.id = " + idCond + "";
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
        public static int ObtenerTotalTipoGastos(int idCondominio)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "select count(*) from tipoGastos where idCond ='" + idCondominio + "' ";
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

        public static bool AgregarOtroGasto(int mes, int año, int idGasto, int cantidad, int idDpto, string descripcion)
        {
            bool estado = false;

            string sCnn;

            if (mes != 0 && año != 0 && idGasto != 0 && cantidad != 0  && idDpto != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_agregar_otroGasto @mes = '" + mes + "', @año = '" + año + "', @cantidad = '" + cantidad + "', @idGasto = '" + idGasto + "', @idDpto =  '" + idDpto + "',  @desc =  '" + descripcion + "' ";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }
        public static bool ModificarOtroGasto(int id, int mes, int año, int idGasto, int cantidad, int idDpto, string descripcion)
        {
            bool estado = false;

            string sCnn;

            if (mes != 0 && año != 0 && idGasto != 0 && cantidad != 0 && idDpto != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_modificar_otroGasto @id =  " + id + ", @mes = " + mes + ", @año = '" + año + "', @cantidad = '" + cantidad + "', @idGasto = '" + idGasto + "', @idDpto =  '" + idDpto + "',  @desc =  '" + descripcion + "' ";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }


        public static bool AgregarTipoCargo(string nombre, string descripcion, int monto, int multa, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (nombre != null && descripcion != null && monto != 0 && multa != 0 && idCond != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_agregar_tipoGasto @nombre = '" + nombre + "', @descripcion = '" + descripcion + "', @monto = '" + monto + "', @multa = '" + multa + "', @idCond =  '" + idCond + "' ";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }

        public static bool ModificarTipoCargo(int id, string nombre, string descripcion, int monto, int multa)
        {
            bool estado = false;

            string sCnn;

            if (nombre != null && descripcion != null && monto != 0 && multa != 0 && id != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_modificar_tipoGasto @id = '" + id + "', @nombre = '" + nombre + "', @descripcion = '" + descripcion + "', @monto = '" + monto + "', @multa = '" + multa + "'";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }

        public static bool EliminarOtroGasto(int id)
        {
            bool e = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_eliminar_otroGasto @id = " + id + " ";

                SqlDataAdapter da;
                DataTable dt = new DataTable();
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                e = true;
            }
            catch (Exception)
            {

            }
            return e;
        }
    }
}
