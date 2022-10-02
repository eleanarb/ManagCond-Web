using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dao
{
    class Conexion
    {
        public string Conectar()
        {
            return "Server=localhost\\SQLEXPRESS01;Database=managcond;Trusted_Connection=True;";
            
        }
    }
}
