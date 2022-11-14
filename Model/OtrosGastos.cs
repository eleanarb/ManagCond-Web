using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class OtrosGastos
    {
        public int id;
        private int idDepto;
        private string depto;
        private int mes;
        private int año;
        private int idGasto;
        private string gasto;
        private int monto;
        private int cantidad;
        private int total;
        private string descripcion;

        public OtrosGastos(int id, int idDepto, string depto, int mes, int año, int idGasto, string gasto, int monto, int cantidad, int total, string descripcion)
        {
            this.id = id;
            this.idDepto = idDepto;
            this.depto = depto;
            this.mes = mes;
            this.año = año;
            this.idGasto = idGasto;
            this.gasto = gasto;
            this.monto = monto;
            this.cantidad = cantidad;
            this.total = total;
            this.descripcion = descripcion;
        }

        public int Id { get => id; set => id = value; }
        public int IdDepto { get => idDepto; set => idDepto = value; }
        public string Depto { get => depto; set => depto = value; }
        public int Mes { get => mes; set => mes = value; }
        public int Año { get => año; set => año = value; }
        public int IdGasto { get => idGasto; set => idGasto = value; }
        public string Gasto { get => gasto; set => gasto = value; }
        public int Monto { get => monto; set => monto = value; }
        public int Cantidad { get => cantidad; set => cantidad = value; }
        public int Total { get => total; set => total = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
    }
}
