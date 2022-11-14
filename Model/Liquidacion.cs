using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Liquidacion
    {
        private int id;
        private DateTime fecha;
        private string rutTrabajador;
        private int otrosIngresos;
        private int totalRemuneracion;
        private int totalHaberes;
        private int cotizacionPrevisional;
        private int cotizacionSalud;
        private int totalDescuentosPrevisionales;
        private int otrosDescuentos;
        private int diasNoTrabajados;
        private int descuentosDiasNoTrabajados;
        private int saldoLiquido;

        public Liquidacion(int id, DateTime fecha, string rutTrabajador, int otrosIngresos, int totalRemuneracion, int totalHaberes, int cotizacionPrevisional, int cotizacionSalud, int totalDescuentosPrevisionales, int otrosDescuentos, int diasNoTrabajados, int descuentosDiasNoTrabajados, int saldoLiquido)
        {
            this.id = id;
            this.fecha = fecha;
            this.rutTrabajador = rutTrabajador;
            this.otrosIngresos = otrosIngresos;
            this.totalRemuneracion = totalRemuneracion;
            this.totalHaberes = totalHaberes;
            this.cotizacionPrevisional = cotizacionPrevisional;
            this.cotizacionSalud = cotizacionSalud;
            this.totalDescuentosPrevisionales = totalDescuentosPrevisionales;
            this.otrosDescuentos = otrosDescuentos;
            this.diasNoTrabajados = diasNoTrabajados;
            this.descuentosDiasNoTrabajados = descuentosDiasNoTrabajados;
            this.saldoLiquido = saldoLiquido;
        }

        public int Id { get => id; set => id = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public string RutTrabajador { get => rutTrabajador; set => rutTrabajador = value; }
        public int OtrosIngresos { get => otrosIngresos; set => otrosIngresos = value; }
        public int TotalRemuneracion { get => totalRemuneracion; set => totalRemuneracion = value; }
        public int TotalHaberes { get => totalHaberes; set => totalHaberes = value; }
        public int CotizacionPrevisional { get => cotizacionPrevisional; set => cotizacionPrevisional = value; }
        public int CotizacionSalud { get => cotizacionSalud; set => cotizacionSalud = value; }
        public int TotalDescuentosPrevisionales { get => totalDescuentosPrevisionales; set => totalDescuentosPrevisionales = value; }
        public int OtrosDescuentos { get => otrosDescuentos; set => otrosDescuentos = value; }
        public int DiasNoTrabajados { get => diasNoTrabajados; set => diasNoTrabajados = value; }
        public int DescuentosDiasNoTrabajados { get => descuentosDiasNoTrabajados; set => descuentosDiasNoTrabajados = value; }
        public int SaldoLiquido { get => saldoLiquido; set => saldoLiquido = value; }
    }
}
