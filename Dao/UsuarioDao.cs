﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;

namespace Dao
{
    public class UsuarioDao
    {
        private static List<Usuario> alUsuarios = new List<Usuario>();
        public static List<Usuario> GetAlUsuarios()
        {
            return alUsuarios;
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
                    String fechaNac = dt.Rows[fila][4].ToString();
                    String numDpto = dt.Rows[fila][5].ToString();
                    String correo = dt.Rows[fila][6].ToString();
                    String clave = dt.Rows[fila][7].ToString();
                    String telefono = dt.Rows[fila][8].ToString();
                    int cargo = int.Parse(dt.Rows[fila][9].ToString());
                    int propietario = int.Parse(dt.Rows[fila][10].ToString());
                    int tipoUsuario = int.Parse(dt.Rows[fila][11].ToString());
                    int activo = int.Parse(dt.Rows[fila][12].ToString());

                    Usuario usuario = new Usuario(rut, idCond, nombres, apellidos, fechaNac, numDpto, correo, clave, telefono, cargo, propietario, tipoUsuario, activo);

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
                string fechaNac = dt.Rows[0][4].ToString();
                string numDpto = dt.Rows[0][5].ToString();
                string telefono = dt.Rows[0][8].ToString();
                int cargo = Convert.ToInt32(dt.Rows[0][9]);
                int propietario = Convert.ToInt32(dt.Rows[0][10]);
                int tipoUsuario = Convert.ToInt32(dt.Rows[0][11]);
                int activo = Convert.ToInt32(dt.Rows[0][12]);


                usuario = new Usuario(rut, idCond, nombres, apellidos, fechaNac, numDpto, correo, clave, telefono, cargo, propietario, tipoUsuario, activo);
            }
            catch (Exception)
            {

            }
            return usuario;
        }

    }
}