using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class RespuestaForo
    {
        private int id;
        private int idForo;
        private string mensaje;
        private string rut;
        private string nombre;
        private DateTime fecha;
        private TimeSpan hora;
        private string imagen;
        private string depto;
        private int tipoUsuario;

        public RespuestaForo(int id, int idForo, string mensaje, string rut, string nombre, DateTime fecha, TimeSpan hora, string imagen, string depto, int tipoUsuario)
        {
            this.id = id;
            this.idForo = idForo;
            this.mensaje = mensaje;
            this.rut = rut;
            this.nombre = nombre;
            this.fecha = fecha;
            this.hora = hora;
            this.imagen = imagen;
            this.depto = depto;
            this.tipoUsuario = tipoUsuario;
        }

        public int Id { get => id; set => id = value; }
        public int IdForo { get => idForo; set => idForo = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }
        public string Rut { get => rut; set => rut = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public TimeSpan Hora { get => hora; set => hora = value; }
        public string Imagen { get => imagen; set => imagen = value; }
        public string Depto { get => depto; set => depto = value; }
        public int TipoUsuario { get => tipoUsuario; set => tipoUsuario = value; }
    }
}
