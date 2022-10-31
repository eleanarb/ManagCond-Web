using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Visita
    {
        private int id;
        private string numDpto;
        private string rut;
        private string nombres;
        private string apellidos;
        private DateTime fecha;
        private TimeSpan hora;
        private string patente;
        private string estado;
        private int idCond;
        private int idNumDpto;

        public Visita(int id, string numDpto, string rut, string nombres, string apellidos, DateTime fecha, TimeSpan hora, string patente, string estado, int idCond, int idNumDpto)
        {
            this.id = id;
            this.numDpto = numDpto;
            this.rut = rut;
            this.nombres = nombres;
            this.apellidos = apellidos;
            this.fecha = fecha;
            this.hora = hora;
            this.patente = patente;
            this.estado = estado;
            this.idCond = idCond;
            this.idNumDpto = idNumDpto;
        }

        public int Id { get => id; set => id = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public string Rut { get => rut; set => rut = value; }
        public string Nombres { get => nombres; set => nombres = value; }
        public string Apellidos { get => apellidos; set => apellidos = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public TimeSpan Hora { get => hora; set => hora = value; }
        public string Patente { get => patente; set => patente = value; }
        public string Estado { get => estado; set => estado = value; }
        public int IdCond { get => idCond; set => idCond = value; }
        public int IdNumDpto { get => idNumDpto; set => idNumDpto = value; }
    }
}
