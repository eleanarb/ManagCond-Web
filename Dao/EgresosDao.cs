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
    public class EgresosDao
    {
        private static readonly List<Egresos> alEgresos = new List<Egresos>();
        private static readonly List<CategoriaEgresos> alCategoriaEgresos = new List<CategoriaEgresos>();
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();

        public static List<Egresos> GetAlObtenerEgresos(int idCategoria, int idCond, int mes, int año)
        {
            ObtenerEgresos(idCategoria, idCond, mes, año);
            return alEgresos;
        }

        public static List<CategoriaEgresos> GetAlObtenerCategoriasEgresos(int idCond, int mes, int año)
        {
            ObtenerCategoriasEgresos(idCond, mes, año);
            return alCategoriaEgresos;
        }
        public static List<CategoriaEgresos> GetAlObtenerCategoriasEgresosT(int idCond)
        {
            ObtenerCategoriasEgresosT(idCond);
            return alCategoriaEgresos;
        }
        public static int ObtenerTotalCategoriaEgresos(int idCond, int mes, int año)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT count(*) FROM categoriaEgresos ce inner join egresos e ON e.idCategoria = ce.id where MONTH(e.fecha) = " + mes + " AND YEAR(e.fecha) = " + año + " AND ce.idCond = " + idCond + "";
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
        public static int ObtenerTotalCategoriaEgresosT(int idCond)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT COUNT(*) FROM categoriaEgresos  WHERE idCond = " + idCond + "";
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
        public static void ObtenerEgresos(int idCategoria, int idCond, int mes, int año)
        {
            alEgresos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT e.id, p.id, p.nombre, e.descripcion, ce.descripcion, e.fecha, e.monto, e.estado, e.documentoCobro, e.comprobante, e.idCond FROM egresos e INNER JOIN proveedores p ON e.idProveedor = p.id INNER JOIN categoriaEgresos ce ON e.idCategoria = ce.id WHERE ce.id = '" + idCategoria + "' AND e.idCond = "+ idCond + " AND MONTH(e.fecha) = " + mes + " AND YEAR(e.fecha) = " + año + "";
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
                    int idProveedor = int.Parse(dt.Rows[fila][1].ToString());
                    String proveedor = dt.Rows[fila][2].ToString();
                    String descripcion = dt.Rows[fila][3].ToString();
                    String categoria = dt.Rows[fila][4].ToString();
                    DateTime fecha = DateTime.Parse(dt.Rows[fila][5].ToString());
                    int monto = int.Parse(dt.Rows[fila][6].ToString());
                    int estado = int.Parse(dt.Rows[fila][7].ToString());
                    String documentoCobro = dt.Rows[fila][8].ToString();
                    String comprobante = dt.Rows[fila][9].ToString();
                    string estado2 = "";

                    if(estado == 1)
                    {
                        estado2 = "Pendiente";
                    }else if(estado == 2)
                    {
                        estado2 = "Pagado";
                    }

                    Egresos egresos = new Egresos(id, idProveedor, proveedor, descripcion, categoria, fecha, monto, estado2, documentoCobro, comprobante, idCond);

                    alEgresos.Add(egresos);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }

        public static void ObtenerCategoriasEgresos(int idCondominio, int mes, int año)
        {
            alCategoriaEgresos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT ce.id, ce.descripcion FROM categoriaEgresos ce INNER JOIN egresos e ON ce.id = e.idCategoria WHERE ce.idCond = '" + idCondominio + "' AND MONTH(e.fecha) = " + mes + " AND YEAR(e.fecha) = " + año + " GROUP BY ce.id, ce.descripcion  ";
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
                    String descripcion = dt.Rows[fila][1].ToString();;

     

                    CategoriaEgresos categoriaEgresos = new CategoriaEgresos(id, descripcion, idCondominio);

                    alCategoriaEgresos.Add(categoriaEgresos);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static void ObtenerCategoriasEgresosT(int idCondominio)
        {
            alCategoriaEgresos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT * FROM categoriaEgresos  WHERE idCond ='" + idCondominio + "'  ";
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
                    String descripcion = dt.Rows[fila][1].ToString(); ;



                    CategoriaEgresos categoriaEgresos = new CategoriaEgresos(id, descripcion, idCondominio);

                    alCategoriaEgresos.Add(categoriaEgresos);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
        }
        public static bool AgregarEgreso(int idProveedor, string descripcion, int idCategoria, string fecha, int monto, int estado, string documentoCobro, string comprobante, int idCond)
        {
            bool e = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_agregar_egreso @idProveedor= " + idProveedor + ", @descripcion = '" + descripcion + "', @idCategoria= '" + idCategoria + "', @fecha= '" + fecha + "', @monto = '" + monto + "', @estado= " + estado + ", @documentoCobro = '"+ documentoCobro + "', @comprobante= '"+ comprobante + "' , @idCond = " + idCond + "";

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

        public static bool ModificarEgreso(int id, int idProveedor, string descripcion, int idCategoria, string fecha, int monto, int estado, string documentoCobro, string comprobante)
        {
            bool e = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_modificar_egreso @id = " + id + ", @idProveedor= " + idProveedor + ", @descripcion = '" + descripcion + "', @idCategoria= '" + idCategoria + "', @fecha= '" + fecha + "', @monto = '" + monto + "', @estado= " + estado + ", @documentoCobro = '"+ documentoCobro + "', @comprobante = '"+ comprobante + "' ";

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

        public static bool EliminarEgreso(int id)
        {
            bool e = false;

            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "EXEC sp_eliminar_egreso @id = " + id + " ";

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
        public static Egresos BuscarEgreso(int id, int idCond)
        {

            Egresos egresos = null;
            try
            {
                Conexion c = new Conexion();
                string sCnn = c.Conectar();

                string sSel = "SELECT e.id, p.id, p.nombre, e.descripcion, ce.descripcion, e.fecha, e.monto, e.estado, e.documentoCobro, e.comprobante, e.idCond FROM egresos E INNER JOIN proveedores p ON e.idProveedor = p.id INNER JOIN categoriaEgresos ce ON e.idCategoria = ce.id WHERE E.id = " + id + " and E.idCond = " + idCond + "";

                SqlDataAdapter da;
                DataTable dt = new DataTable();

                da = new SqlDataAdapter(sSel, sCnn);
                da.Fill(dt);

                int idProveedor = int.Parse(dt.Rows[0][1].ToString());
                String proveedor = dt.Rows[0][2].ToString();
                String descripcion = dt.Rows[0][3].ToString();
                String categoria = dt.Rows[0][4].ToString();
                DateTime fecha = DateTime.Parse(dt.Rows[0][5].ToString());
                int monto = int.Parse(dt.Rows[0][6].ToString());
                int estado = int.Parse(dt.Rows[0][7].ToString());
                String documentoCobro = dt.Rows[0][8].ToString();
                String comprobante = dt.Rows[0][9].ToString();
                string estado2 = "";

                if (estado == 1)
                {
                    estado2 = "Pendiente";
                }
                else if (estado == 2)
                {
                    estado2 = "Pagado";
                }

               egresos = new Egresos(id, idProveedor, proveedor, descripcion, categoria, fecha, monto, estado2, documentoCobro, comprobante, idCond);

            }
            catch (Exception)
            {

            }

            return egresos;
        }
        public static bool BuscarDocumentoCobro(string documento, int idCond)
        {
            bool estado = false;
            alEgresos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT e.id, p.id, p.nombre, e.descripcion, ce.descripcion, e.fecha, e.monto, e.estado, e.documentoCobro, e.comprobante, e.idCond FROM egresos e INNER JOIN proveedores p ON e.idProveedor = p.id INNER JOIN categoriaEgresos ce ON e.idCategoria = ce.id WHERE e.comprobante = '" + documento +"' AND idCond = "+ idCond + " AND e.comprobante <> ''";
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
                    int idProveedor = int.Parse(dt.Rows[fila][1].ToString());
                    String proveedor = dt.Rows[fila][2].ToString();
                    String descripcion = dt.Rows[fila][3].ToString();
                    String categoria = dt.Rows[fila][4].ToString();
                    DateTime fecha = DateTime.Parse(dt.Rows[fila][5].ToString());
                    int monto = int.Parse(dt.Rows[fila][6].ToString());
                    int estadoE = int.Parse(dt.Rows[fila][7].ToString());
                    String documentoCobro = dt.Rows[fila][8].ToString();
                    String comprobante = dt.Rows[fila][9].ToString();
                    string estado2 = "";

                    if (estadoE == 1)
                    {
                        estado2 = "Pendiente";
                    }
                    else if (estadoE == 2)
                    {
                        estado2 = "Pagado";
                    }

                    Egresos egresos = new Egresos(id, idProveedor, proveedor, descripcion, categoria, fecha, monto, estado2, documentoCobro, comprobante, idCond);

                    alEgresos.Add(egresos);
                    estado = true;
                }
            }
            catch (Exception)
            {

            }

            return estado;
        }
        public static bool BuscarComprobante(string documento, int idCond)
        {
            bool estado = false;
            alEgresos.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            string sSel = "SELECT e.id, p.id, p.nombre, e.descripcion, ce.descripcion, e.fecha, e.monto, e.estado, e.documentoCobro, e.comprobante, e.idCond FROM egresos e INNER JOIN proveedores p ON e.idProveedor = p.id INNER JOIN categoriaEgresos ce ON e.idCategoria = ce.id WHERE e.comprobante = '" + documento + "' AND idCond = " + idCond + " AND e.comprobante <> ''";
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
                    int idProveedor = int.Parse(dt.Rows[fila][1].ToString());
                    String proveedor = dt.Rows[fila][2].ToString();
                    String descripcion = dt.Rows[fila][3].ToString();
                    String categoria = dt.Rows[fila][4].ToString();
                    DateTime fecha = DateTime.Parse(dt.Rows[fila][5].ToString());
                    int monto = int.Parse(dt.Rows[fila][6].ToString());
                    int estadoE = int.Parse(dt.Rows[fila][7].ToString());
                    String documentoCobro = dt.Rows[fila][8].ToString();
                    String comprobante = dt.Rows[fila][9].ToString();
                    string estado2 = "";

                    if (estadoE == 1)
                    {
                        estado2 = "Pendiente";
                    }
                    else if (estadoE == 2)
                    {
                        estado2 = "Pagado";
                    }

                    Egresos egresos = new Egresos(id, idProveedor, proveedor, descripcion, categoria, fecha, monto, estado2, documentoCobro, comprobante, idCond);

                    alEgresos.Add(egresos);
                    estado = true;
                }
            }
            catch (Exception)
            {

            }

            return estado;
        }
    }
}

