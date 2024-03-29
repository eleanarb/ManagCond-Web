﻿using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dao
{
    public class EspacioComunDao
    {
        private static readonly List<EspacioComun> alEspacioComun= new List<EspacioComun>();
        private static readonly List<RangoHorario> alRangoHorario= new List<RangoHorario>();
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        public static List<EspacioComun> GetAlEspacioComunes(int idCond)
        {
            ObtenerEspacioComunes(idCond);
            return alEspacioComun;
        } 
        public static List<RangoHorario> GetAlRangoHorario(int id, int idCond)
        {
            ObtenerRagonHorario(id, idCond);
            return alRangoHorario;
        }
        public static int ObtenerTotalEspacioComunes(int idCond)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT COUNT(*) FROM espaciosComunes EC JOIN rangoEspacioComun RE ON EC.id = RE.idEspacioComun where EC.id_Cond = "+ idCond +"";
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
        public static void ObtenerEspacioComunes(int idCond)
        {
            alEspacioComun.Clear();
            string strSql = String.Format("SELECT * FROM espaciosComunes where id_Cond = {0}", idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    string nombre = sdr["nombre"].ToString();
                    string descripcion = sdr["descripcion"].ToString();
                    int monto = int.Parse(sdr["monto"].ToString());

                    EspacioComun espacioComun = new EspacioComun(id, nombre, descripcion, monto, idCond);

                    alEspacioComun.Add(espacioComun);
                }
                con.Close();
            }
        }
        public static void ObtenerRagonHorario(int idEspacioComun,int idCond)
        {
            alRangoHorario.Clear();
            string strSql = String.Format("SELECT EC.id, EC.nombre, EC.descripcion, EC.monto, RE.rango as 'rangoHorario',  RE.id AS 'idRE' FROM espaciosComunes EC JOIN rangoEspacioComun RE ON EC.id = RE.idEspacioComun where EC.id = {0} AND  EC.id_Cond = {1}", idEspacioComun, idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["idRE"].ToString());
                    string rangoHora = sdr["rangoHorario"].ToString();

                    RangoHorario rangoHorario = new RangoHorario(id, idEspacioComun, rangoHora);

                    alRangoHorario.Add(rangoHorario);
                }
                con.Close();
            }
        }
        public static int ObtenerTotalRangoHorario(int id,int idCond)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT EC.id, EC.nombre, EC.descripcion, EC.monto, RE.rango as 'rangoHorario' FROM espaciosComunes EC JOIN rangoEspacioComun RE ON EC.id = RE.idEspacioComun where EC.id = "+ id +" AND  EC.id_Cond = "+ idCond +"";
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
        public static bool AgregarEspacioComun(string nombre, string descripcion, int monto, int idCond)
        {
            bool estado = false;

            string sCnn;

            if (nombre != null && descripcion != null && idCond != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_espacioComun @nombre = '"+ nombre + "', @descripcion = '"+ descripcion + "', @monto = "+ monto + ", @idCond = "+ idCond + "";

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
        public static bool ModificarEspacioComun(int id, string nombre, string descripcion, int monto, int idCond)
        {
            bool estado = false;

            if (id != 0 && nombre != null && descripcion != null && idCond != 0)
            {

                try
                {
                    Conexion c = new Conexion();
                    string sCnn = c.Conectar();

                    string sSel = "EXEC sp_modificar_espacioComun @id = "+ id + ", @nombre = '"+ nombre + "', @descripcion = '"+ descripcion + "', @monto = "+ monto + ", @idCond = "+ idCond + "";

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
        public static bool AgregarRangoHorario(int idEspacioComun, string rangoHorario)
        {
            bool estado = false;

            string sCnn;

            if (idEspacioComun != 0 && rangoHorario != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_rangoHorario @idEspacioComun = " + idEspacioComun + ", @rangoHorario = '" + rangoHorario + "'";

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
        public static bool ModificarRangoHorario(int id, string rangoHorario)
        {
            bool estado = false;

            if (id != 0 && rangoHorario != null)
            {

                try
                {
                    Conexion c = new Conexion();
                    string sCnn = c.Conectar();

                    string sSel = "EXEC sp_modificar_rangoHorario @id = " + id + ", @rangoHorario = '" + rangoHorario + "'";

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
        public static EspacioComun BuscarEspacioComun(int id, int idCond)
        {

            EspacioComun espacioComun = null;
            alEspacioComun.Clear();
            string strSql = String.Format("SELECT * FROM espaciosComunes where id= {0} AND id_Cond = {1}", id, idCond);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    string nombre = sdr["nombre"].ToString();
                    string descripcion = sdr["descripcion"].ToString();
                    int monto = int.Parse(sdr["monto"].ToString());

                    espacioComun = new EspacioComun(id, nombre, descripcion, monto, idCond);

                    alEspacioComun.Add(espacioComun);
                }
                con.Close();
            };
            return espacioComun;
        }
        public static bool EliminaEspacioComun(int id)
        {
            bool estado = true;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();


                string sSel = "EXEC sp_eliminar_espacioComun @id = " + id + " ";

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
        public static bool EliminaRangoHorario(int id)
        {
            bool estado = true;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();


                string sSel = "EXEC sp_eliminar_rangoHorario @id = " + id + " ";

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
        public static RangoHorario BuscarRangoHorario(int id)
        {

            RangoHorario rangoHorario = null;
            alEspacioComun.Clear();
            string strSql = String.Format("select * from rangoEspacioComun where id = {0}", id);

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int idEspacioComun = int.Parse(sdr["idEspacioComun"].ToString());
                    string rangoHora = sdr["rangoHorario"].ToString();

                    rangoHorario = new RangoHorario(id, idEspacioComun, rangoHora);

                    alRangoHorario.Add(rangoHorario);
                }
                con.Close();
            };
            return rangoHorario;
        }
    }
}
