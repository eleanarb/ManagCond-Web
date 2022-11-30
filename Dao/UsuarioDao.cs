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
    public class UsuarioDao
    {
        private static readonly List<Usuario> alUsuarios = new List<Usuario>();
        private static readonly List<Usuario> alResidente = new List<Usuario>();
        public static List<Usuario> GetAlUsuarios()
        {
            return alUsuarios;
        }

        public static int ObtenerTotalResidentes(int idCondominio)
        {
            alResidente.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalResidentes = 0;

            string sSel = "SELECT count(*) FROM usuario where tipoUsuario = 3 and id_cond = '" + idCondominio + "' ";
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

                    totalResidentes = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return totalResidentes;
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

        public static Usuario ObtenerDatosUsuario(string rutU)
        {
            alUsuarios.Clear();
            Usuario usuario = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM usuario where rut = '" + rutU + "'";
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

                    usuario = new Usuario(rut, idCond, nombres, apellidos, fechaNac, numDpto, correo, clave, telefono, cargo, rutPropietario, nombrePropietario, correoPropietario, telefonoPropietario, tipoUsuario, activo);

                }
            }
            catch (Exception)
            {

            }
            return usuario;
        }

        public static Usuario ObtenerDatosUsuarioCorreo(string correoU)
        {
            alUsuarios.Clear();
            Usuario usuario = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM usuario where correo = '" + correoU + "'";
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

                    usuario = new Usuario(rut, idCond, nombres, apellidos, fechaNac, numDpto, correo, clave, telefono, cargo, rutPropietario, nombrePropietario, correoPropietario, telefonoPropietario, tipoUsuario, activo);

                }
            }
            catch (Exception)
            {

            }
            return usuario;
        }

        public static Usuario Login(String correo, String clave)
        {
            Usuario usuario = null;
            try
            {
                Conexion c = new Conexion();
                SqlConnection sCnn = new SqlConnection(c.Conectar());

                SqlCommand sSel = new SqlCommand("SELECT * FROM usuario WHERE correo = @correo and clave = @clave", sCnn);
                sSel.Parameters.AddWithValue("@correo", correo);
                sSel.Parameters.AddWithValue("@clave", clave);


                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel);
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

        public static bool ModificarPerfil(string rut, string correo, string telefono)
        {
            bool estado = false;

            string sCnn;

            if (correo != null && telefono != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_modificar_perfil @rut = '" + rut + "', @correo = '" + correo + "', @telefono = '" + telefono + "'";

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

        public static int VerificarClave(string rut, string clave)
        {
            alUsuarios.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int resultado = 0;

            string sSel = "SELECT count(*) FROM usuario where rut = '" + rut + "' and clave = '" + clave + "' ";
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

                    resultado = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return resultado;
        }

        public static bool CambiarClave(string rut, string claveN)
        {
            bool estado = false;

            string sCnn;

            if (rut != null && claveN != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_cambiar_clave @rut = '" + rut + "', @claveN = '" + claveN + "'  ";

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

        public static bool ActualizarClave(string rut, string claveA, string claveN)
        {
            bool estado = false;

            string sCnn;

            if (rut != null && claveA != null && claveN != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXECUTE sp_actualizar_clave @rut = '" + rut + "', @claveA = '" + claveA + "', @claveN = '" + claveN + "'  ";

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

        public static int BuscarUsuario(string correo)
        {
            alUsuarios.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int resultado = 0;

            string sSel = "SELECT count(*) FROM usuario where correo = '" + correo + "' ";
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

                    resultado = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return resultado;
        }
    }
}
