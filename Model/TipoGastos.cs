using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class TipoGastos
    {
        public int id;
        private string nombre;
        private string descripcion;
        private int monto;
        private int multa; //1 -> No - 2 -> Si
        private int idCond;

        public TipoGastos(int id, string nombre, string descripcion, int monto, int multa, int idCond)
        {
            this.id = id;
            this.nombre = nombre;
            this.descripcion = descripcion;
            this.monto = monto;
            this.multa = multa;
            this.idCond = idCond;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public int Monto { get => monto; set => monto = value; }
        public int Multa { get => multa; set => multa = value; }
        public int IdCond { get => idCond; set => idCond = value; }
    }
}
