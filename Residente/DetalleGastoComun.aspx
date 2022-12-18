﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleGastoComun.aspx.cs" Inherits="ManagCond.Template.DetalleGastoComun" %>
<%@ Import Namespace="Model" %>
<%@ Import Namespace="Dao" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="../assets/css/factura.css" media="all"/>
</head>
<body>
    <div class="control-bar">
        <div class="container">
            <div class="row">
                <div class="col-2-4">
                    <div class="slogan"><a href="GastosComunes.aspx">Volver</a></div>

                </div>
                <div class="col-4 text-right">
                    <a href="javascript:window.print()">Imprimir</a>
                </div>
                <!--.col-->
            </div>
            <!--.row-->
        </div>
        <!--.container-->
    </div>
    <!--.control-bar-->

    <header class="row">
        <div class="logoholder text-center">
            <img style="width:100%" src="../assets/img/logo.png" />
        </div>
        <%
            %><% string id = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"])); %><%
            int idCondominio = (int)Session["idCond"];
            int idDpto = int.Parse((string)Session["numDpto"]);   
            Usuario usuario = (Usuario)Session["usuario"];
            Condominio cond = CondominioDao.ObtenerDatosCondominio(idCondominio);
            Departamento dpto = DepartamentoDao.ObtenerDatosDepartamento(idDpto);
            GastosComunes gc = GastosComunesDao.ObtenerDatosGastoComun(idCondominio, int.Parse(id));

            int vMes = gc.MesCobro;
            int vAño = gc.AñoCobro;
            Balance balance = BalanceDao.ObtenerDatosBalance(idCondominio, vMes, vAño);
            int totalLiquidaciones = LiquidacionesDao.ObtenerTotalLiquidaciones(vMes, vAño, idCondominio, "");
            int totalCategorias = EgresosDao.ObtenerTotalCategoriaEgresos(idCondominio, vMes, vAño);
            int totalIngresos = IngresosDao.ObtenerTotalIngresos(vMes, vAño, idCondominio);

            decimal prorrateo = dpto.Prorrateo * 100;
            string mes = "";
            if( gc.MesCobro == 1){mes = "Enero"; } if( gc.MesCobro == 2){mes = "Febrero"; } if( gc.MesCobro == 3){mes = "Marzo"; } if( gc.MesCobro == 4){mes = "Abril"; } if( gc.MesCobro == 5){mes = "Mayo"; } if( gc.MesCobro == 6){mes = "Junio"; } if( gc.MesCobro == 7){mes = "Julio"; } if( gc.MesCobro == 8){mes = "Agosto"; } if( gc.MesCobro == 9){mes = "Septiembre"; } if( gc.MesCobro == 10){mes = "Octubre"; } if( gc.MesCobro == 11){mes = "Noviembre"; } if( gc.MesCobro == 12){mes = "Diciembre"; }
                    
        %>

        <div class="me">
            <p>
                <strong>Condominio <%=cond.Nombre %></strong><br />
                <%=cond.Direccion %><br />
                <%=cond.Comuna %>, <%=cond.Region %><br />
                Chile<br />
            </p>
        </div>
        <!--.me-->

        <div class="info">
        </div>
        <!-- .info -->

        <div class="bank">
        </div>
        <!--.bank-->

    </header>


    <div class="row section">

        <div class="col-2">
            <h3>COLILLA DE COBRO DE GASTOS COMUNES <%=mes.ToUpper()%></h3>
        </div>
        <!--.col-->
        <div></div>

        <div class="col-2">


            <p class="client">
                <strong>Propietario:  </strong><%=usuario.NombrePropietario %><br />
                <strong>Copropietario: </strong><%=usuario.Nombres %> <%=usuario.Apellidos %> <br />
                <strong>Unidad:  </strong><%=dpto.NumDpto%><br />
            </p>
        </div>
        <!--.col-->


        <div class="col-2">

            <p class="client">
                <strong>Mes de cobro: </strong><%=mes %> - <%=gc.AñoCobro %><br />
                <strong>Vencimiento: </strong><%=gc.FechaVencimiento.ToString("dddd, dd MMMM yyyy") %><br />
                <strong>Prorrateo: </strong><%=prorrateo %>%<br />
            </p>
        </div>
        <!--.col-->



    </div>

    <div class="invoicelist-body">
        <table class="styled-table">
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr style="margin: -5.5% 0;">
                    <td>Total Gasto Común</td>
                    <td>$ <%=balance.TotalGastoComun.ToString("N0") %></td>
                </tr>
            </tbody>
        </table>
        <table class="styled-table" >
            <thead style="border-collapse: collapse; border: none">
                <tr>
                    <th>Detalle de su Gasto Común</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr style="background-color: white;">
                    <td style="padding-bottom: 0;">Gastos común</td>
                    <td style="padding-bottom: 0;">$<%=gc.TotalPagar.ToString("N0") %></td>
                </tr>
                <tr style="background-color: white; ">
                    <td style="padding-bottom: 0;">Fondo reserva</td>
                    <td style="padding-bottom: 0;">$<%=gc.FondoReserva.ToString("N0") %></td>
                </tr>
                <tr style="background-color: white">
                    <td style="padding-bottom: 0;">Intereses por atraso</td>
                    <td style="padding-bottom: 0;">$<%=gc.MoraPeriodo.ToString("N0") %></td>
                </tr>
                <tr style="background-color: white">
                    <td style="padding-bottom: 0;">Cargos</td>
                    <td style="padding-bottom: 0;">$<%=gc.Varios.ToString("N0") %></td>
                </tr >
                <tr style="background-color: white">
                    <td style="padding-bottom: 0;">Multas</td>
                    <td style="padding-bottom: 0;">$<%=gc.Multas.ToString("N0")%> </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!--.invoice-body-->

    <div class="invoicelist-footer">
        <table>
            <tr class="">
                <td width="85%"><strong>TOTAL A PAGAR:</strong> </td>
                <td id="total_tax"><strong><%=gc.TotalPagar.ToString("N0") %></strong></td>
            </tr>
        </table>
    </div>

    <div class="note">
        <h2>Nota:</h2>
    </div>
    <!--.note-->

    <footer class="row">
        <div class="col-1">
            <p class="notaxrelated">Para pagar vía transferencia electrónica los datos son: <br />
                <strong>Banco:</strong> BCI <br />
                <strong>Tipo de Cuenta:</strong> Vista <br />
                <strong>N° de Cuenta:</strong> 7770 26 638 804  <br />
                <strong>Rut:</strong> 65.256.563-7 <br />
                <strong>Correo:</strong> managcond@outlook.com <br />
                Enviar el comprobante de la transferencia indicando el número de la unidad. 
            </p>

        </div>
    </footer>

    <br /><br /><br /><br />

    <div class="invoicelist-body">
         <table class="styled-table" >
            <thead style="border-collapse: collapse; border: none">
                <tr>
                    <th colspan="5">Gasto común de la comunidad</th>
                </tr>
                <tr style="background: white; border-bottom: 2pt solid black">
                    <th width="20%">Ítem</th>
                    <th width="30%">Descripción</th>
                    <th width="20%">Fecha</th>
                    <th width="15%">Valor</th>
                    <th width="15%">Monto</th>
                </tr>
            </thead>
            <tbody>

                <% 
                    if (totalLiquidaciones == 0){  }
                    else
                    {
                        %>
                <tr style="background: white; border-bottom: 1pt solid #C5C5C5">
                    <th colspan="5">GASTOS ADMINISTRATIVOS</th>
                </tr>

                <%foreach (Liquidacion liq in LiquidacionesDao.GetAlLiquidaciones(vMes, vAño, idCondominio, ""))
                    { %>
                <tr style="background-color: white;">
                    <td style="padding-bottom: 0; padding-top: 0;"><%=liq.RutTrabajador %></td>
                    <td style="padding-bottom: 0; padding-top: 0;">Servicios del mes de <%=mes %> <%=vAño %></td>
                    <td style="padding-bottom: 0; padding-top: 0;"><%=liq.Fecha.ToString("dd-MM-yyyy") %></td>
                    <td style="padding-bottom: 0; padding-top: 0;">$<%=liq.TotalRemuneracion.ToString("N0") %></td>
                    <td></td>
                </tr>
                <%}
                    } %>
                <%
                    if (totalCategorias == 0){ }
                    else
                    {
                        foreach (CategoriaEgresos ce in EgresosDao.GetAlObtenerCategoriasEgresos(idCondominio, vMes, vAño))
                        {
                        %>

                <tr style="background: white; border-bottom: 1pt solid #C5C5C5">
                    <th colspan="5"><%=ce.Descrpcion.ToUpper() %></th>
                </tr>
                <%foreach (Egresos e in EgresosDao.GetAlObtenerEgresos(ce.id, idCondominio, vMes, vAño))
                    { %>
                <tr style="background-color: white;">
                    <td style="padding-bottom: 0; padding-top: 0;"><%=e.Proveedor %></td>
                    <td style="padding-bottom: 0; padding-top: 0;"><%=e.Descripcion %></td>
                    <td style="padding-bottom: 0; padding-top: 0;"><%=e.Fecha.ToString("dd-MM-yyyyy") %></td>
                    <td style="padding-bottom: 0; padding-top: 0;">$<%=e.Monto.ToString("N0") %></td>
                </tr>
                <%}
                        }
                    }%>

                
                <% if (totalIngresos == 0) { 
                    %>
                <tr style="background: white; border-bottom: 1pt solid #C5C5C5">
                    <th colspan="4">INGRESOS VARIOS</th>
                    <th >$0</th>
                </tr>

                    <%}
                    else
                    { %> 
                <tr style="background: white; border-bottom: 1pt solid #C5C5C5">
                    <th colspan="5">INGRESOS VARIOS</th>
                </tr>
                <%
                        foreach (Ingreso i in IngresosDao.GetAlIngresos(vMes, vAño, idCondominio))
                        {
                        %>
                <tr style="background-color: white;">
                    <td style="padding-bottom: 0; padding-top: 0;"><%=i.Nombre %></td>
                    <td style="padding-bottom: 0; padding-top: 0;"><%=i.Comentario %></td>
                    <td style="padding-bottom: 0; padding-top: 0;"><%=i.Fecha.ToString("dd-MM-yyyy") %></td>
                    <td></td>
                    <td style="padding-bottom: 0; padding-top: 0;">$<%=i.Monto.ToString("N0") %></td>
                </tr>
                <%}
                    }
                    %>
            </tbody>
             <thead style="border-collapse: collapse; border: none">
                <tr>
                    <th colspan="4">TOTAL A COBRAR</th>
                    <th>$ 5.000.025</th>
                </tr>
            </thead>
        </table>
 
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="assets/bower_components/jquery/dist/jquery.min.js"><\/script>')</script>

</body>
</html>
