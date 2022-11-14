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
        public static int ObtenerTotalGastoComunes()
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT count(*) FROM gastosComunes";
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
        public static void ObtenerDatosGastosComunes(int idCond)
        {
            alGastosComunes.Clear();
            string strSql = String.Format("SELECT gc.id, gc.idDpto, D.numDpto, gc.mesCobro, gc.añoCobro, gc.fechaEmision, gc.fechaVencimiento, gc.gastoComun, gc.fondoReserva, gc.multas, gc.diasAtraso, gc.moraPeriodo, gc.varios, gc.id_Cond, gc.estado, gc.fechaPago from gastosComunes gc INNER JOIN estadoGastosComunes egc on gc.estado = egc.id INNER JOIN departamento d ON d.id = gc.idDpto where gc.id_Cond = {0}", idCond);

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

                    if(fechaPago== null)
                    {
                        fechaPago = DateTime.Parse("0000-00-00");
                    }


                    GastosComunes gastosComunes = new GastosComunes(id, idDpto, numDpto, mesCobro, añoCobro, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, multas, 0, 0, varios, idCond, estado, fechaPago);

                    alGastosComunes.Add(gastosComunes);
                }
                con.Close();
            }
        }

        //Residente

        public static List<GastosComunes> ObtenerDatosGastosComunesPagados(string numDpto, int id_Cond)
        {
            alGastosComunes.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT G.id, D.numDpto AS 'numDpto', G.fechaEmision, G.fechaVencimiento, G.gastoComun, G.fondoReserva, G.seguro, G.multas, G.moraPeriodo, G.varios, E.descripcion AS 'estado' FROM gastosComunes G JOIN departamento D ON G.numDpto = D.id JOIN estadoGastosComunes E ON G.estado = E.id WHERE G.numDpto =" + numDpto + " AND G.id_Cond =" + id_Cond + " AND G.estado = 2 ORDER BY fechaEmision desc ";
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
                    String numDptoQ = dt.Rows[fila][1].ToString();
                    DateTime fechaEmision = Convert.ToDateTime(dt.Rows[fila][2]);
                    DateTime fechaVencimiento = Convert.ToDateTime(dt.Rows[fila][3]);
                    int gastoComun = int.Parse(dt.Rows[fila][4].ToString());
                    int fondoReserva = int.Parse(dt.Rows[fila][5].ToString());
                    int seguro = int.Parse(dt.Rows[fila][6].ToString());
                    int multas = int.Parse(dt.Rows[fila][7].ToString());
                    int moraPeriodo = int.Parse(dt.Rows[fila][8].ToString());
                    int varios = int.Parse(dt.Rows[fila][9].ToString());
                    string estado = dt.Rows[fila][10].ToString();

                    //GastosComunes gastoscomunes = new GastosComunes(id, numDptoQ, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, seguro, multas, moraPeriodo, varios, id_Cond, estado);

                    //alGastosComunes.Add(gastoscomunes);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alGastosComunes;
        }

        public static List<GastosComunes> ObtenerDatosUltimoGastoComunPagado(string numDpto, int id_Cond)
        {
            alGastosComunes.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT TOP (1) G.id, D.numDpto AS 'numDpto', G.fechaEmision, G.fechaVencimiento, G.gastoComun, G.fondoReserva, G.seguro, G.multas, G.moraPeriodo, G.varios, E.descripcion AS 'estado' FROM gastosComunes G JOIN departamento D ON G.numDpto = D.id JOIN estadoGastosComunes E ON G.estado = E.id WHERE G.numDpto =" + numDpto + " AND G.id_Cond =" + id_Cond + "AND G.estado = 2 ORDER BY G.id DESC";
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
                    String numDptoQ = dt.Rows[fila][1].ToString();
                    DateTime fechaEmision = Convert.ToDateTime(dt.Rows[fila][2]);
                    DateTime fechaVencimiento = Convert.ToDateTime(dt.Rows[fila][3]);
                    int gastoComun = int.Parse(dt.Rows[fila][4].ToString());
                    int fondoReserva = int.Parse(dt.Rows[fila][5].ToString());
                    int seguro = int.Parse(dt.Rows[fila][6].ToString());
                    int multas = int.Parse(dt.Rows[fila][7].ToString());
                    int moraPeriodo = int.Parse(dt.Rows[fila][8].ToString());
                    int varios = int.Parse(dt.Rows[fila][9].ToString());
                    string estado = dt.Rows[fila][10].ToString();

                    //GastosComunes gastoscomunes = new GastosComunes(id, numDptoQ, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, seguro, multas, moraPeriodo, varios, id_Cond, estado);

                    //alGastosComunes.Add(gastoscomunes);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alGastosComunes;
        }

        public static List<GastosComunes> ObtenerDatosGastosComunesPorPagar(string numDpto, int id_Cond)
        {
            alGastosComunes.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT G.id, D.numDpto AS 'numDpto', G.fechaEmision, G.fechaVencimiento, G.gastoComun, G.fondoReserva, G.seguro, G.multas, G.moraPeriodo, G.varios, E.descripcion AS 'estado' FROM gastosComunes G JOIN departamento D ON G.numDpto = D.id JOIN estadoGastosComunes E ON G.estado = E.id WHERE G.numDpto =" + numDpto + " AND G.id_Cond =" + id_Cond + "AND G.estado IN (1,3) ORDER BY G.fechaEmision DESC";
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
                    String numDptoQ = dt.Rows[fila][1].ToString();
                    DateTime fechaEmision = Convert.ToDateTime(dt.Rows[fila][2]);
                    DateTime fechaVencimiento = Convert.ToDateTime(dt.Rows[fila][3]);
                    int gastoComun = int.Parse(dt.Rows[fila][4].ToString());
                    int fondoReserva = int.Parse(dt.Rows[fila][5].ToString());
                    int seguro = int.Parse(dt.Rows[fila][6].ToString());
                    int multas = int.Parse(dt.Rows[fila][7].ToString());
                    int moraPeriodo = int.Parse(dt.Rows[fila][8].ToString());
                    int varios = int.Parse(dt.Rows[fila][9].ToString());
                    string estado = dt.Rows[fila][10].ToString();

                    //GastosComunes gastoscomunes = new GastosComunes(id, numDptoQ, fechaEmision, fechaVencimiento, gastoComun, fondoReserva, seguro, multas, moraPeriodo, varios, id_Cond, estado);

                    //alGastosComunes.Add(gastoscomunes);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alGastosComunes;
        }


    }
}
