using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Reserva
    {
        private int id;
        private string numDpto;
        private DateTime fecha;
        private string rangoHorario;
        private string espacioComun;
        private string solicitante;
        private int estado;
        private int idCondominio;

        public Reserva(int id, string numDpto, DateTime fecha, string rangoHorario, string espacioComun, string solicitante, int estado, int idCondominio)
        {
            this.id = id;
            this.numDpto = numDpto;
            this.fecha = fecha;
            this.rangoHorario = rangoHorario;
            this.espacioComun = espacioComun;
            this.solicitante = solicitante;
            this.estado = estado;
            this.idCondominio = idCondominio;
        }

        public int Id { get => id; set => id = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public string RangoHorario { get => rangoHorario; set => rangoHorario = value; }
        public string EspacioComun { get => espacioComun; set => espacioComun = value; }
        public string Solicitante { get => solicitante; set => solicitante = value; }
        public int Estado { get => estado; set => estado = value; }
        public int IdCondominio { get => idCondominio; set => idCondominio = value; }
    }
}
