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

        public static List<Residente> GetAlResidente()
        {
            ObtenerDatosResidente();
            return alResidente;
        }
        public static void ObtenerDatosResidente()
        {
            alResidente.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT D.numDpto, U.nombres, U.apellidos, D.numEstac as 'Estacionamiento', U.rut, U.telefono, U.correo, U.rutPropietario, U.nombrePropietario, U.telefonoPropietario, U.correoPropietario, U.id_cond  FROM usuario U JOIN departamento D ON U.numDpto = D.id WHERE U.tipoUsuario = 3 ORDER BY U.numDpto ASC";
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
                    String numDpto = dt.Rows[fila][0].ToString();
                    String nombresResidente = dt.Rows[fila][1].ToString();
                    String apellidosResidente = dt.Rows[fila][2].ToString();
                    String estacinamiento = dt.Rows[fila][3].ToString();
                    String rutResidente = dt.Rows[fila][4].ToString();
                    String telefonoResidente = dt.Rows[fila][5].ToString();
                    String correoResidente = dt.Rows[fila][6].ToString();
                    String rutPropietario = dt.Rows[fila][7].ToString();
                    String nombrePropietario = dt.Rows[fila][8].ToString();
                    String telefonoPropietario = dt.Rows[fila][9].ToString();
                    String correoPropietario = dt.Rows[fila][10].ToString();
                    int idCond = int.Parse(dt.Rows[fila][11].ToString());

                    Residente residente = new Residente(rutResidente, nombresResidente, apellidosResidente, numDpto, estacinamiento, telefonoResidente, correoResidente, rutPropietario, nombrePropietario, telefonoPropietario, correoPropietario, idCond);

                    alResidente.Add(residente);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
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
    }
}
