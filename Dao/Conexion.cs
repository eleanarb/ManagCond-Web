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
            return "Server = localhost\\SQLEXPRESS01; Database = managcond; Trusted_Connection = True;";   
        }
        public static SqlConnection Open()
        {
            SqlConnection Conn = new SqlConnection("Server = localhost\\SQLEXPRESS01; Database = managcond; Trusted_Connection = True;");
            Conn.Open();
            return Conn;
        }
    }
}
