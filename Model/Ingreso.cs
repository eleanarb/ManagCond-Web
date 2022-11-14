using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Ingreso
    {
        public int id;
        private string nombre;
        private string comentario;
        private int monto;
        private int mes;
        private int año;
        private DateTime fecha;
        private string documento;
        private int idCond;

        public Ingreso(int id, string nombre, string comentario, int monto, int mes, int año, DateTime fecha, string documento, int idCond)
        {
            this.id = id;
            this.nombre = nombre;
            this.comentario = comentario;
            this.monto = monto;
            this.mes = mes;
            this.año = año;
            this.fecha = fecha;
            this.documento = documento;
            this.idCond = idCond;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Comentario { get => comentario; set => comentario = value; }
        public int Monto { get => monto; set => monto = value; }
        public int Mes { get => mes; set => mes = value; }
        public int Año { get => año; set => año = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public string Documento { get => documento; set => documento = value; }
        public int IdCond { get => idCond; set => idCond = value; }
    }
}
