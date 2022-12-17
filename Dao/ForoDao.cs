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
    public class ForoDao
    {
        private static readonly List<Foro> alForo1 = new List<Foro>();
        private static readonly List<RespuestaForo> alRespuestas = new List<RespuestaForo>();

        public static List<Foro> GetAlPublicacionesForo(int idCondominio, string categoria)
        {
            ObtenerPublicacionesForo(idCondominio, categoria);
            return alForo1;
        }

        public static List<RespuestaForo> GetAlRespuestasForo(int idForo)
        {
            ObtenerRespuestasForo(idForo);
            return alRespuestas;
        }

        public static Foro ObtenerDatosPublicacion(int id)
        {
            alForo1.Clear();
            Foro foro = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT f.id, u.rut, concat(u.nombres, ' ', u.apellidos) as nombre, f.mensaje, f.fecha, f.hora, f.imagen, f.idCond, cf.nombre, cf.importancia, d.numDpto, u.tipoUsuario FROM foro f INNER JOIN categoriaForo cf ON f.categoria = cf.id INNER JOIN usuario u ON f.rut = u.rut INNER JOIN departamento d ON u.numDpto = d.id where f.id = '" + id + "'";
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
                    int idF = int.Parse(dt.Rows[fila][0].ToString());
                    String rut = dt.Rows[fila][1].ToString();
                    String nombre = dt.Rows[fila][2].ToString();
                    String mensaje = dt.Rows[fila][3].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][4]);
                    TimeSpan hora = TimeSpan.Parse(dt.Rows[fila][5].ToString());
                    String imagen = dt.Rows[fila][6].ToString();
                    int idCond = int.Parse(dt.Rows[fila][7].ToString());
                    String categoria = dt.Rows[fila][8].ToString();
                    int importancia = int.Parse(dt.Rows[fila][9].ToString());
                    String depto = dt.Rows[fila][10].ToString();
                    int tipoUsuario = int.Parse(dt.Rows[fila][11].ToString());

                    foro = new Foro(id, rut, nombre, mensaje, fecha, hora, imagen, idCond, categoria, importancia, depto, tipoUsuario);

                }
            }
            catch (Exception)
            {

            }
            return foro;
        }

        public static void ObtenerPublicacionesForo(int idCondominio, string sCategoria)
        {
            alForo1.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT f.id, u.rut, concat(u.nombres, ' ', u.apellidos) as nombre, f.mensaje, f.fecha, f.hora, f.imagen, f.idCond, cf.nombre, cf.importancia, d.numDpto, u.tipoUsuario FROM foro f INNER JOIN categoriaForo cf ON f.categoria = cf.id INNER JOIN usuario u ON f.rut = u.rut INNER JOIN departamento d ON u.numDpto = d.id where f.idCond = '" + idCondominio + "' " + sCategoria + " ";
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
                    String rut = dt.Rows[fila][1].ToString();
                    String nombre = dt.Rows[fila][2].ToString();
                    String mensaje = dt.Rows[fila][3].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][4]);
                    TimeSpan hora = TimeSpan.Parse(dt.Rows[fila][5].ToString());
                    String imagen = dt.Rows[fila][6].ToString();
                    int idCond = int.Parse(dt.Rows[fila][7].ToString());
                    String categoria = dt.Rows[fila][8].ToString();
                    int importancia = int.Parse(dt.Rows[fila][9].ToString());
                    String depto = dt.Rows[fila][10].ToString();
                    int tipoUsuario = int.Parse(dt.Rows[fila][11].ToString());

                    Foro foro = new Foro(id, rut, nombre, mensaje, fecha, hora, imagen, idCond, categoria, importancia, depto, tipoUsuario);

                    alForo1.Add(foro);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static void ObtenerRespuestasForo(int idForo)
        {
            alRespuestas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT rf.id, rf.idForo, rf.mensaje, rf.rut, concat(u.nombres, ' ', u.apellidos) as nombre, rf.fecha, rf.hora, rf.imagen, d.numDpto, u.tipoUsuario   FROM respuestaforo rf INNER JOIN foro f ON f.id = rf.idForo INNER JOIN usuario u ON rf.rut = u.rut INNER JOIN departamento d ON u.numDpto = d.id where f.id = '" + idForo + "' ";
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
                    int idForo2 = int.Parse(dt.Rows[fila][1].ToString());
                    String mensaje = dt.Rows[fila][2].ToString();
                    String rut = dt.Rows[fila][3].ToString();
                    String nombre = dt.Rows[fila][4].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][5]);
                    TimeSpan hora = TimeSpan.Parse(dt.Rows[fila][6].ToString());
                    String imagen = dt.Rows[fila][7].ToString();
                    String depto = dt.Rows[fila][8].ToString();
                    int tipoUsuario = int.Parse(dt.Rows[fila][9].ToString());

                    RespuestaForo respuestaForo = new RespuestaForo(id, idForo2, mensaje, rut, nombre, fecha, hora, imagen, depto, tipoUsuario);

                    alRespuestas.Add(respuestaForo);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static int ObtenerTotalRespuestas(int idForo)
        {


            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "select count(*) from respuestaForo where idForo = '" + idForo + "' ";
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

        public static bool AgregarRespuestaForo(int idForo, string mensaje, string rut, string imagen)
        {
            bool estado = false;

            string sCnn;

            if (idForo != 0 && rut != null && mensaje != null && rut != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_agregar_respuestaForo @idForo = " + idForo + ", @mensaje = '" + mensaje + "', @rut = '" + rut + "', @imagen= NULL ";

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

        public static bool AgregarPublicacionForo(string mensaje, string rut, string imagen, int categoria, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (categoria != 0 && rut != null && mensaje != null && rut != null && idCond != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_agregar_publicarForo @mensaje = '" + mensaje + "', @rut = '" + rut + "', @categoria = '" + categoria + "', @idCond = '" + idCond + "', @imagen= NULL ";

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

    }
}
