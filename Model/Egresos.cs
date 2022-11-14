using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class Egresos
    {
        public int id;
        private int idProveedor;
        private string proveedor;
        private string descripcion;
        private int idCategoria;
        private string Categoria;
        private DateTime fecha;
        private int monto;
        private string estado;
        private string documentoCobro;
        private string comprobante;
        private int idCond;

        public Egresos(int id, int idProveedor, string proveedor, string descripcion, string categoria, DateTime fecha, int monto, string estado, string documentoCobro, string comprobante, int idCond)
        {
            this.id = id;
            this.idProveedor = idProveedor;
            this.proveedor = proveedor;
            this.descripcion = descripcion;
            Categoria = categoria;
            this.fecha = fecha;
            this.monto = monto;
            this.estado = estado;
            this.documentoCobro = documentoCobro;
            this.comprobante = comprobante;
            this.idCond = idCond;
        }

        public int Id { get => id; set => id = value; }
        public int IdProveedor { get => idProveedor; set => idProveedor = value; }
        public string Proveedor { get => proveedor; set => proveedor = value; }
        public string Descripcion { get => descripcion; set => descripcion = value; }
        public string Categoria1 { get => Categoria; set => Categoria = value; }
        public DateTime Fecha { get => fecha; set => fecha = value; }
        public int Monto { get => monto; set => monto = value; }
        public string Estado { get => estado; set => estado = value; }
        public string DocumentoCobro { get => documentoCobro; set => documentoCobro = value; }
        public string Comprobante { get => comprobante; set => comprobante = value; }
        public int IdCond { get => idCond; set => idCond = value; }
    }
}
