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
        private TimeSpan hora;
        private string descripcion;
        private string imagen;
        private int estado;

        public Encomienda(string numDpto, string destinatario, DateTime fecha, TimeSpan hora, string descripcion, string imagen,int estado)
        {
            this.numDpto = numDpto;
            this.destinatario = destinatario;
            this.fecha = fecha;
            this.hora = hora;
            this.descripcion = descripcion;
            this.imagen = imagen;
            this.estado = estado;
        }

        public string NumDpto { get => numDpto; set => numDpto = value; }
        public string Destinatario { get => destinatario; set => destinatario = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public TimeSpan Hora { get => hora; set => hora = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public string Imagen { get => imagen; set => imagen = value; }
        public int Estado { get => estado; set => estado = value; }

        override
        public string ToString()
        {
            return numDpto + "," + destinatario + "," + fecha + "," + hora + "," + descripcion + "," + imagen+ "," + estado;
        }
    }
}
