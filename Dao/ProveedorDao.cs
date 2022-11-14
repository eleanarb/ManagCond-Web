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
    public class ProveedorDao
    {
        private static readonly List<Proveedor> alProveedores = new List<Proveedor>();
        private static readonly List<MedioPago> alMediosPago = new List<MedioPago>();

        public static List<Proveedor> GetAlObtenerProveedores(int idCondominio)
        {
            ObtenerProveedores(idCondominio);
            return alProveedores;
        }

        public static void ObtenerProveedores(int idCondominio)
        {
            alProveedores.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "select p.id, p.nombre, p.telefono, p.correo, p.idDireccion, d.nombre, c.id, c.nombre, r.id, r.nombre, p.idMedioPago, mp.nombre, mp.rut, mp.banco, mp.tipoCuenta, mp.numCuenta, mp.tipoPago from proveedores p INNER JOIN direccion d ON d.id = p.idDireccion INNER JOIN comuna c ON d.comuna = c.id INNER JOIN region r ON c.region = r.id INNER JOIN mediosPago mp ON p.idMedioPago = mp.id WHERE p.idCond = '" + idCondominio + "' ";
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
                    String nombre = dt.Rows[fila][1].ToString();
                    string telefono = dt.Rows[fila][2].ToString();
                    string correo = dt.Rows[fila][3].ToString();
                    int idDireccion = int.Parse(dt.Rows[fila][4].ToString());
                    string direccion = dt.Rows[fila][5].ToString();
                    int idComuna = int.Parse(dt.Rows[fila][6].ToString());
                    string comuna = dt.Rows[fila][7].ToString();
                    int idRegion = int.Parse(dt.Rows[fila][8].ToString());
                    string region = dt.Rows[fila][9].ToString();
                    int idMedioPago = int.Parse(dt.Rows[fila][10].ToString());
                    String nombreMP = dt.Rows[fila][11].ToString();
                    String rut = dt.Rows[fila][12].ToString();
                    String banco = dt.Rows[fila][13].ToString();
                    String tipoCuenta = dt.Rows[fila][14].ToString();
                    String numCuenta = dt.Rows[fila][15].ToString();
                    String tipoPago = dt.Rows[fila][16].ToString();

                    Proveedor proveedor = new Proveedor(id, nombre, telefono, correo, idDireccion, direccion, idComuna, comuna, idRegion, region, idMedioPago, nombreMP, rut, banco, tipoCuenta, numCuenta, tipoPago, idCondominio);
                    alProveedores.Add(proveedor);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static Proveedor ObtenerDatosProveedor(int idProveedor)
        {
            alProveedores.Clear();
            Proveedor proveedor = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "select p.id, p.nombre, p.telefono, p.correo, p.idDireccion, d.nombre, c.id, c.nombre, r.id, r.nombre, p.idMedioPago, mp.nombre, mp.rut, mp.banco, mp.tipoCuenta, mp.numCuenta, mp.tipoPago, p.idCond from proveedores p INNER JOIN direccion d ON d.id = p.idDireccion INNER JOIN comuna c ON d.comuna = c.id INNER JOIN region r ON c.region = r.id INNER JOIN mediosPago mp ON p.idMedioPago = mp.id WHERE p.id =  '" + idProveedor + "'";
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
                    String nombre = dt.Rows[fila][1].ToString();
                    string telefono = dt.Rows[fila][2].ToString();
                    string correo = dt.Rows[fila][3].ToString();
                    int idDireccion = int.Parse(dt.Rows[fila][4].ToString());
                    string direccion = dt.Rows[fila][5].ToString();
                    int idComuna = int.Parse(dt.Rows[fila][6].ToString());
                    string comuna = dt.Rows[fila][7].ToString();
                    int idRegion = int.Parse(dt.Rows[fila][8].ToString());
                    string region = dt.Rows[fila][9].ToString();
                    int idMedioPago = int.Parse(dt.Rows[fila][10].ToString());
                    String nombreMP = dt.Rows[fila][11].ToString();
                    String rut = dt.Rows[fila][12].ToString();
                    String banco = dt.Rows[fila][13].ToString();
                    String tipoCuenta = dt.Rows[fila][14].ToString();
                    String numCuenta = dt.Rows[fila][15].ToString();
                    String tipoPago = dt.Rows[fila][16].ToString();
                    int idCondominio = int.Parse(dt.Rows[fila][17].ToString());

                    proveedor = new Proveedor(id, nombre, telefono, correo, idDireccion, direccion, idComuna, comuna, idRegion, region, idMedioPago, nombreMP, rut, banco, tipoCuenta, numCuenta, tipoPago, idCondominio);

                }
            }
            catch (Exception)
            {

            }
            return proveedor;
        }

        public static MedioPago ObtenerMedioPago(int idMedioPago)
        {
            alMediosPago.Clear();
            MedioPago medioPago = null;

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM mediosPago where id = '" + idMedioPago + "'";
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
                    String nombre = dt.Rows[fila][1].ToString();
                    String rut = dt.Rows[fila][1].ToString();
                    String banco = dt.Rows[fila][3].ToString();
                    String numCuenta = dt.Rows[fila][4].ToString();
                    String tipoPago = dt.Rows[fila][5].ToString();

                    medioPago = new MedioPago(idMedioPago, nombre, rut, banco, numCuenta, tipoPago);

                }
            }
            catch (Exception)
            {

            }
            return medioPago;
        }
        public static int ObtenerTotalProveedores(int idCondominio)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT count(*) FROM proveedores where idCond ='" + idCondominio + "' ";
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

        public static bool AgregarProveedor(int idCondominio, string nombreP, string telefonoP, string correoP, string direccion, int idComuna, string nombreMP, string rutMP, string banco, string tipoCuenta, string tipoPago, string numCuenta)
        {
            bool e = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_agregar_proveedor @idCondominio = " + idCondominio + ",  @nombreP = '" + nombreP + "', @telefonoP = '" + telefonoP + "', @correoP = '" + correoP + "', @direccion = '" + direccion + "', @idComuna = " + idComuna + ",  @nombreMP = '" + nombreMP + "', @rutMP = '" + rutMP + "', @banco = '" + banco + "', @tipoCuenta = '" + tipoCuenta + "', @tipoPago = '" + tipoPago + "', @numCuenta = '" + numCuenta + "'  ";

                SqlDataAdapter da;
                DataTable dt = new DataTable();
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                e = true;
            }
            catch (Exception)
            {

            }
            return e;
        }

        public static bool ModificarProveedor(int idProveedor, string nombreP, string telefonoP, string correoP, string direccion, int idDireccion, int idComuna, int idMedioPago, string nombreMP, string rutMP, string banco, string tipoCuenta, string tipoPago, string numCuenta)
        {
            bool e = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_modificar_proveedor @idProveedor = " + idProveedor + ",  @nombreP = '" + nombreP + "', @telefonoP = '" + telefonoP + "', @correoP = '" + correoP + "', @direccion = '" + direccion + "', @idDireccion = '" + idDireccion + "', @idComuna = " + idComuna + ", @idMedioPago = " + idMedioPago + ", @nombreMP = '" + nombreMP + "', @rutMP = '" + rutMP + "', @banco = '" + banco + "', @tipoCuenta = '" + tipoCuenta + "', @tipoPago = '" + tipoPago + "', @numCuenta = '" + numCuenta + "'  ";

                SqlDataAdapter da;
                DataTable dt = new DataTable();
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                e = true;
            }
            catch (Exception)
            {

            }
            return e;
        }

        public static bool EliminarProveedor(int id)
        {
            bool e = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_eliminar_proveedor @id = " + id + " ";

                SqlDataAdapter da;
                DataTable dt = new DataTable();
                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                e = true;
            }
            catch (Exception)
            {

            }
            return e;
        }

        public static int ObtenerTotalEgresosProveedor(int id)
        {

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int total = 0;

            string sSel = "select count(*) from proveedores p INNER JOIN egresos e ON e.idProveedor = p.id where p.id = '" + id + "' ";
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
                    total = int.Parse(dt.Rows[fila][0].ToString());

                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return total;
        }
    }
}
