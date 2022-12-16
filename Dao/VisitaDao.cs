using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace Dao
{
    public class VisitaDao
    {
        private static readonly List<Visita> alVisitas = new List<Visita>();
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        //Residente
        public static List<Visita> GetAlVisitaTOPR(int numDpto, int idCond)
        {
            ObtenerDatosVisitaTOPR(numDpto, idCond);
            return alVisitas;
        }
        public static List<Visita> GetAlVisitaPendiente(int idNumDpto, int idCond)
        {
            ObtenerDatosVisitaPendiente(idNumDpto, idCond);
            return alVisitas;
        }
        public static List<Visita> GetAlVisitaRegistrada(int idNumDpto, int idCond, int mes, int año)
        {
            ObtenerDatosVisitaRegistrada(idNumDpto, idCond, mes, año);
            return alVisitas;
        }
        public static void ObtenerDatosVisitaTOPR(int idNumDpto, int idCond)
        {
            alVisitas.Clear();
            string strSql = String.Format("SELECT TOP (3) V.id, D.numDpto, V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.id_Cond FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.numDpto = {0} and V.id_Cond = {1} ORDER BY fecha DESC,hora DESC", idNumDpto, idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string rut = sdr["rut"].ToString();
                    string nombres = sdr["nombres"].ToString();
                    string apellidos = sdr["apellidos"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string patente = sdr["patente"].ToString();
                    string estado = sdr["estado"].ToString();

                    Visita visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
                con.Close();
            }
        }
        public static List<Visita> ObtenerDatosVisita(int numDpto, int idCond, int mes2, int año2)
        {
            alVisitas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id WHERE V.numDpto =" + numDpto + " AND V.id_Cond =" + idCond + " AND V.estado IN (2,3) AND MONTH(V.fecha)=" + mes2 + " AND YEAR(V.fecha)=" + año2 + " ORDER BY fecha DESC, hora DESC";
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
                    string numDptoQ = dt.Rows[fila][1].ToString();
                    string rut = dt.Rows[fila][2].ToString();
                    string nombres = dt.Rows[fila][3].ToString();
                    string apellidos = dt.Rows[fila][4].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][5]);
                    TimeSpan hora = TimeSpan.Parse(dt.Rows[fila][6].ToString());
                    string patente = dt.Rows[fila][7].ToString();
                    string estado = dt.Rows[fila][8].ToString();
                    int idNumDpto = int.Parse(dt.Rows[fila][9].ToString());

                    Visita visita = new Visita(id, numDptoQ, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alVisitas;
        }
        public static void ObtenerDatosVisitaPendiente(int idNDpto, int idCond)
        {
            alVisitas.Clear();
            string strSql = String.Format("SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id WHERE V.numDpto = {0} AND V.id_Cond = {1} AND V.estado = 1 ORDER BY fecha DESC, hora DESC", idNDpto, idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string rut = sdr["rut"].ToString();
                    string nombres = sdr["nombres"].ToString();
                    string apellidos = sdr["apellidos"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string patente = sdr["patente"].ToString();
                    string estado = sdr["estado"].ToString();

                    Visita visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNDpto);

                    alVisitas.Add(visita);
                }
                con.Close();
            }
        }
        public static void ObtenerDatosVisitaRegistrada(int idNDpto, int idCond, int mes, int año)
        {
            alVisitas.Clear();
            string strSql = String.Format("SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id WHERE V.numDpto = {0} AND V.id_Cond = {1} AND V.estado = 4 AND MONTH(V.fecha)={2} AND YEAR(V.fecha)={3} ORDER BY fecha DESC, hora DESC", idNDpto, idCond, mes, año);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string rut = sdr["rut"].ToString();
                    string nombres = sdr["nombres"].ToString();
                    string apellidos = sdr["apellidos"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string patente = sdr["patente"].ToString();
                    string estado = sdr["estado"].ToString();

                    Visita visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNDpto);

                    alVisitas.Add(visita);
                }
                con.Close();
            }
        }
        public static bool AgregarVisitaR(string numDpto, string rut, string nombres, string apellidos, string fecha, string patente, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (numDpto != null && rut != null && nombres != null && apellidos != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_agregar_visitasR @numDpto = " + numDpto + ", @rut = '" + rut + "', @nombres = '" + nombres + "', @apellidos= '" + apellidos + "',@fecha= '" + fecha + "', @patente= '" + patente + "' , @idCond= " + idCond + ", @estado=4";

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
        public static bool ModificarVisitaR(string id, int idCond, string numDpto, string rut, string nombres, string apellidos, string fecha, string patente)
        {
            bool estado = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC	sp_modificar_visitaR @id = " + id + ", @idCond = " + idCond + ", @numDpto = " + numDpto + ", @rut = '" + rut + "', @nombres = '" + nombres + "', @apellidos = '" + apellidos + "', @fecha = '" + fecha + "', @patente = '" + patente + "'";

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
        public static int ObtenerTotalVisitasPendientes(int idDpto)
        {
            alVisitas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalVisitas = 0;

            string sSel = "select COUNT(*) from visitas where estado = 1 and numDpto =  " + idDpto + " ";
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
                    totalVisitas = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return totalVisitas;
        }
        public static bool AprobarVisita(int id)
        {

            bool estado = false;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();


            string sSel = "EXECUTE sp_aprobar_visita @id= '" + id + "' ";
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
        public static bool RechazarVisita(int id)
        {

            bool estado = false;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();


            string sSel = "EXECUTE sp_rechazar_visita @id= '" + id + "' ";
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
        public static List<Visita> GetAlVisitaTOP(int idCond)
        {
            ObtenerDatosVisitaTOP(idCond);
            return alVisitas;
        }
        public static List<Visita> GetAlVisita(int idCond, string depto, int mes, int año)
        {
            ObtenerDatosVisitaG(idCond, depto, mes, año);
            return alVisitas;
        }
        public static List<Visita> GetAlVisitaHistorial(int idCond, string depto2, int mes2, int año2)
        {
            ObtenerDatosVisitaHistorial(idCond, depto2, mes2, año2);
            return alVisitas;
        }
        public static List<Visita> GetAlVisitaPendienteG(int idCond)
        {
            ObtenerDatosVisitaPendienteG(idCond);
            return alVisitas;
        }
        public static void ObtenerDatosVisitaTOP(int idCond)
        {
            alVisitas.Clear();
            string strSql = String.Format("SELECT TOP 10 V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto as idNumDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id_Cond = {0} ORDER BY fecha DESC,hora DESC", idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string rut = sdr["rut"].ToString();
                    string nombres = sdr["nombres"].ToString();
                    string apellidos = sdr["apellidos"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string patente = sdr["patente"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idNumDpto = int.Parse(sdr["idNumDpto"].ToString());

                    Visita visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
                con.Close();
            }
        }
        public static bool AgregarVisitaG(string numDpto, string rut, string nombres, string apellidos, string patente, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (numDpto != null && rut != null && nombres != null && apellidos != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_agregar_visitas @numDpto = " + numDpto + ", @rut = '" + rut + "', @nombres = '" + nombres + "', @apellidos = '" + apellidos + "', @patente = '" + patente + "', @idCond = " + idCond + ", @estado=1";

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
        public static void ObtenerDatosVisitaG(int idCond, string depto, int mes, int año)
        {
            alVisitas.Clear();
            string strSql = String.Format("SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto as idNumDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id_Cond = {0} AND (V.estado = 1) AND MONTH(V.fecha)={1} AND YEAR(V.fecha)={2} " + depto + " ORDER BY fecha DESC,hora DESC", idCond, mes, año);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string rut = sdr["rut"].ToString();
                    string nombres = sdr["nombres"].ToString();
                    string apellidos = sdr["apellidos"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string patente = sdr["patente"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idNumDpto = int.Parse(sdr["idNumDpto"].ToString());

                    Visita visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
                con.Close();
            }
        }
        public static void ObtenerDatosVisitaHistorial(int idCond, string depto2, int mes2, int año2)
        {
            alVisitas.Clear();
            string strSql = String.Format("SELECT V.id, D.numDpto, V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto AS idNumDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id_Cond = {0} and (V.estado = 2 or V.estado = 3) AND MONTH(V.fecha)={1} AND YEAR(V.fecha)={2} " + depto2 + " ORDER BY fecha DESC, hora DESC", idCond, mes2, año2);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string rut = sdr["rut"].ToString();
                    string nombres = sdr["nombres"].ToString();
                    string apellidos = sdr["apellidos"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string patente = sdr["patente"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idNumDpto = int.Parse(sdr["idNumDpto"].ToString());

                    Visita visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
                con.Close();
            }
        }
        public static int ObtenerTotalVisitasPendientesG(int idCond)
        {
            alVisitas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalReservas = 0;

            string sSel = "select count(*) from visitas where estado = 4 and id_cond = " + idCond + "";
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
        public static void ObtenerDatosVisitaPendienteG(int idCond)
        {
            alVisitas.Clear();
            string strSql = String.Format("SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto as 'idDpto' FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id WHERE V.id_Cond = {0} AND V.estado = 4 ORDER BY fecha DESC, hora DESC", idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string rut = sdr["rut"].ToString();
                    string nombres = sdr["nombres"].ToString();
                    string apellidos = sdr["apellidos"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string patente = sdr["patente"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idDpto = int.Parse(sdr["idDpto"].ToString());

                    Visita visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idDpto);

                    alVisitas.Add(visita);
                }
                con.Close();
            }
        }
        public static bool ModificarVisitaG(string id, int idCond, string numDpto, string rut, string nombres, string apellidos, string patente, string estadoV)
        {
            bool estado = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC	sp_modificar_visita @id = " + id + ", @idCond = " + idCond + ", @numDpto = " + numDpto + ", @rut = '" + rut + "', @nombres = '" + nombres + "', @apellidos = '" + apellidos + "', @patente = '" + patente + "', @estado = " + estadoV + "";

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
        public static Visita BuscarVisita(int id, int idCond)
        {

            Visita visita = null;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id = " + id + " and V.id_Cond = " + idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                string numDpto = dt.Rows[0][1].ToString();
                string rut = dt.Rows[0][2].ToString();
                string nombres = dt.Rows[0][3].ToString();
                string apellidos = dt.Rows[0][4].ToString();
                DateTime fecha = Convert.ToDateTime(dt.Rows[0][5]);
                TimeSpan hora = TimeSpan.Parse(dt.Rows[0][6].ToString());
                string patente = dt.Rows[0][7].ToString();
                string estado = dt.Rows[0][8].ToString();
                int idNumDpto = int.Parse(dt.Rows[0][9].ToString());

                visita = new Visita(id, numDpto, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

            }
            catch (Exception)
            {

            }

            return visita;
        }
        public static bool EliminarVisita(int id)
        {
            bool estado = true;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();


                string sSel = "delete from visitas where id = " + id + "";

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
