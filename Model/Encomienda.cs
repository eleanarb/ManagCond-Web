using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Encomienda
    {
        private int id;
        private string numDpto;
        private string destinatario;
        private DateTime fecha;
        private TimeSpan hora;
        private string descripcion;
        private string imagen;
        private int estado;

        public Encomienda(int id, string numDpto, string destinatario, DateTime fecha, TimeSpan hora, string descripcion, string imagen, int estado)
        {
            this.Id = id;
            this.NumDpto = numDpto;
            this.Destinatario = destinatario;
            this.Fecha = fecha;
            this.Hora = hora;
            this.Descripcion = descripcion;
            this.Imagen = imagen;
            this.Estado = estado;
        }

        public int Id { get => id; set => id = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public string Destinatario { get => destinatario; set => destinatario = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public TimeSpan Hora { get => hora; set => hora = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public string Imagen { get => imagen; set => imagen = value; }
        public int Estado { get => estado; set => estado = value; }
    }
}
