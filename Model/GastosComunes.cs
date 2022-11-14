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
        private int idDpto;
        private string numDpto;
        private int mesCobro;
        private int añoCobro;
        private DateTime fechaEmision;
        private DateTime fechaVencimiento;
        private int gastoComun;
        private int fondoReserva;
        private int multas;
        private int diasAtraso;
        private int moraPeriodo;
        private int varios;
        private int idCond;
        private int estado;
        private DateTime fechaPago;

        public GastosComunes(int id, int idDpto, string numDpto, int mesCobro, int añoCobro, DateTime fechaEmision, DateTime fechaVencimiento, int gastoComun, int fondoReserva, int multas, int diasAtraso, int moraPeriodo, int varios, int idCond, int estado, DateTime fechaPago)
        {
            this.id = id;
            this.idDpto = idDpto;
            this.numDpto = numDpto;
            this.mesCobro = mesCobro;
            this.añoCobro = añoCobro;
            this.fechaEmision = fechaEmision;
            this.fechaVencimiento = fechaVencimiento;
            this.gastoComun = gastoComun;
            this.fondoReserva = fondoReserva;
            this.multas = multas;
            this.diasAtraso = diasAtraso;
            this.moraPeriodo = moraPeriodo;
            this.varios = varios;
            this.idCond = idCond;
            this.estado = estado;
            this.fechaPago = fechaPago;
        }

        public int Id { get => id; set => id = value; }
        public int IdDpto { get => idDpto; set => idDpto = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public int MesCobro { get => mesCobro; set => mesCobro = value; }
        public int AñoCobro { get => añoCobro; set => añoCobro = value; }
        public DateTime FechaEmision { get => fechaEmision; set => fechaEmision = value; }
        public DateTime FechaVencimiento { get => fechaVencimiento; set => fechaVencimiento = value; }
        public int GastoComun { get => gastoComun; set => gastoComun = value; }
        public int FondoReserva { get => fondoReserva; set => fondoReserva = value; }
        public int Multas { get => multas; set => multas = value; }
        public int DiasAtraso { get => diasAtraso; set => diasAtraso = value; }
        public int MoraPeriodo { get => moraPeriodo; set => moraPeriodo = value; }
        public int Varios { get => varios; set => varios = value; }
        public int IdCond { get => idCond; set => idCond = value; }
        public int Estado { get => estado; set => estado = value; }
        public DateTime FechaPago { get => fechaPago; set => fechaPago = value; }
    }
}
