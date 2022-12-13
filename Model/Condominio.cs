using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Condominio
    {
        private int id;
        private string nombre;
        private string direccion;
        private string comuna;
        private string region;
        private int cant_edf;
        private decimal porcentajeMora;
        private decimal porcentajeFondoReserva;

        public Condominio(int id, string nombre, string direccion, string comuna, string region, int cant_edf, decimal porcentajeMora, decimal porcentajeFondoReserva)
        {
            this.id = id;
            this.nombre = nombre;
            this.direccion = direccion;
            this.comuna = comuna;
            this.region = region;
            this.cant_edf = cant_edf;
            this.porcentajeMora = porcentajeMora;
            this.porcentajeFondoReserva = porcentajeFondoReserva;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Direccion { get => direccion; set => direccion = value; }
        public string Comuna { get => comuna; set => comuna = value; }
        public string Region { get => region; set => region = value; }
        public int Cant_edf { get => cant_edf; set => cant_edf = value; }
        public decimal PorcentajeMora { get => porcentajeMora; set => porcentajeMora = value; }
        public decimal PorcentajeFondoReserva { get => porcentajeFondoReserva; set => porcentajeFondoReserva = value; }
    }
}