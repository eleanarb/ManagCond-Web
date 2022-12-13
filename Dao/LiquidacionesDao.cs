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
    public class LiquidacionesDao
    {
        private static readonly List<Liquidacion> alLiquidaciones = new List<Liquidacion>();
        private static readonly Conexion con = new Conexion();
        private static readonly string conBD = con.Conectar();
        public static List<Liquidacion> GetAlLiquidaciones(int mes, int año, int idCond, string trabajador)
        {
            ObtenerDatosLiquidaciones(mes, año, idCond, trabajador);
            return alLiquidaciones;
        }
        public static int ObtenerTotalLiquidaciones(int mes, int año, int idCond, string trabajador)
        {
            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            int totalRespuestas = 0;

            string sSel = "SELECT count(*) FROM liquidacion L INNER JOIN contrato C ON L.idContrato = C.id INNER JOIN usuario u ON u.rut = c.rutTrabajador WHERE u.id_cond = " + idCond + " AND MONTH(l.fecha) = " + mes + " AND YEAR(l.fecha) = " + año + " " + trabajador + " ";
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
        public static void ObtenerDatosLiquidaciones(int mes, int año, int idCond, string trabajador)
        {
            alLiquidaciones.Clear();
            string strSql = String.Format("SELECT L.id, L.fecha, CONCAT(u.nombres, ' ', U.apellidos) AS trabajador, L.otrosIngresos, L.totalRemuneracion, L.totalHaberes, L.cotizacionPrevisional, L.cotizacionSalud, L.totalDescuentoPrevisionales, L.otrosDescuentos, L.diasNoTrabajados, L.descuentosDiasNoTrabajados, L.saldoLiquido from liquidacion L INNER JOIN contrato C ON L.idContrato = C.id INNER JOIN usuario u ON u.rut = c.rutTrabajador WHERE u.id_cond = " + idCond + " AND MONTH(l.fecha) = " + mes + " AND YEAR(l.fecha) = " + año + " " + trabajador + " ");

            using (SqlConnection con = new SqlConnection(conBD))
            {
                SqlCommand cmd = new SqlCommand(strSql, con) { CommandType = CommandType.Text };
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                while (sdr.Read())
                {
                    int id = int.Parse(sdr["id"].ToString());
                    DateTime fecha = DateTime.Parse(sdr["fecha"].ToString());
                    string rutTrabajador = sdr["trabajador"].ToString();
                    int otrosIngresos = int.Parse(sdr["otrosIngresos"].ToString());
                    int totalRemuneracion = int.Parse(sdr["totalRemuneracion"].ToString());
                    int totalHaberes = int.Parse(sdr["totalHaberes"].ToString());
                    int cotizacionPrevisional = int.Parse(sdr["cotizacionPrevisional"].ToString());
                    int cotizacionSalud = int.Parse(sdr["cotizacionSalud"].ToString());
                    int totalDescuentosPrevisionales = int.Parse(sdr["totalDescuentoPrevisionales"].ToString());
                    int otrosDescuentos = int.Parse(sdr["otrosDescuentos"].ToString());
                    int diasNoTrabajados = int.Parse(sdr["diasNoTrabajados"].ToString());
                    int descuentosDiasNoTrabajados = int.Parse(sdr["descuentosDiasNoTrabajados"].ToString());
                    int saldoLiquido = int.Parse(sdr["saldoLiquido"].ToString());

                    Liquidacion liquidaciones = new Liquidacion(id, fecha, rutTrabajador, otrosIngresos, totalRemuneracion, totalHaberes, cotizacionPrevisional, cotizacionSalud, totalDescuentosPrevisionales, otrosDescuentos, diasNoTrabajados, descuentosDiasNoTrabajados, saldoLiquido);

                    alLiquidaciones.Add(liquidaciones);
                }
                con.Close();
            }
        }
        public static bool AgregarContrato(string rutTrabajador, int sueldoBase, int horasSemanales, int diasSemanales, int idTipoContrato, string fechaInicio, int asignacionMovilizacion, int asignacionColacion, int valorHoraAdicional, string afp, string previsionSalud, string nombreDireccion, int idComuna, string nombreCuenta, string rut, string banco, string numCuenta, string tipoPago, string tipoCuenta)
        {
            bool estado = false;

            string sCnn;

            if (rutTrabajador != null && sueldoBase != 0 && horasSemanales != 0 && diasSemanales != 0 && idTipoContrato != 0 && fechaInicio != null && valorHoraAdicional != 0 && afp != null && previsionSalud != null && nombreDireccion != null && idComuna != 0 && nombreCuenta != null && rut != null && banco != null && numCuenta != null && tipoPago != null && tipoCuenta != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_contrato @rutTrabajador = '" + rutTrabajador + "',  @sueldoBase = " + sueldoBase + ", @horasSemanales = " + horasSemanales + ", @diasSemanales = " + diasSemanales + ", @idTipoContrato = " + idTipoContrato + ", @fechaInicio = '" + fechaInicio + "', @asignacionMovilizacion = " + asignacionMovilizacion + ", @asignacionColacion = " + asignacionColacion + ", @valorHoraAdicional = " + valorHoraAdicional + ", @afp = '" + afp + "', @previsionSalud = '" + previsionSalud + "', @nombreDireccion = '" + nombreDireccion + "', @idComuna = " + idComuna + ", @nombreCuenta = '" + nombreCuenta + "', @rut = '" + rut + "', @banco = '" + banco + "', @numCuenta = '" + numCuenta + "', @tipoPago = '" + tipoPago + "', @tipoCuenta = '" + tipoCuenta + "'";

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
        public static bool AgregarTrabajador(string rut, int idCond, string nombres, string apellidos, string fechaNac, string correo, string telefono, int cargo)
        {
            bool estado = false;

            string sCnn;

            if (rut != null && idCond != 0 && nombres != null && apellidos != null && fechaNac != null && correo != null && telefono != null && cargo != 0)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_trabajador @rut = '" + rut + "', @idCond = " + idCond + ", @nombres = '" + nombres + "', @apellidos = '" + apellidos + "', @fechaNac = '" + fechaNac + "', @correo = '" + correo + "', @telefono = '" + telefono + "', @cargo = " + cargo + "";

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
        public static bool AgregarLiquidacion(string rut, int horasExtras, int bonos, int diasNoTrabajados, int otrosDescuentos)
        {
            bool estado = false;

            string sCnn;

            if (rut != null)
            {
                try
                {
                    Conexion c = new Conexion();
                    sCnn = c.Conectar();
                    string sSel = "EXEC sp_agregar_liquidacion @rutTrabajador = '" + rut + "', @horasExtras = " + horasExtras + ", @bonos = " + bonos + ", @diasNoTrabajados = " + diasNoTrabajados + ", @otrosDescuentos = " + otrosDescuentos + "";

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
    }
}