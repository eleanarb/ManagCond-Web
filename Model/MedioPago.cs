using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class MedioPago
    {
        private int id;
        private string nombre;
        private string rut;
        private string banco;
        private string numCuenta;
        private string tipoPago;

        public MedioPago(int id, string nombre, string rut, string banco, string numCuenta, string tipoPago)
        {
            this.id = id;
            this.nombre = nombre;
            this.rut = rut;
            this.banco = banco;
            this.numCuenta = numCuenta;
            this.tipoPago = tipoPago;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Rut { get => rut; set => rut = value; }
        public string Banco { get => banco; set => banco = value; }
        public string NumCuenta { get => numCuenta; set => numCuenta = value; }
        public string TipoPago { get => tipoPago; set => tipoPago = value; }
    }
}
