using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Departamento
    {
        int id;
        string numDpto;
        int numEstac;
        int numBod;
        int id_cond;
        decimal prorrateo;

        public Departamento(int id, string numDpto, int numEstac, int numBod, int id_cond, decimal prorrateo)
        {
            this.id = id;
            this.numDpto = numDpto;
            this.numEstac = numEstac;
            this.numBod = numBod;
            this.id_cond = id_cond;
            this.prorrateo = prorrateo;
        }

        public int Id { get => id; set => id = value; }
        public string NumDpto { get => numDpto; set => numDpto = value; }
        public int NumEstac { get => numEstac; set => numEstac = value; }
        public int NumBod { get => numBod; set => numBod = value; }
        public int Id_cond { get => id_cond; set => id_cond = value; }
        public decimal Prorrateo { get => prorrateo; set => prorrateo = value; }
    }
}
