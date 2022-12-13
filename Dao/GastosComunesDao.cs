using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace Dao
{
    public class GastosComunesDao
    {
        private static readonly List<GastosComunes> alGastosComunes = new List<GastosComunes>();
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        //Administrador
        public static List<GastosComunes> GetAlGastosComunes(int idCondominio)
        {
            ObtenerDatosGastosComunes(idCondominio);
            return alGastosComunes;
        }
        public static List<GastosComunes> GetAlGastosComunesV(int idCondominio, int mes, int año, string depto)
        {
            ObtenerDatosGastosComunesV(idCondominio, mes, año, depto);
            return alGastosComunes;
        }
        public static int ObtenerTotalGastoComunes(int idCondominio, int mes, int año)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT count(*) FROM gastosComunes WHERE id_Cond = " + idCondominio + " AND mesCobro= " + mes + " AND añoCobro= " + año + " ";
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
        public static void ObtenerDatosGastosComunesV(int idCond, int mes, int año, string depto)
        {
            alGastosComunes.Clear();
            string strSql = String.Format("SELECT gc.id, gc.idDpto, D.numDpto, gc.mesCobro, gc.añoCobro, gc.fechaEmision, gc.fechaVencimiento, gc.gastoComun, gc.fondoReserva, gc.multas, gc.diasAtraso, gc.moraPeriodo, gc.varios, gc.id_Cond, gc.estado, gc.fechaPago, gc.totalPagar FROM gastosComunes gc INNER JOIN estadoGastosComunes egc ON gc.estado = egc.id INNER JOIN departamento d ON d.id = gc.idDpto WHERE gc.id_Cond = " + idCond + " AND gc.mesCobro= " + mes + " AND gc.añoCobro= " + año + " " + depto + "");

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    int idDpto = int.Parse(sdr["idDpto"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    int mesCobro = int.Parse(sdr["mesCobro"].ToString());
                    int añoCobro = int.Parse(sdr["añoCobro"].ToString());
                    DateTime fechaEmision = DateTime.Parse(sdr["fechaEmision"].ToString());
                    DateTime fechaVencimiento = DateTime.Parse(sdr["fechaVencimiento"].ToString());
                    int gastoComun = int.Parse(sdr["gastoComun"].ToString());
                    int fondoReserva = int.Parse(sdr["fondoReserva"].ToString());
                    int multas = int.Parse(sdr["multas"].ToString());
                    int diasAtraso = int.Parse(sdr["diasAtraso"].ToString());
                    int moraPeriodo = int.Parse(sdr["moraPeriodo"].ToString());
                    int varios = int.Parse(sdr["varios"].ToString());
                    int estado = int.Parse(sdr["estado"].ToString());
                    DateTime fechaPago = DateTime.Parse(sdr["fechaPago"].ToString());
                    int totalPagar = int.Parse(sdr["totalPagar"].ToString());

                    GastosComunes gastosComunes = new GastosComunes(id, idDpto, numDpto, mesCobro, añoCobro, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, multas, diasAtraso, moraPeriodo, varios, idCond, estado, fechaPago, totalPagar);

                    alGastosComunes.Add(gastosComunes);
                }
                con.Close();
            }
        }
        public static void ObtenerDatosGastosComunes(int idCond)
        {
            alGastosComunes.Clear();
            string strSql = String.Format("EXEC sp_obtener_gastosComunes @idCond = {0}", idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    int idDpto = int.Parse(sdr["idDpto"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    int mesCobro = int.Parse(sdr["mesCobro"].ToString());
                    int añoCobro = int.Parse(sdr["añoCobro"].ToString());
                    DateTime fechaEmision = DateTime.Parse(sdr["fechaEmision"].ToString());
                    DateTime fechaVencimiento = DateTime.Parse(sdr["fechaVencimiento"].ToString());
                    int gastoComun = int.Parse(sdr["gastoComun"].ToString());
                    int fondoReserva = int.Parse(sdr["fondoReserva"].ToString());
                    int multas = int.Parse(sdr["multas"].ToString());
                    int diasAtraso = int.Parse(sdr["diasAtraso"].ToString());
                    int moraPeriodo = int.Parse(sdr["moraPeriodo"].ToString());
                    int varios = int.Parse(sdr["varios"].ToString());
                    int estado = int.Parse(sdr["estado"].ToString());
                    DateTime fechaPago = DateTime.Parse(sdr["fechaPago"].ToString());
                    int totalPagar = int.Parse(sdr["totalPagar"].ToString());

                    GastosComunes gastosComunes = new GastosComunes(id, idDpto, numDpto, mesCobro, añoCobro, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, multas, diasAtraso, moraPeriodo, varios, idCond, estado, fechaPago, totalPagar);

                    alGastosComunes.Add(gastosComunes);
                }
                con.Close();
            }
        }
        public static bool GenerarGastoComun(int mes, int año, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (mes != 0 && año != 0 && idCond != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_generar_gastosComunes @mes = " + mes + ", @año = " + año + ",@idCond = " + idCond + "";

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

        //Residente


        public static GastosComunes ObtenerDatosUltimoGastoComun(int idCond, int idDpto)
        {
            GastosComunes gastosComunes = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "EXEC sp_obtener_ultimo_gastoComun @idCond = " + idCond + ", @idDpto = " + idDpto + " ";
            SqlDataAdapter da;
            DataTable dt = new DataTable();
            try
            {
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);


                int id = int.Parse(dt.Rows[0][0].ToString());

                string numDpto = dt.Rows[0][2].ToString();
                int mesCobro = int.Parse(dt.Rows[0][3].ToString());
                int añoCobro = int.Parse(dt.Rows[0][4].ToString());
                DateTime fechaEmision = Convert.ToDateTime(dt.Rows[0][5]);
                DateTime fechaVencimiento = Convert.ToDateTime(dt.Rows[0][6]);
                int gastoComun = int.Parse(dt.Rows[0][7].ToString());
                int fondoReserva = int.Parse(dt.Rows[0][8].ToString());
                int multas = int.Parse(dt.Rows[0][9].ToString());
                int diasAtraso = int.Parse(dt.Rows[0][10].ToString());
                int moraPeriodo = int.Parse(dt.Rows[0][11].ToString());
                int varios = int.Parse(dt.Rows[0][12].ToString());

                int estado = int.Parse(dt.Rows[0][14].ToString());
                DateTime fechaPago = Convert.ToDateTime(dt.Rows[0][15]);
                int totalPagar = int.Parse(dt.Rows[0][16].ToString());


                gastosComunes = new GastosComunes(id, idDpto, numDpto, mesCobro, añoCobro, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, multas, diasAtraso, moraPeriodo, varios, idCond, estado, fechaPago, totalPagar);


            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return gastosComunes;
        }

        public static bool PagoRealizado(int id)
        {

            bool estado = false;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int exit = 0;

            string sSel = "EXECUTE sp_pago_realizado @id= " + id + " ";
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
                    exit = int.Parse(dt.Rows[fila][0].ToString());
                    if (exit == 1)
                    {
                        estado = true;
                    }
                    else if (exit == 0)
                    {
                        estado = false;
                    }

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }

            return estado;
        }

        public static GastosComunes ObtenerDatosGastoComun(int idCond, int id)
        {
            GastosComunes gastosComunes = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "EXEC sp_obtener_gastoComun @idCond = " + idCond + ", @idGC = " + id + " ";
            SqlDataAdapter da;
            DataTable dt = new DataTable();
            try
            {
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);


                int idDpto = int.Parse(dt.Rows[0][1].ToString());

                string numDpto = dt.Rows[0][2].ToString();
                int mesCobro = int.Parse(dt.Rows[0][3].ToString());
                int añoCobro = int.Parse(dt.Rows[0][4].ToString());
                DateTime fechaEmision = Convert.ToDateTime(dt.Rows[0][5]);
                DateTime fechaVencimiento = Convert.ToDateTime(dt.Rows[0][6]);
                int gastoComun = int.Parse(dt.Rows[0][7].ToString());
                int fondoReserva = int.Parse(dt.Rows[0][8].ToString());
                int multas = int.Parse(dt.Rows[0][9].ToString());
                int diasAtraso = int.Parse(dt.Rows[0][10].ToString());
                int moraPeriodo = int.Parse(dt.Rows[0][11].ToString());
                int varios = int.Parse(dt.Rows[0][12].ToString());

                int estado = int.Parse(dt.Rows[0][14].ToString());
                DateTime fechaPago = Convert.ToDateTime(dt.Rows[0][15]);
                int totalPagar = int.Parse(dt.Rows[0][16].ToString());


                gastosComunes = new GastosComunes(id, idDpto, numDpto, mesCobro, añoCobro, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, multas, diasAtraso, moraPeriodo, varios, idCond, estado, fechaPago, totalPagar);


            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return gastosComunes;
        }

        public static int ObtenerTotalGastosComunesPendientes(int idDpto, int idCondominio)
        {
            ObtenerDatosGastosComunes(idCondominio);
            alGastosComunes.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalGastosComunes = 0;

            string sSel = "SELECT COUNT(*) FROM dbo.gastosComunes WHERE NOT estado = 2 AND idDpto = '" + idDpto + "' ";
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
                    totalGastosComunes = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return totalGastosComunes;
        }

        public static int ObtenerTotalGastosComunesVencidos(int idDpto, int idCondominio)
        {

            alGastosComunes.Clear();
            ObtenerDatosGastosComunes(idCondominio);

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalGastosComunes = 0;

            string sSel = "SELECT COUNT(*) FROM dbo.gastosComunes WHERE estado = 3 AND idDpto = '" + idDpto + "' ";
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
                    totalGastosComunes = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return totalGastosComunes;
        }

        public static int ObtenerTotalGastosComunesPagados(int idDpto, int idCondominio)
        {
            ObtenerDatosGastosComunes(idCondominio);
            alGastosComunes.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalGastosComunes = 0;

            string sSel = "SELECT COUNT(*) FROM dbo.gastosComunes WHERE estado = 2 AND idDpto = '" + idDpto + "' ";
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
                    totalGastosComunes = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return totalGastosComunes;
        }

        public static List<GastosComunes> GetAlGastosComunesVencidos(int idDpto, int idCond)
        {
            ObtenerDatosGastosComunesVencidos(idDpto, idCond);
            return alGastosComunes;
        }

        public static List<GastosComunes> ObtenerDatosGastosComunesVencidos(int idDpto, int idCond)
        {

            alGastosComunes.Clear();
            string strSql = String.Format("EXEC sp_obtener_gastosComunesVencidos @idCond = {0}, @idDpto = {1} ", idCond, idDpto);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    int mesCobro = int.Parse(sdr["mesCobro"].ToString());
                    int añoCobro = int.Parse(sdr["añoCobro"].ToString());
                    DateTime fechaEmision = DateTime.Parse(sdr["fechaEmision"].ToString());
                    DateTime fechaVencimiento = DateTime.Parse(sdr["fechaVencimiento"].ToString());
                    int gastoComun = int.Parse(sdr["gastoComun"].ToString());
                    int fondoReserva = int.Parse(sdr["fondoReserva"].ToString());
                    int multas = int.Parse(sdr["multas"].ToString());
                    int diasAtraso = int.Parse(sdr["diasAtraso"].ToString());
                    int moraPeriodo = int.Parse(sdr["moraPeriodo"].ToString());
                    int varios = int.Parse(sdr["varios"].ToString());
                    int estado = int.Parse(sdr["estado"].ToString());
                    DateTime fechaPago = DateTime.Parse(sdr["fechaPago"].ToString());
                    int totalPagar = int.Parse(sdr["totalPagar"].ToString());

                    GastosComunes gastosComunes = new GastosComunes(id, idDpto, numDpto, mesCobro, añoCobro, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, multas, diasAtraso, moraPeriodo, varios, idCond, estado, fechaPago, totalPagar);

                    alGastosComunes.Add(gastosComunes);
                }
                con.Close();
            }
            return alGastosComunes;
        }

        public static List<GastosComunes> GetAlGastosComunesPagados(int idDpto, int idCond)
        {
            ObtenerDatosGastosComunesPagados(idDpto, idCond);
            return alGastosComunes;
        }
        public static List<GastosComunes> ObtenerDatosGastosComunesPagados(int idDpto, int idCond)
        {

            alGastosComunes.Clear();
            string strSql = String.Format("EXEC sp_obtener_gastosComunesPagados @idCond = {0}, @idDpto = {1} ", idCond, idDpto);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    int mesCobro = int.Parse(sdr["mesCobro"].ToString());
                    int añoCobro = int.Parse(sdr["añoCobro"].ToString());
                    DateTime fechaEmision = DateTime.Parse(sdr["fechaEmision"].ToString());
                    DateTime fechaVencimiento = DateTime.Parse(sdr["fechaVencimiento"].ToString());
                    int gastoComun = int.Parse(sdr["gastoComun"].ToString());
                    int fondoReserva = int.Parse(sdr["fondoReserva"].ToString());
                    int multas = int.Parse(sdr["multas"].ToString());
                    int diasAtraso = int.Parse(sdr["diasAtraso"].ToString());
                    int moraPeriodo = int.Parse(sdr["moraPeriodo"].ToString());
                    int varios = int.Parse(sdr["varios"].ToString());
                    int estado = int.Parse(sdr["estado"].ToString());
                    DateTime fechaPago = DateTime.Parse(sdr["fechaPago"].ToString());
                    int totalPagar = int.Parse(sdr["totalPagar"].ToString());

                    GastosComunes gastosComunes = new GastosComunes(id, idDpto, numDpto, mesCobro, añoCobro, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, multas, diasAtraso, moraPeriodo, varios, idCond, estado, fechaPago, totalPagar);

                    alGastosComunes.Add(gastosComunes);
                }
                con.Close();
            }
            return alGastosComunes;
        }
    }
}