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
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        public static List<Encomienda> GetAlEncomiendasTOPR(int numDpto, int idCond)
        {
            ObtenerDatosEncomiendaTOPR(numDpto, idCond);
            return alEncomiendas;
        }
        public static List<Encomienda> ObtenerDatosEncomienda(int idNumDpto, int idCond, int mes, int año)
        {
            alEncomiendas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT E.id, D.numDpto as 'numDpto', E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.recepcion FROM encomienda E JOIN departamento D ON E.numDpto = D.id JOIN estadoEncomienda EE ON E.estado = EE.id WHERE E.numDpto = " + idNumDpto + " AND E.estado = 1 AND E.id_Cond =" + idCond + " AND MONTH(E.fecha)= "+ mes +" AND YEAR(E.fecha)= "+ año + " ORDER BY fecha DESC,hora DESC";
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
                    string destinatario = dt.Rows[fila][2].ToString();
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][3]);
                    TimeSpan hora = TimeSpan.Parse(dt.Rows[fila][4].ToString());
                    string descripcion = dt.Rows[fila][5].ToString();
                    string imagen = dt.Rows[fila][6].ToString();
                    string estado = dt.Rows[fila][7].ToString();
                    string recepcion = dt.Rows[fila][8].ToString();

                    Encomienda encomienda = new Encomienda(id, numDpto, destinatario, fecha, hora, descripcion, imagen, estado, idCond, idNumDpto, recepcion);

                    alEncomiendas.Add(encomienda);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alEncomiendas;
        }
        public static List<Encomienda> ObtenerDatosEncomiendaH(int idNumDpto, int idCond, int mes2, int año2)
        {
            alEncomiendas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT E.id, D.numDpto as 'numDpto', E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.recepcion FROM encomienda E JOIN departamento D ON E.numDpto = D.id JOIN estadoEncomienda EE ON E.estado = EE.id WHERE E.numDpto = " + idNumDpto + " AND E.estado = 2 AND E.id_Cond =" + idCond + " AND MONTH(E.fecha)= " + mes2 + " AND YEAR(E.fecha)= " + año2 + " ORDER BY fecha DESC,hora DESC";
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
                    DateTime fecha = Convert.ToDateTime(dt.Rows[fila][3]);
                    TimeSpan Hora = TimeSpan.Parse(dt.Rows[fila][4].ToString());
                    string Descripcion = dt.Rows[fila][5].ToString();
                    string imagen = dt.Rows[fila][6].ToString();
                    string estado = dt.Rows[fila][7].ToString();
                    string recepcion = dt.Rows[fila][8].ToString();

                    Encomienda encomienda = new Encomienda(id, numDpto, Destinatario, fecha, Hora, Descripcion, imagen, estado, idCond, idNumDpto, recepcion);

                    alEncomiendas.Add(encomienda);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return alEncomiendas;
        }
        public static void ObtenerDatosEncomiendaTOPR(int idNumDpto, int idCond)
        {
            alEncomiendas.Clear();
            string strSql = String.Format("SELECT TOP 10 E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.recepcion FROM encomienda E JOIN estadoEncomienda EE ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id where E.numDpto = {0} and E.id_Cond = {1} ORDER BY fecha DESC,hora DESC", idNumDpto, idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string destinatario = sdr["destinatario"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string descripcion = sdr["descripcion"].ToString();
                    string imagen = sdr["imagen"].ToString();
                    string estado = sdr["estado"].ToString();
                    string recepcion = sdr["recepcion"].ToString();

                    Encomienda encomienda = new Encomienda(id, numDpto, destinatario, fecha, hora, descripcion, imagen, estado, idCond, idNumDpto, recepcion);

                    alEncomiendas.Add(encomienda);
                }
                con.Close();
            }
        }

        //Guardia
        public static List<Encomienda> GetAlEncomiendasTOP(int idCond)
        {
            ObtenerDatosEncomiendaTOP(idCond);
            return alEncomiendas;
        }
        public static List<Encomienda> GetAlEncomiendas(int idCond, string depto, int mes, int año)
        {
            ObtenerDatosEncomiendasP(idCond, depto, mes, año);
            return alEncomiendas;
        }
        public static List<Encomienda> GetAlEncomiendasHistorial(int idCond, string depto2, int mes2, int año2)
        {
            ObtenerDatosEncomiendaHistorial(idCond, depto2, mes2, año2);
            return alEncomiendas;
        }
        public static void ObtenerDatosEncomiendaTOP(int idCond)
        {
            alEncomiendas.Clear();
            string strSql = String.Format("SELECT TOP 10 E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.numDpto as idNumDpto, E.recepcion FROM encomienda E JOIN estadoEncomienda EE ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id where E.id_Cond = {0} ORDER BY fecha DESC,hora DESC", idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string destinatario = sdr["destinatario"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string descripcion = sdr["descripcion"].ToString();
                    string imagen = sdr["imagen"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idNumDpto = int.Parse(sdr["idNumDpto"].ToString());
                    string recepcion = sdr["recepcion"].ToString();

                    Encomienda encomienda = new Encomienda(id, numDpto, destinatario, fecha, hora, descripcion, imagen, estado, idCond, idNumDpto, recepcion);

                    alEncomiendas.Add(encomienda);
                }
                con.Close();
            }
        }
        public static bool AgregarEncomienda(string numDpto, string destinatario, string descripcion, string imagen, int idCond, string recepcion)
        {
            bool estado = false;

            string sCnn;

            if (numDpto != null && destinatario != null && idCond != 0 && recepcion != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_encomienda @numDpto = " + numDpto + ", @destinatario = '" + destinatario + "', @descripcion = '" + descripcion + "', @imagen= '" + imagen + "', @idCond= " + idCond + ", @recepcion= '" + recepcion + "'";

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
        public static void ObtenerDatosEncomiendasP(int idCond, string depto, int mes, int año)
        {
            alEncomiendas.Clear();
            string strSql = String.Format("SELECT E.id, D.numDpto,E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.numDpto as idNumDpto, E.recepcion FROM encomienda E JOIN estadoEncomienda EE ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id where estado = 1 and E.id_Cond= {0} AND MONTH(E.fecha)={1} AND YEAR(E.fecha)={2} " + depto + " ORDER BY fecha DESC,hora DESC", idCond, mes, año);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string destinatario = sdr["destinatario"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string descripcion = sdr["descripcion"].ToString();
                    string imagen = sdr["imagen"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idNumDpto = int.Parse(sdr["idNumDpto"].ToString());
                    string recepcion = sdr["recepcion"].ToString();

                    Encomienda encomienda = new Encomienda(id, numDpto, destinatario, fecha, hora, descripcion, imagen, estado, idCond, idNumDpto, recepcion);

                    alEncomiendas.Add(encomienda);
                }
                con.Close();
            }
        }
        public static void ObtenerDatosEncomiendaHistorial(int idCond, string depto2, int mes2, int año2)
        {
            alEncomiendas.Clear();
            string strSql = String.Format("SELECT E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.numDpto as idNumDpto, E.recepcion FROM encomienda E JOIN estadoEncomienda EE ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id where estado = 2 and E.id_Cond = {0} AND MONTH(E.fecha)={1} AND YEAR(E.fecha)={2} " + depto2 + " ORDER BY fecha DESC,hora DESC", idCond, mes2, año2);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string numDpto = sdr["numDpto"].ToString();
                    string destinatario = sdr["destinatario"].ToString();
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    TimeSpan hora = TimeSpan.Parse(sdr["hora"].ToString());
                    string descripcion = sdr["descripcion"].ToString();
                    string imagen = sdr["imagen"].ToString();
                    string estado = sdr["estado"].ToString();
                    int idNumDpto = int.Parse(sdr["idNumDpto"].ToString());
                    string recepcion = sdr["recepcion"].ToString();

                    Encomienda encomienda = new Encomienda(id, numDpto, destinatario, fecha, hora, descripcion, imagen, estado, idCond, idNumDpto, recepcion);

                    alEncomiendas.Add(encomienda);
                }
                con.Close();
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

                string sSel = "SELECT E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.numDpto, E.recepcion FROM encomienda E JOIN estadoEncomienda EE  ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id WHERE E.id = " + id + " and E.id_Cond = " + idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                string numDpto = dt.Rows[0][1].ToString();
                string destinatario = dt.Rows[0][2].ToString();
                DateTime fecha = DateTime.Parse(dt.Rows[0][3].ToString());
                TimeSpan hora = TimeSpan.Parse(dt.Rows[0][4].ToString());
                string descripcion = dt.Rows[0][5].ToString();
                string imagen = dt.Rows[0][6].ToString();
                string estado = dt.Rows[0][7].ToString();
                int idNumDpto = int.Parse(dt.Rows[0][8].ToString());
                string recepcion = dt.Rows[0][9].ToString();

                encomienda = new Encomienda(id, numDpto, destinatario, fecha, hora, descripcion, imagen, estado, idCond, idNumDpto, recepcion);

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

                string sSel = "SELECT E.id, D.numDpto, E.destinatario, E.fecha, E.hora, E.descripcion, E.imagen, EE.descripcion as 'estado', E.numDpto, E.recepcion FROM encomienda E JOIN estadoEncomienda EE  ON E.estado = EE.Id JOIN departamento D ON E.numDpto = D.id WHERE E.id_Cond = " + idCond + " and E.imagen = '" + image + "' and imagen <> ''";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                int id = int.Parse(dt.Rows[0][0].ToString());
                string numDpto = dt.Rows[0][1].ToString();
                string destinatario = dt.Rows[0][2].ToString();
                DateTime decha = DateTime.Parse(dt.Rows[0][3].ToString());
                TimeSpan hora = TimeSpan.Parse(dt.Rows[0][4].ToString());
                string descripcion = dt.Rows[0][5].ToString();
                string imagen = dt.Rows[0][6].ToString();
                string estadoE = dt.Rows[0][7].ToString();
                int idNumDpto = int.Parse(dt.Rows[0][8].ToString());
                string recepcion = dt.Rows[0][9].ToString();

                estado = true;

            }
            catch (Exception)
            {

            }

            return estado;
        }
        public static bool EliminaEncomienda(int id)
        {
            bool estado = true;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();


                string sSel = "delete from encomienda where id = " + id + "";

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
