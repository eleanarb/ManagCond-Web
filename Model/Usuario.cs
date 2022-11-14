using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Usuario
    {
        private string rut;
        private int idCond;
        private string nombres;
        private string apellidos;
        private DateTime fechaNac;
        public string numDpto;
        private string correo;
        private string clave;
        private string telefono;
        private int cargo;
        private string rutPropietario;
        private string nombrePropietario;
        private string correoPropietario;
        private string telefonoPropietario;
        private int tipoUsuario; //1 Administrador, 2 Guardia, 3 Residente.
        private int activo; //1 activo, 0 inactivo.

        public Usuario()
        {
        }

        public Usuario(string rut, int idCond, string nombres, string apellidos, DateTime fechaNac, string numDpto, string correo, string clave, string telefono, int cargo, string rutPropietario, string nombrePropietario, string correoPropietario, string telefonoPropietario, int tipoUsuario, int activo)
        {
            this.rut = rut;
            this.idCond = idCond;
            this.nombres = nombres;
            this.apellidos = apellidos;
            this.fechaNac = fechaNac;
            this.numDpto = numDpto;
            this.correo = correo;
            this.clave = clave;
            this.telefono = telefono;
            this.cargo = cargo;
            this.rutPropietario = rutPropietario;
            this.nombrePropietario = nombrePropietario;
            this.correoPropietario = correoPropietario;
            this.telefonoPropietario = telefonoPropietario;
            this.tipoUsuario = tipoUsuario;
            this.activo = activo;
        }

        public string Rut { get => rut; set => rut = value; }
        public int IdCond { get => idCond; set => idCond = value; }
        public string Nombres { get => nombres; set => nombres = value; }
        public string Apellidos { get => apellidos; set => apellidos = value; }
        public DateTime FechaNac { get => fechaNac; set => fechaNac = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public string Correo { get => correo; set => correo = value; }
        public string Clave { get => clave; set => clave = value; }
        public string Telefono { get => telefono; set => telefono = value; }
        public int Cargo { get => cargo; set => cargo = value; }
        public string RutPropietario { get => rutPropietario; set => rutPropietario = value; }
        public string NombrePropietario { get => nombrePropietario; set => nombrePropietario = value; }
        public string CorreoPropietario { get => correoPropietario; set => correoPropietario = value; }
        public string TelefonoPropietario { get => telefonoPropietario; set => telefonoPropietario = value; }
        public int TipoUsuario { get => tipoUsuario; set => tipoUsuario = value; }
        public int Activo { get => activo; set => activo = value; }
    }
}
