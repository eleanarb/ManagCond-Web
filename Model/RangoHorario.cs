using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class RangoHorario
    {
        private int id;
        private int idEspacioComun;
        private string rangoHora;

        public RangoHorario(int id, int idEspacioComun, string rangoHora)
        {
            this.Id = id;
            this.IdEspacioComun = idEspacioComun;
            this.RangoHora = rangoHora;
        }

        public int Id { get => id; set => id = value; }
        public int IdEspacioComun { get => idEspacioComun; set => idEspacioComun = value; }
        public string RangoHora { get => rangoHora; set => rangoHora = value; }
    }
}
