using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Balance
    {
        int id;
        int mes;
        int año;
        int idCond;
        int totalIngresos;
        int totalGastoComun;
        int totalEgresos;
        int totalRemuneraciones;
        int tbalance;

        public Balance(int id, int mes, int año, int idCond, int totalIngresos, int totalGastoComun, int totalEgresos, int totalRemuneraciones, int tbalance)
        {
            this.id = id;
            this.mes = mes;
            this.año = año;
            this.idCond = idCond;
            this.totalIngresos = totalIngresos;
            this.totalGastoComun = totalGastoComun;
            this.totalEgresos = totalEgresos;
            this.totalRemuneraciones = totalRemuneraciones;
            this.tbalance = tbalance;
        }

        public int Id { get => id; set => id = value; }
        public int Mes { get => mes; set => mes = value; }
        public int Año { get => año; set => año = value; }
        public int IdCond { get => idCond; set => idCond = value; }
        public int TotalIngresos { get => totalIngresos; set => totalIngresos = value; }
        public int TotalGastoComun { get => totalGastoComun; set => totalGastoComun = value; }
        public int TotalEgresos { get => totalEgresos; set => totalEgresos = value; }
        public int TotalRemuneraciones { get => totalRemuneraciones; set => totalRemuneraciones = value; }
        public int Tbalance { get => tbalance; set => tbalance = value; }
    }
}
