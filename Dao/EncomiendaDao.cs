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
    public class EncomiendaDao
    {
        //Residente
        private static readonly List<Encomienda> alEncomiendas = new List<Encomienda>();

        public static List<Encomienda> ObtenerDatosEncomienda(string numDpto, int id_Cond)
        {
            alEncomiendas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT E.id, D.numDpto as 'numDpto', E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', V.numDpto FROM encomienda E JOIN departamento D ON E.numDpto = D.id JOIN estadoEncomienda EE ON E.estado = EE.id WHERE E.numDpto = " + numDpto + " AND E.id_Cond =" + id_Cond + "";
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
                    string Destinatario = dt.Rows[fila][2].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][3]);
                    TimeSpan Hora = TimeSpan.Parse(dt.Rows[fila][4].ToString());
                    string Descripcion = dt.Rows[fila][5].ToString();
                    string imagen = dt.Rows[fila][6].ToString();
                    string estado = dt.Rows[fila][7].ToString();
                    int idNumDpto = int.Parse(dt.Rows[fila][9].ToString());

                    Encomienda encomienda = new Encomienda(id, numDptoQ, Destinatario, fecha, Hora, Descripcion, imagen, estado, id_Cond, idNumDpto);

                    alEncomiendas.Add(encomienda);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alEncomiendas;
        }

        //Guardia

        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        public static List<Encomienda> GetAlEncomiendasTOP(int idCond)
        {
            ObtenerDatosEncomiendaTOP(idCond);
            return alEncomiendas;
        }
        public static List<Encomienda> GetAlEncomiendas(int idCond)
        {
            ObtenerDatosEncomiendasP(idCond);
            return alEncomiendas;
        }
        public static List<Encomienda> GetAlEncomiendasHistorial(int idCond)
        {
            ObtenerDatosEncomiendaHistorial(idCond);
            return alEncomiendas;
        }
        public static void ObtenerDatosEncomiendaTOP(int idCond)
        {
            alEncomiendas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT TOP 10 E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.id_Cond, E.numDpto FROM encomienda E JOIN estadoEncomienda EE ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id where E.id_Cond = " + idCond + " ORDER BY fecha DESC,hora DESC";
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
                    string Destinatario = dt.Rows[fila][2].ToString();
                    DateTime fecha = DateTime.Parse(dt.Rows[fila][3].ToString());
                    TimeSpan Hora = TimeSpan.Parse(dt.Rows[fila][4].ToString());
                    string Descripcion = dt.Rows[fila][5].ToString();
                    string imagen = dt.Rows[fila][6].ToString();
                    string estado = dt.Rows[fila][7].ToString();
                    int idNumDpto = int.Parse(dt.Rows[fila][8].ToString());

                    Encomienda encomienda = new Encomienda(id, numDpto, Destinatario, fecha, Hora, Descripcion, imagen, estado, idCond, idNumDpto);

                    alEncomiendas.Add(encomienda);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static bool AgregarEncomienda(string numDpto, string destinatario, string descripcion, string imagen, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (numDpto != null && destinatario != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_encomienda @numDpto = " + numDpto + ", @destinatario = '" + destinatario + "', @descripcion = '" + descripcion + "', @imagen= '" + imagen + "', @idCond= " + idCond + "";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    ObtenerDatosEncomiendaTOP(idCond);
                    ObtenerDatosEncomiendasP(idCond);
                    ObtenerDatosEncomiendaHistorial(idCond);

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }

        public static void ObtenerDatosEncomiendasP(int idCond)
        {
            alEncomiendas.Clear();
            string strSql = String.Format("SELECT E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.id_Cond, E.numDpto as idNumDpto FROM encomienda E JOIN estadoEncomienda EE ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id where estado = 1 and E.id_Cond= {0} ORDER BY fecha DESC,hora DESC", idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string Destinatario = sdr["destinatario"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan Hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string Descripcion = sdr["descripcion"].ToString();
                    string imagen = sdr["imagen"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idNumDpto = int.Parse(sdr["idNumDpto"].ToString());

                    Encomienda encomienda = new Encomienda(id, numDpto, Destinatario, fecha, Hora, Descripcion, imagen, estado, idCond, idNumDpto);

                    alEncomiendas.Add(encomienda);
                }
                con.Close();
            }
        }
        public static void ObtenerDatosEncomiendaHistorial(int idCond)
        {
            alEncomiendas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.id_Cond, E.numDpto FROM encomienda E JOIN estadoEncomienda EE ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id where estado = 2 and E.id_Cond = " + idCond + " ORDER BY fecha DESC,hora DESC";
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
                    string Destinatario = dt.Rows[fila][2].ToString();
                    DateTime fecha = DateTime.Parse(dt.Rows[fila][3].ToString());
                    TimeSpan Hora = TimeSpan.Parse(dt.Rows[fila][4].ToString());
                    string Descripcion = dt.Rows[fila][5].ToString();
                    string imagen = dt.Rows[fila][6].ToString();
                    string estado = dt.Rows[fila][7].ToString();
                    int idNumDpto = int.Parse(dt.Rows[fila][8].ToString());

                    Encomienda encomienda = new Encomienda(id, numDpto, Destinatario, fecha, Hora, Descripcion, imagen, estado, idCond, idNumDpto);

                    alEncomiendas.Add(encomienda);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static bool ModificarEncomienda(string id, int idCond, string numDpto, string destinatario, string descripcion, string imagen, string estadoE)
        {
            bool estado = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_modificar_encomienda @id = " + id + ", @idCond= " + idCond + ", @numDpto = " + numDpto + ", @destinatario= '" + destinatario + "', @descripcion= '" + descripcion + "', @imagen= '" + imagen + "', @estado= " + estadoE + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                ObtenerDatosEncomiendaTOP(idCond);
                ObtenerDatosEncomiendasP(idCond);
                ObtenerDatosEncomiendaHistorial(idCond);

                estado = true;
            }
            catch (Exception)
            {

            }
            return estado;
        }
        public static Encomienda BuscarEncomienda(int id, int idCond)
        {

            Encomienda encomienda = null;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "SELECT E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.id_Cond, E.numDpto FROM encomienda E JOIN estadoEncomienda EE  ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id WHERE E.id = " + id + " and E.id_Cond = " + idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                string numDpto = dt.Rows[0][1].ToString();
                string Destinatario = dt.Rows[0][2].ToString();
                DateTime fecha = DateTime.Parse(dt.Rows[0][3].ToString());
                TimeSpan Hora = TimeSpan.Parse(dt.Rows[0][4].ToString());
                string Descripcion = dt.Rows[0][5].ToString();
                string imagen = dt.Rows[0][6].ToString();
                string estado = dt.Rows[0][7].ToString();
                int idNumDpto = int.Parse(dt.Rows[0][9].ToString());

                encomienda = new Encomienda(id, numDpto, Destinatario, fecha, Hora, Descripcion, imagen, estado, idCond, idNumDpto);

            }
            catch (Exception)
            {

            }

            return encomienda;
        }
        public static bool BuscarFotoEncomienda(string image, int idCond)
        {
            bool estado = false;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "SELECT E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.id_Cond, E.numDpto FROM encomienda E JOIN estadoEncomienda EE  ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id WHERE E.id_Cond = " + idCond + " and E.imagen = '" + image + "' and imagen <> ''";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                int id = int.Parse(dt.Rows[0][0].ToString());
                string numDpto = dt.Rows[0][1].ToString();
                string Destinatario = dt.Rows[0][2].ToString();
                DateTime fecha = DateTime.Parse(dt.Rows[0][3].ToString());
                TimeSpan Hora = TimeSpan.Parse(dt.Rows[0][4].ToString());
                string Descripcion = dt.Rows[0][5].ToString();
                string imagen = dt.Rows[0][6].ToString();
                string estadoE = dt.Rows[0][7].ToString();
                int idNumDpto = int.Parse(dt.Rows[0][9].ToString());

                estado = true;

            }
            catch (Exception)
            {

            }

            return estado;
        }

    }
}
