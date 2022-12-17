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
    public class ResidenteDao
    {
        private static readonly List<Residente> alResidente = new List<Residente>();

        public static List<Residente> GetAlResidente(int idCond)
        {
            ObtenerDatosResidente(idCond);
            return alResidente;
        }

        public static List<Residente> GetAlObtenerDatosResidente(int idCond)
        {
            ObtenerDatosResidente(idCond);
            return alResidente;
        }
        public static void ObtenerDatosResidente(int idCond)
        {
            alResidente.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT D.numDpto, U.nombres, U.apellidos, D.numEstac as 'Estacionamiento', U.rut, U.telefono, U.correo, U.rutPropietario, U.nombrePropietario, U.telefonoPropietario, U.correoPropietario, U.id_cond  FROM usuario U JOIN departamento D ON U.numDpto = D.id WHERE U.tipoUsuario = 3 and U.id_Cond = " + idCond + " ORDER BY U.numDpto ASC";
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
                    string numDpto = dt.Rows[fila][0].ToString();
                    string nombresResidente = dt.Rows[fila][1].ToString();
                    string apellidosResidente = dt.Rows[fila][2].ToString();
                    string estacinamiento = dt.Rows[fila][3].ToString();
                    string rutResidente = dt.Rows[fila][4].ToString();
                    string telefonoResidente = dt.Rows[fila][5].ToString();
                    string correoResidente = dt.Rows[fila][6].ToString();
                    string rutPropietario = dt.Rows[fila][7].ToString();
                    string nombrePropietario = dt.Rows[fila][8].ToString();
                    string telefonoPropietario = dt.Rows[fila][9].ToString();
                    string correoPropietario = dt.Rows[fila][10].ToString();

                    Residente residente = new Residente(rutResidente, nombresResidente, apellidosResidente, numDpto, estacinamiento, telefonoResidente, correoResidente, rutPropietario, nombrePropietario, telefonoPropietario, correoPropietario, idCond);

                    alResidente.Add(residente);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static Residente ObtenerDatosResidenteNotifiacion(string idDpto, int idCond)
        {
            alResidente.Clear();
            Residente residente = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT D.numDpto, U.nombres, U.apellidos, D.numEstac as 'Estacionamiento', U.rut, U.telefono, U.correo, U.rutPropietario, U.nombrePropietario, U.telefonoPropietario, U.correoPropietario, U.id_cond  FROM usuario U JOIN departamento D ON U.numDpto = D.id WHERE U.tipoUsuario = 3 and U.id_Cond = " + idCond + " AND U.numDpto=" + idDpto + " ORDER BY U.numDpto ASC";
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
                    string numDpto = dt.Rows[fila][0].ToString();
                    string nombresResidente = dt.Rows[fila][1].ToString();
                    string apellidosResidente = dt.Rows[fila][2].ToString();
                    string estacinamiento = dt.Rows[fila][3].ToString();
                    string rutResidente = dt.Rows[fila][4].ToString();
                    string telefonoResidente = dt.Rows[fila][5].ToString();
                    string correoResidente = dt.Rows[fila][6].ToString();
                    string rutPropietario = dt.Rows[fila][7].ToString();
                    string nombrePropietario = dt.Rows[fila][8].ToString();
                    string telefonoPropietario = dt.Rows[fila][9].ToString();
                    string correoPropietario = dt.Rows[fila][10].ToString();

                    residente = new Residente(rutResidente, nombresResidente, apellidosResidente, numDpto, estacinamiento, telefonoResidente, correoResidente, rutPropietario, nombrePropietario, telefonoPropietario, correoPropietario, idCond);

                    alResidente.Add(residente);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }

            return residente;
        }

        public static int ObtenerTotalResidentes(int idCond)
        {
            alResidente.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalResidentes = 0;

            string sSel = "SELECT count(*) FROM usuario where tipoUsuario = 3 and id_cond = '" + idCond + "' ";
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
    }
}
