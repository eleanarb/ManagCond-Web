using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Foro
    {
        public int id;
        public string rut;
        public string nombre;
        public string mensaje;
        public DateTime fecha;
        public TimeSpan hora;
        public string imagen;
        public int idCond;
        public string categoria;
        public int importancia;
        public string depto;
        public int tipoUsuario;

        public Foro(int id, string rut, string nombre, string mensaje, DateTime fecha, TimeSpan hora, string imagen, int idCond, string categoria, int importancia, string depto, int tipoUsuario)
        {
            this.id = id;
            this.rut = rut;
            this.nombre = nombre;
            this.mensaje = mensaje;
            this.fecha = fecha;
            this.hora = hora;
            this.imagen = imagen;
            this.idCond = idCond;
            this.categoria = categoria;
            this.importancia = importancia;
            this.depto = depto;
            this.tipoUsuario = tipoUsuario;
        }

        public int Id { get => id; set => id = value; }
        public string Rut { get => rut; set => rut = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Mensaje { get => mensaje; set => mensaje = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public TimeSpan Hora { get => hora; set => hora = value; }
        public string Imagen { get => imagen; set => imagen = value; }
        public int IdCond { get => idCond; set => idCond = value; }
        public string Categoria { get => categoria; set => categoria = value; }
        public int Importancia { get => importancia; set => importancia = value; }
        public string Depto { get => depto; set => depto = value; }
        public int TipoUsuario { get => tipoUsuario; set => tipoUsuario = value; }
    }
}
