﻿using System;
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
    public class UsuarioDao
    {
        private static readonly List<Usuario> alUsuarios = new List<Usuario>();
        private static readonly List<Encomienda> alEncomiendas = new List<Encomienda>();
        private static readonly List<Usuario> alResidente = new List<Usuario>();
        public static List<Usuario> GetAlUsuarios()
        {
            return alUsuarios;
        }
        public static List<Encomienda> GetAlEncomiendas()
        {
            ObtenerDatosEncomienda();
            return alEncomiendas;
        }
        public static List<Encomienda> GetAlEncomiendasASC()
        {
            ObtenerDatosEncomiendaASC();
            return alEncomiendas;
        }
        public static List<Usuario> GetAlResidente()
        {
            ObtenerDatosResidente();
            return alResidente;
        }
        public static void ObtenerDatosResidente()
        {
            alResidente.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM usuario where tipoUsuario = 3";
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
                    String rut = dt.Rows[fila][0].ToString();
                    int idCond = int.Parse(dt.Rows[fila][1].ToString());
                    String nombres = dt.Rows[fila][2].ToString();
                    String apellidos = dt.Rows[fila][3].ToString();
                    DateTime fechaNac = Convert.ToDateTime(dt.Rows[fila][4]);
                    String numDpto = dt.Rows[fila][5].ToString();
                    String correo = dt.Rows[fila][6].ToString();
                    String clave = dt.Rows[fila][7].ToString();
                    String telefono = dt.Rows[fila][8].ToString();
                    int cargo = int.Parse(dt.Rows[fila][9].ToString());
                    String rutPropietario = dt.Rows[fila][10].ToString();
                    String nombrePropietario = dt.Rows[fila][11].ToString();
                    String correoPropietario = dt.Rows[fila][12].ToString();
                    String telefonoPropietario = dt.Rows[fila][13].ToString();
                    int tipoUsuario = int.Parse(dt.Rows[fila][14].ToString());
                    int activo = int.Parse(dt.Rows[fila][15].ToString());

                    Usuario usuario = new Usuario(rut, idCond, nombres, apellidos, fechaNac, numDpto, correo, clave, telefono, cargo, rutPropietario, nombrePropietario, correoPropietario, telefonoPropietario, tipoUsuario, activo);

                    alResidente.Add(usuario);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static bool AgregarEncomienda(string numDpto, string destinatario, string descripcion, string imagen)
        {
            bool estado = false;

            string sCnn;

            if (numDpto != null && destinatario != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_encomienda @numDpto = '" + numDpto + "', @destinatario = '" + destinatario + "', @descripcion = '" + descripcion + "', @imagen= '" + imagen + "'";

                    SqlDataAdapter da;
                    DataTable dt = new DataTable();
                    da = new SqlDataAdapter(sSel, sCnn);
                    da.Fill(dt);

                    ObtenerDatosEncomienda();

                    estado = true;

                }
                catch (Exception)
                {

                }
            }

            return estado;
        }
        public static void ObtenerDatosEncomienda()
        {
            alEncomiendas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM encomienda";
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
                    int estado = int.Parse(dt.Rows[fila][7].ToString());

                    Encomienda encomienda = new Encomienda(id, numDpto, Destinatario, fecha, Hora, Descripcion, imagen, estado);

                    alEncomiendas.Add(encomienda);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static void ObtenerDatosEncomiendaASC()
        {
            alEncomiendas.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT TOP 10 * FROM encomienda ORDER BY fecha ASC";
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
                    int estado = int.Parse(dt.Rows[fila][7].ToString());

                    Encomienda encomienda = new Encomienda(id, numDpto, Destinatario, fecha, Hora, Descripcion, imagen, estado);

                    alEncomiendas.Add(encomienda);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static void ObtenerDatos()
        {
            alUsuarios.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM usuario";
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
                    String rut = dt.Rows[fila][0].ToString();
                    int idCond = int.Parse(dt.Rows[fila][1].ToString());
                    String nombres = dt.Rows[fila][2].ToString();
                    String apellidos = dt.Rows[fila][3].ToString();
                    DateTime fechaNac = Convert.ToDateTime(dt.Rows[fila][4]);
                    String numDpto = dt.Rows[fila][5].ToString();
                    String correo = dt.Rows[fila][6].ToString();
                    String clave = dt.Rows[fila][7].ToString();
                    String telefono = dt.Rows[fila][8].ToString();
                    int cargo = int.Parse(dt.Rows[fila][9].ToString());
                    String rutPropietario = dt.Rows[fila][10].ToString();
                    String nombrePropietario = dt.Rows[fila][11].ToString();
                    String correoPropietario = dt.Rows[fila][12].ToString();
                    String telefonoPropietario = dt.Rows[fila][13].ToString();
                    int tipoUsuario = int.Parse(dt.Rows[fila][14].ToString());
                    int activo = int.Parse(dt.Rows[fila][15].ToString());

                    Usuario usuario = new Usuario(rut, idCond, nombres, apellidos, fechaNac, numDpto, correo, clave, telefono, cargo, rutPropietario, nombrePropietario, correoPropietario, telefonoPropietario, tipoUsuario, activo);

                    alUsuarios.Add(usuario);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static Usuario Login(String correo, String clave)
        {
            Usuario usuario = null;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "SELECT * FROM usuario WHERE correo = '" + correo + "' and clave = '" + clave + "' ";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                string rut = dt.Rows[0][0].ToString();
                int idCond = Convert.ToInt32(dt.Rows[0][1]);
                string nombres = dt.Rows[0][2].ToString();
                string apellidos = dt.Rows[0][3].ToString();
                DateTime fechaNac = Convert.ToDateTime(dt.Rows[0][4]);
                string numDpto = dt.Rows[0][5].ToString();
                string telefono = dt.Rows[0][8].ToString();
                int cargo = Convert.ToInt32(dt.Rows[0][9]);
                string rutPropietario = dt.Rows[0][10].ToString();
                string nombrePropietario = dt.Rows[0][11].ToString();
                string correoPropietario = dt.Rows[0][12].ToString();
                string telefonoPropietario = dt.Rows[0][13].ToString();
                int tipoUsuario = Convert.ToInt32(dt.Rows[0][14]);
                int activo = Convert.ToInt32(dt.Rows[0][15]);


                usuario = new Usuario(rut, idCond, nombres, apellidos, fechaNac, numDpto, correo, clave, telefono, cargo, rutPropietario, nombrePropietario, correoPropietario, telefonoPropietario, tipoUsuario, activo);
            }
            catch (Exception)
            {

            }
            return usuario;
        }
    }
}
