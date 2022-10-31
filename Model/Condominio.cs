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
        private int cant_edf;

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Direccion { get => direccion; set => direccion = value; }
        public int Cant_edf { get => cant_edf; set => cant_edf = value; }

        public Condominio(int id, string nombre, string direccion, int cant_edf)
        {
            this.Id = id;
            this.Nombre = nombre;
            this.Direccion = direccion;
            this.Cant_edf = cant_edf;
        }
    }
}
