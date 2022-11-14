using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Proveedor
    {
        public int id;
        private string nombre;
        private string telefono;
        private string correo;
        private int idDireccion;
        private string direccion;
        private int idComuna;
        private string comuna;
        private int idRegion;
        private string region;
        private int idPago;        
        private string nombrePago;
        private string rut;
        private string banco;
        private string tipoCuenta;
        private string numCuenta;
        private string tipoPago;
        private int idCond;

        public Proveedor(int id, string nombre, string telefono, string correo, int idDireccion, string direccion, int idComuna, string comuna, int idRegion, string region, int idPago, string nombrePago, string rut, string banco, string tipoCuenta, string numCuenta, string tipoPago, int idCond)
        {
            this.id = id;
            this.nombre = nombre;
            this.telefono = telefono;
            this.correo = correo;
            this.idDireccion = idDireccion;
            this.direccion = direccion;
            this.idComuna = idComuna;
            this.comuna = comuna;
            this.idRegion = idRegion;
            this.region = region;
            this.idPago = idPago;
            this.nombrePago = nombrePago;
            this.rut = rut;
            this.banco = banco;
            this.tipoCuenta = tipoCuenta;
            this.numCuenta = numCuenta;
            this.tipoPago = tipoPago;
            this.idCond = idCond;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Telefono { get => telefono; set => telefono = value; }
        public string Correo { get => correo; set => correo = value; }
        public int IdDireccion { get => idDireccion; set => idDireccion = value; }
        public string Direccion { get => direccion; set => direccion = value; }
        public int IdComuna { get => idComuna; set => idComuna = value; }
        public string Comuna { get => comuna; set => comuna = value; }
        public int IdRegion { get => idRegion; set => idRegion = value; }
        public string Region { get => region; set => region = value; }
        public int IdPago { get => idPago; set => idPago = value; }
        public string NombrePago { get => nombrePago; set => nombrePago = value; }
        public string Rut { get => rut; set => rut = value; }
        public string Banco { get => banco; set => banco = value; }
        public string TipoCuenta { get => tipoCuenta; set => tipoCuenta = value; }
        public string NumCuenta { get => numCuenta; set => numCuenta = value; }
        public string TipoPago { get => tipoPago; set => tipoPago = value; }
        public int IdCond { get => idCond; set => idCond = value; }
    }
}
