using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Encomienda
    {
        private string numDpto;
        private string destinatario;
        private DateTime fecha;
        private string hora;
        private string descripcion;
        private int estado;

        public Encomienda(string numDpto, string destinatario, DateTime fecha, string hora, string descripcion, int estado)
        {
            this.numDpto = numDpto;
            this.destinatario = destinatario;
            this.fecha = fecha;
            this.hora = hora;
            this.descripcion = descripcion;
            this.estado = estado;
        }

        public string NumDpto { get => numDpto; set => numDpto = value; }
        public string Destinatario { get => destinatario; set => destinatario = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public string Hora { get => hora; set => hora = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public int Estado { get => estado; set => estado = value; }

        override
        public string ToString()
        {
            return numDpto + "," + destinatario + "," + fecha + "," + hora + "," + descripcion + "," + estado;
        }
    }
}
