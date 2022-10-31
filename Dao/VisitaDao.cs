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

        //Residente
        public static List<Visita> ObtenerDatosVisita(string numDpto, int id_Cond)
        {
            alVisitas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id WHERE V.numDpto =" + numDpto + " AND V.id_Cond =" + id_Cond + " ORDER BY fecha DESC, hora DESC";
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

                    Visita visita = new Visita(id, numDptoQ, rut, nombres, apellidos, fecha, hora, patente, estado, id_Cond, idNumDpto);

                    alVisitas.Add(visita);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alVisitas;
        }

        public static bool AgregarVisitaR(string numDpto, string rut, string nombres, string apellidos, string patente, int id_Cond)
        {
            bool estado = false;

            string sCnn;

            if (numDpto != null && rut != null && nombres !=null && apellidos != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_agregar_visitas @numDpto = " + numDpto + ", @rut = '" + rut + "', @nombres = '" + nombres + "', @apellidos= '" + apellidos + "' , @patente= '" + patente + "' , @idCond= " + id_Cond + ", @estado=4";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    ObtenerDatosVisita(numDpto, id_Cond);

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }

        //Guardia
        public static List<Visita> GetAlVisitaTOP(int idCond)
        {
            ObtenerDatosVisitaTOP(idCond);
            return alVisitas;
        }
        public static List<Visita> GetAlVisita(int idCond)
        {
            ObtenerDatosVisita(idCond);
            return alVisitas;
        }
        public static List<Visita> GetAlVisitaHistorial(int idCond)
        {
            ObtenerDatosVisitaHistorial(idCond);
            return alVisitas;
        }
        public static void ObtenerDatosVisitaTOP(int idCond)
        {
            alVisitas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT TOP 10 V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.id_Cond, V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id_Cond = " + idCond + " ORDER BY fecha DESC,hora DESC";
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
                    int idNumDpto = int.Parse(dt.Rows[fila][10].ToString());

                    Visita visita = new Visita(id, numDptoQ, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
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

                    ObtenerDatosVisitaTOP(idCond);
                    ObtenerDatosVisita(idCond);
                    ObtenerDatosVisitaHistorial(idCond);

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }
        public static void ObtenerDatosVisita(int idCond)
        {
            alVisitas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.id_Cond, V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id_Cond = " + idCond + " and V.estado = 1 or V.estado = 4 ORDER BY fecha DESC,hora DESC";
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
                    int idNumDpto = int.Parse(dt.Rows[fila][10].ToString());

                    Visita visita = new Visita(id, numDptoQ, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static void ObtenerDatosVisitaHistorial(int idCond)
        {
            alVisitas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.id_Cond, V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id_Cond = " + idCond + " and V.estado = 2 or V.estado = 3 ORDER BY fecha DESC,hora DESC";
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
                    int idNumDpto = int.Parse(dt.Rows[fila][10].ToString());

                    Visita visita = new Visita(id, numDptoQ, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

                    alVisitas.Add(visita);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
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

                ObtenerDatosVisitaTOP(idCond);
                ObtenerDatosVisita(idCond);
                ObtenerDatosVisitaHistorial(idCond);

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

                string sSel = "SELECT V.id, D.numDpto as 'numDpto', V.rut, V.nombres, V.apellidos, V.fecha, V.hora, V.patente, E.descripcion as 'estado', V.id_Cond, V.numDpto FROM visitas V JOIN estadoVisita E ON V.estado = E.id JOIN departamento D ON V.numDpto = D.id where V.id = " + id + " and V.id_Cond = " + idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                string numDptoQ = dt.Rows[0][1].ToString();
                string rut = dt.Rows[0][2].ToString();
                string nombres = dt.Rows[0][3].ToString();
                string apellidos = dt.Rows[0][4].ToString();
                DateTime fecha = Convert.ToDateTime(dt.Rows[0][5]);
                TimeSpan hora = TimeSpan.Parse(dt.Rows[0][6].ToString());
                string patente = dt.Rows[0][7].ToString();
                string estado = dt.Rows[0][8].ToString();
                int idNumDpto = int.Parse(dt.Rows[0][10].ToString());

                visita = new Visita(id, numDptoQ, rut, nombres, apellidos, fecha, hora, patente, estado, idCond, idNumDpto);

            }
            catch (Exception)
            {

            }

            return visita;
        }
    }
}
