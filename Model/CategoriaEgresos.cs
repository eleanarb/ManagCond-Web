using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class CategoriaEgresos
    {
        public int id;
        private string descrpcion;
        private int idCond;

        public CategoriaEgresos(int id, string descrpcion, int idCond)
        {
            this.id = id;
            this.descrpcion = descrpcion;
            this.idCond = idCond;
        }

        public int Id { get => id; set => id = value; }
        public string Descrpcion { get => descrpcion; set => descrpcion = value; }
        public int IdCond { get => idCond; set => idCond = value; }
    }
}
