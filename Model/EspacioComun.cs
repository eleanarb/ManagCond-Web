using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class EspacioComun
    {
        private int id;
        private string nombre;
        private string descripcion;
        private int monto;
        private int idCond;

        public EspacioComun(int id, string nombre, string descripcion, int monto, int idCond)
        {
            this.Id = id;
            this.Nombre = nombre;
            this.Descripcion = descripcion;
            this.Monto = monto;
            this.IdCond = idCond;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public int Monto { get => monto; set => monto = value; }
        public int IdCond { get => idCond; set => idCond = value; }
    }
}
