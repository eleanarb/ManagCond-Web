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
        private string estado;
        private int idCond;
        private int idNumDpto;
        private string recepcion;

        public Encomienda(int id, string numDpto, string destinatario, DateTime fecha, TimeSpan hora, string descripcion, string imagen, string estado, int idCond, int idNumDpto, string recepcion)
        {
            this.id = id;
            this.numDpto = numDpto;
            this.destinatario = destinatario;
            this.fecha = fecha;
            this.hora = hora;
            this.descripcion = descripcion;
            this.imagen = imagen;
            this.estado = estado;
            this.idCond = idCond;
            this.idNumDpto = idNumDpto;
            this.recepcion = recepcion;
        }

        public int Id { get => id; set => id = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public string Destinatario { get => destinatario; set => destinatario = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public TimeSpan Hora { get => hora; set => hora = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public string Imagen { get => imagen; set => imagen = value; }
        public string Estado { get => estado; set => estado = value; }
        public int IdCond { get => idCond; set => idCond = value; }
        public int IdNumDpto { get => idNumDpto; set => idNumDpto = value; }
        public string Recepcion { get => recepcion; set => recepcion = value; }
    }
}
