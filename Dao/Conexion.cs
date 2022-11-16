using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Dao
{
    public class Conexion
    {
        public string Conectar()
        {
            return "Server=tcp:managcondserver.database.windows.net,1433;Initial Catalog=managcond;Persist Security Info=False;User ID=Pegazus;Password=Bala7821@#;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
        }
        public static SqlConnection Open()
        {
            SqlConnection Conn = new SqlConnection("Server=tcp:managcondserver.database.windows.net,1433;Initial Catalog=managcond;Persist Security Info=False;User ID=Pegazus;Password=Bala7821@#;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            Conn.Open();
            return Conn;
        }
    }
}
