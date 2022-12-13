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
    public class BalanceDao
    {
        private static readonly List<Balance> alBalance = new List<Balance>();

        public static Balance ObtenerDatosBalance(int idCondominio, int mes, int año)
        {
            alBalance.Clear();

            Conexion con = new Conexion();
            string sCnn = con.Conectar();

            Balance balance = null;

            string sSel = " SELECT TOP(1) * FROM dbo.balance WHERE idCond = " + idCondominio + "  AND mes = " + mes + " AND año = " + año + "";
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

                    int totalIngresos = int.Parse(dt.Rows[fila][4].ToString());
                    int totalGastoComun = int.Parse(dt.Rows[fila][5].ToString());
                    int totalEgresos = int.Parse(dt.Rows[fila][6].ToString());
                    int totalRemuneraciones = int.Parse(dt.Rows[fila][4].ToString());

                    balance = new Balance(id, mes, año, idCondominio, totalIngresos, totalGastoComun, totalEgresos, totalRemuneraciones, 0);

                    alBalance.Add(balance);
                }
            }
            catch (Exception)
            {
                //Label1.Text = "Error: " + ex.Message;
            }
            return balance;
        }
    }
}
