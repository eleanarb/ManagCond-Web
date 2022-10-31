using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Residente
    {
        string rutResidente;
        string nombresResidente;
        string apellidosResidente;
        string numDpto;
        string estacinamiento;
        string telefonoResidente;
        string correoResidente;
        string rutPropietario;
        string nombrePropietario;
        string telefonoPropietario;
        string correoPropietario;
        int idCond;

        public Residente(string rutResidente, string nombresResidente, string apellidosResidente, string numDpto, string estacinamiento, string telefonoResidente, string correoResidente, string rutPropietario, string nombrePropietario, string telefonoPropietario, string correoPropietario, int idCond)
        {
            this.rutResidente = rutResidente;
            this.nombresResidente = nombresResidente;
            this.apellidosResidente = apellidosResidente;
            this.numDpto = numDpto;
            this.estacinamiento = estacinamiento;
            this.telefonoResidente = telefonoResidente;
            this.correoResidente = correoResidente;
            this.rutPropietario = rutPropietario;
            this.nombrePropietario = nombrePropietario;
            this.telefonoPropietario = telefonoPropietario;
            this.correoPropietario = correoPropietario;
            this.idCond = idCond;
        }

        public string RutResidente { get => rutResidente; set => rutResidente = value; }
        public string NombresResidente { get => nombresResidente; set => nombresResidente = value; }
        public string ApellidosResidente { get => apellidosResidente; set => apellidosResidente = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public string Estacinamiento { get => estacinamiento; set => estacinamiento = value; }
        public string TelefonoResidente { get => telefonoResidente; set => telefonoResidente = value; }
        public string CorreoResidente { get => correoResidente; set => correoResidente = value; }
        public string RutPropietario { get => rutPropietario; set => rutPropietario = value; }
        public string NombrePropietario { get => nombrePropietario; set => nombrePropietario = value; }
        public string TelefonoPropietario { get => telefonoPropietario; set => telefonoPropietario = value; }
        public string CorreoPropietario { get => correoPropietario; set => correoPropietario = value; }
        public int IdCond { get => idCond; set => idCond = value; }
    }
}
