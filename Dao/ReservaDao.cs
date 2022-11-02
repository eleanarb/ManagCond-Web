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
        private static string connectionString = "Server = localhost\\SQLEXPRESS01; Database = managcond; Trusted_Connection = True;";

        public static List<Reserva> GetAlReservasPendientes(int idCondominio)
        {
            ObtenerReservasPendientes(idCondominio);
            return alReservas;
        }
        public static List<Reserva> GetAlReservasAnteriores(int idCondominio)
        {
            ObtenerReservasAnteriores(idCondominio);
            return alReservas;
        }

        public static int ObtenerTotalReservasPendientes(int idCondominio)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalReservas = 0;

            string sSel = "select count(*) from reservasEspacios where estado = 1 and id_cond = '" + idCondominio + "' ";
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

        public static void ObtenerReservasPendientes(int idCondominio)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where reservasEspacios.estado = 1 and reservasEspacios.id_Cond = '" + idCondominio + "' ";
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
                    int idCond = int.Parse(dt.Rows[fila][7].ToString());
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

        public static void ObtenerReservasAnteriores(int idCondominio)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where reservasEspacios.estado = 2 or reservasEspacios.estado = 3 and reservasEspacios.id_Cond = '" + idCondominio + "' ";
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
                    int idCond = int.Parse(dt.Rows[fila][7].ToString());
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
        //Guardia
        public static List<Reserva> GetAlReservasAnterioresG(int idCondominio)
        {
            ObtenerReservasAnterioresG(idCondominio);
            return alReservas;
        }
        public static void ObtenerReservasAnterioresG(int idCondominio)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where reservasEspacios.estado = 2 or reservasEspacios.estado = 4 and reservasEspacios.id_Cond = '" + idCondominio + "' ";
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
                    int idCond = int.Parse(dt.Rows[fila][7].ToString());
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
        public static List<Reserva> GetAlReservasTOPG(int idCondominio)
        {
            ObtenerReservasTOPG(idCondominio);
            return alReservas;
        }
        public static void ObtenerReservasTOPG(int idCondominio)
        {
            alReservas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT TOP 10 * FROM reservasEspacios INNER JOIN espaciosComunes ON reservasEspacios.espacioComun = espaciosComunes.id where reservasEspacios.estado = 2 and reservasEspacios.id_Cond = '" + idCondominio + "' ";
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
                    int idCond = int.Parse(dt.Rows[fila][7].ToString());
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

    }
}
