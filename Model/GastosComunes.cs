using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class GastosComunes
    {
        private int id;
        private string numDpto;
        private DateTime fechaEmision;
        private DateTime fechaVencimiento;
        private int gastoComun;
        private int fondoReserva;
        private int seguro;
        private int multas;
        private int moraPeriodo;
        private int varios;
        private int id_Cond;
        private string estado;

        public GastosComunes()
        {

        }

        public GastosComunes(int id, string numDpto, DateTime fechaEmision, DateTime fechaVencimiento, int gastoComun, int fondoReserva, int seguro, int multas, int moraPeriodo, int varios, int id_Cond, string estado)
        {
            this.id = id;
            this.numDpto = numDpto;
            this.fechaEmision = fechaEmision;
            this.fechaVencimiento = fechaVencimiento;
            this.gastoComun = gastoComun;
            this.fondoReserva = fondoReserva;
            this.seguro = seguro;
            this.multas = multas;
            this.moraPeriodo = moraPeriodo;
            this.varios = varios;
            this.id_Cond = id_Cond;
            this.estado = estado;
        }

        public int Id { get => id; set => id = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public DateTime FechaEmision { get => fechaEmision; set => fechaEmision = value; }
        public DateTime FechaVencimiento { get => fechaVencimiento; set => fechaVencimiento = value; }
        public int GastoComun { get => gastoComun; set => gastoComun = value; }
        public int FondoReserva { get => fondoReserva; set => fondoReserva = value; }
        public int Seguro { get => seguro; set => seguro = value; }
        public int Multas { get => multas; set => multas = value; }
        public int MoraPeriodo { get => moraPeriodo; set => moraPeriodo = value; }
        public int Varios { get => varios; set => varios = value; }
        public int Id_Cond { get => id_Cond; set => id_Cond = value; }
        public string Estado { get => estado; set => estado = value; }
    }
}
