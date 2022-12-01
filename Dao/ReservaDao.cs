using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Dao
{
    public class  ReservaDao
    {
        private static readonly List<Reserva> alReservas = new List<Reserva>();
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        private static string connectionString = "Server=tcp:managcondserver.database.windows.net,1433;Initial Catalog=managcond;Persist Security Info=False;User ID=Administrador;Password=Tallo2820@#;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";

        public static List<Reserva> GetAlReservasPendientes(int idCond)
        {
            ObtenerReservasPendientes(idCond);
            return alReservas;
        }
        public static List<Reserva> GetAlReservasAnteriores(int idCond)
        {
            ObtenerReservasAnteriores(idCond);
            return alReservas;
        }

        public static int ObtenerTotalReservasPendientes(int idCond)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalReservas = 0;

            string sSel = "select count(*) from reservasEspacios where estado = 1 and id_cond = '" + idCond + "' ";
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
                    totalReservas = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return totalReservas;
        }

        public static void ObtenerReservasPendientes(int idCond)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where reservasEspacios.estado = 1 and reservasEspacios.id_Cond = '" + idCond + "' ";
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
                    String numDpto = dt.Rows[fila][1].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][2]);
                    String rangoHorario = dt.Rows[fila][3].ToString();
                    String solicitante = dt.Rows[fila][5].ToString();
                    int estado = int.Parse(dt.Rows[fila][6].ToString());
                    string espacioComun = dt.Rows[fila][9].ToString();

                    Reserva reserva = new Reserva(id, numDpto, fecha, rangoHorario, espacioComun, solicitante, estado, idCond);

                    alReservas.Add(reserva);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static void ObtenerReservasAnteriores(int idCond)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where (reservasEspacios.estado = 2 or reservasEspacios.estado = 3) and reservasEspacios.id_Cond = '" + idCond + "' ";
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
                    String numDpto = dt.Rows[fila][1].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][2]);
                    String rangoHorario = dt.Rows[fila][3].ToString();
                    String solicitante = dt.Rows[fila][5].ToString();
                    int estado = int.Parse(dt.Rows[fila][6].ToString());
                    string espacioComun = dt.Rows[fila][9].ToString();


                    Reserva reserva = new Reserva(id, numDpto, fecha, rangoHorario, espacioComun, solicitante, estado, idCond);

                    alReservas.Add(reserva);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static bool AprobarReserva (int id)
        {

            bool estado = false;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int exit = 0;

            string sSel = "EXECUTE sp_aprobar_reserva @id= '" + id + "', @exit = 0 ";
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
                    if(exit == 1)
                    {
                        estado = true;
                    }else if(exit == 0)
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

        public static bool RechazarReserva(int id)
        {

            bool estado = false;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();


            string sSel = "EXECUTE sp_rechazar_reserva @id= '" + id + "' ";
            SqlDataAdapter da;
            DataTable dt = new DataTable();
            try
            {
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);
                estado = true;
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }

            return estado;
        }
        //Guardia
        public static List<Reserva> GetAlReservasAnterioresG(int idCond)
        {
            ObtenerReservasAnterioresG(idCond);
            return alReservas;
        }
        public static List<Reserva> GetAlReservasTOPG(int idCond)
        {
            ObtenerReservasTOPG(idCond);
            return alReservas;
        }
        public static void ObtenerReservasAnterioresG(int idCond)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where (reservasEspacios.estado = 2 or reservasEspacios.estado = 4) and reservasEspacios.id_Cond = " + idCond + "";
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
                    String numDpto = dt.Rows[fila][1].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][2]);
                    String rangoHorario = dt.Rows[fila][3].ToString();
                    String solicitante = dt.Rows[fila][5].ToString();
                    int estado = int.Parse(dt.Rows[fila][6].ToString());
                    string espacioComun = dt.Rows[fila][9].ToString();

                    Reserva reserva = new Reserva(id, numDpto, fecha, rangoHorario, espacioComun, solicitante, estado, idCond);

                    alReservas.Add(reserva);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static void ObtenerReservasTOPG(int idCond)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT TOP 10 * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where reservasEspacios.estado = 2 and reservasEspacios.id_Cond = " + idCond + "";
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
                    string numDpto = dt.Rows[fila][1].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][2]);
                    string rangoHorario = dt.Rows[fila][3].ToString();
                    string solicitante = dt.Rows[fila][5].ToString();
                    int estado = int.Parse(dt.Rows[fila][6].ToString());
                    string espacioComun = dt.Rows[fila][9].ToString();

                    Reserva reserva = new Reserva(id, numDpto, fecha, rangoHorario, espacioComun, solicitante, estado, idCond);

                    alReservas.Add(reserva);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        //Residente
        public static List<Reserva> GetAlReservasTOPR(string numDpto, int idCond)
        {
            ObtenerReservasTOPR(numDpto, idCond);
            return alReservas;
        }
        public static List<Reserva> GetAlReservasR(string numDpto, int idCond)
        {
            ObtenerReservasR(numDpto, idCond);
            return alReservas;
        }
        public static List<Reserva> GetAlReservasRP(string numDpto, int idCond)
        {
            ObtenerReservasRP(numDpto, idCond);
            return alReservas;
        }
        public static void ObtenerReservasTOPR(string numDpto, int idCond)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT TOP 10 * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where reservasEspacios.numDpto = " + numDpto + " and reservasEspacios.id_Cond = " + idCond + "";
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
                    string numDptoN = dt.Rows[fila][1].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][2]);
                    string rangoHorario = dt.Rows[fila][3].ToString();
                    string solicitante = dt.Rows[fila][5].ToString();
                    int estado = int.Parse(dt.Rows[fila][6].ToString());
                    string espacioComun = dt.Rows[fila][9].ToString();

                    Reserva reserva = new Reserva(id, numDptoN, fecha, rangoHorario, espacioComun, solicitante, estado, idCond);

                    alReservas.Add(reserva);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static bool AgregarReserva(int numDpto, string fecha, string rangoFecha, int espacioComun, string solicitante, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (numDpto != 0 && fecha != null && rangoFecha != null && espacioComun != 0 && solicitante != null && idCond != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_reserva @numdpto = " + numDpto + ", @fecha ='" + fecha + "', @rangoFecha = '" + rangoFecha + "', @espacioComun = " + espacioComun + ", @solicitante = '" + solicitante + "', @idCond = " + idCond + "";

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
        public static void ObtenerReservasR(string numDpto, int idCond)
        {
            alReservas.Clear();
            string strSql = String.Format("SELECT R.id, D.numDpto as 'numDpto', R.solicitante, E.nombre as 'espacioComun' ,R.fecha, R.rangoFecha, R.estado FROM reservasEspacios R JOIN departamento D ON R.numDpto = D.id JOIN espaciosComunes E ON E.id = R.espacioComun WHERE R.numDpto = {0} AND E.id_Cond = {1} AND (R.estado = 1 or R.estado = 2) ORDER BY fecha DESC", numDpto, idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDptoN = sdr["numDpto"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    string rangoFecha = sdr["rangoFecha"].ToString();
                    string espacioComun = sdr["espacioComun"].ToString();
                    string solicitante = sdr["solicitante"].ToString();
                    int estado = int.Parse(sdr["estado"].ToString());

                    Reserva reserva = new Reserva(id, numDptoN, fecha, rangoFecha, espacioComun, solicitante, estado, idCond);

                    alReservas.Add(reserva);
                }
                con.Close();
            }
        }
        public static void ObtenerReservasRP(string numDpto, int idCond)
        {
            alReservas.Clear();
            string strSql = String.Format("SELECT R.id, D.numDpto as 'numDpto', R.solicitante, E.nombre as 'espacioComun' ,R.fecha, R.rangoFecha, R.estado FROM reservasEspacios R JOIN departamento D ON R.numDpto = D.id JOIN espaciosComunes E ON E.id = R.espacioComun WHERE R.numDpto = {0} AND E.id_Cond = {1} AND (R.estado = 3 or R.estado = 4) ORDER BY fecha DESC", numDpto, idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDptoN = sdr["numDpto"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    string rangoFecha = sdr["rangoFecha"].ToString();
                    string espacioComun = sdr["espacioComun"].ToString();
                    string solicitante = sdr["solicitante"].ToString();
                    int estado = int.Parse(sdr["estado"].ToString());

                    Reserva reserva = new Reserva(id, numDptoN, fecha, rangoFecha, espacioComun, solicitante, estado, idCond);

                    alReservas.Add(reserva);
                }
                con.Close();
            }
        }
        public static Reserva BuscarReserva(int id, int idCond)
        {

            Reserva reserva = null;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "SELECT R.id, D.numDpto as 'numDpto', R.solicitante, E.nombre as 'espacioComun' ,R.fecha, R.rangoFecha, R.estado FROM reservasEspacios R JOIN departamento D ON R.numDpto = D.id JOIN espaciosComunes E ON E.id = R.espacioComun WHERE R.id = " + id + " AND E.id_Cond = " + idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                string numDptoN = dt.Rows[0][1].ToString();
                string solicitante = dt.Rows[0][2].ToString();
                string espacioComun = dt.Rows[0][3].ToString();
                DateTime fecha = Convert.ToDateTime(dt.Rows[0][4]);
                string rangoFecha = dt.Rows[0][5].ToString();
                int estado = int.Parse(dt.Rows[0][6].ToString());

                reserva = new Reserva(id, numDptoN, fecha, rangoFecha, espacioComun, solicitante, estado, idCond);

            }
            catch (Exception)
            {

            }

            return reserva;
        }
        public static bool ModificarReservaR(int id, int numDpto, string fecha, string rangoFecha, string espacioComun, string solicitante, int idCond)
        {
            bool estado = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_modificar_reserva @id = " + id + ", @numDpto = " + numDpto + ", @fecha = '" + fecha + "', @rangoFecha = '" + rangoFecha + "', @espacioComun = " + espacioComun + ", @solicitante = '" + solicitante + "', @idCond = " + idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                estado = true;
            }
            catch (Exception)
            {

            }
            return estado;
        }
    }
}
