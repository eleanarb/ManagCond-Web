<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleGastoComun.aspx.cs" Inherits="ManagCond.Administrador.DetalleGastoComun" %>
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
    <form runat="server">
    <div class="control-bar">
        <div class="container">
            <div class="row ">
                <div class="col-2 ">                     
                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListMes" runat="server" OnSelectedIndexChanged="Mes_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="01">Enero</asp:ListItem>
                            <asp:ListItem Value="02">Febrero</asp:ListItem>
                            <asp:ListItem Value="03">Marzo</asp:ListItem>
                            <asp:ListItem Value="04">Abril</asp:ListItem>
                            <asp:ListItem Value="05">Mayo</asp:ListItem>
                            <asp:ListItem Value="06">Junio</asp:ListItem>
                            <asp:ListItem Value="07">Julio</asp:ListItem>
                            <asp:ListItem Value="08">Agosto</asp:ListItem>
                            <asp:ListItem Value="09">Septiembre</asp:ListItem>
                            <asp:ListItem Value="10">Octubre</asp:ListItem>
                            <asp:ListItem Value="11">Noviembre</asp:ListItem>
                            <asp:ListItem Value="12">Diciembre</asp:ListItem>
                        </asp:DropDownList>

                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAño" runat="server" OnSelectedIndexChanged="Año_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="2019">2019</asp:ListItem>
                            <asp:ListItem Value="2020">2020</asp:ListItem>
                            <asp:ListItem Value="2022">2022</asp:ListItem>
                            <asp:ListItem Value="2023">2023</asp:ListItem>
                            <asp:ListItem Value="2024">2024</asp:ListItem>
                            <asp:ListItem Value="2025">2025</asp:ListItem>
                            <asp:ListItem Value="2026">2026</asp:ListItem>
                        </asp:DropDownList>                   
                </div>

                <div class="col-2">
                     <div class="slogan"><a href="GastosComunes.aspx">Volver</a> &nbsp  <a href="javascript:window.print()">Imprimir</a></div>
                    
                </div>


                    

                <!--.col-->
            </div>
            <!--.row-->
        </div>
        <!--.container-->
    </div>
        </form>
    <!--.control-bar-->

    <header class="row">
        <div class="logoholder text-center">
            <img style="width:100%" src="../assets/img/logo.png" />
        </div>
        <%
            int idCondominio = (int)Session["idCondominio"];
            Condominio cond = CondominioDao.ObtenerDatosCondominio(idCondominio);

             int vMes = (int)Session["mes"];
             int vAño = (int)Session["año"];
            Balance balance = BalanceDao.ObtenerDatosBalance(idCondominio, vMes, vAño);
            int totalLiquidaciones = LiquidacionesDao.ObtenerTotalLiquidaciones(vMes, vAño, idCondominio, "");
            int totalCategorias = EgresosDao.ObtenerTotalCategoriaEgresos(idCondominio, vMes, vAño);
            int totalIngresos = IngresosDao.ObtenerTotalIngresos(vMes, vAño, idCondominio);

            string mes = "";
            if( vMes == 1){mes = "Enero"; } if( vMes == 2){mes = "Febrero"; } if( vMes == 3){mes = "Marzo"; } if( vMes == 4){mes = "Abril"; } if( vMes == 5){mes = "Mayo"; } if( vMes == 6){mes = "Junio"; } if( vMes == 7){mes = "Julio"; } if( vMes == 8){mes = "Agosto"; } if( vMes == 9){mes = "Septiembre"; } if( vMes == 10){mes = "Octubre"; } if( vMes == 11){mes = "Noviembre"; } if( vMes == 12){mes = "Diciembre"; }

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

        </div>
        <!--.col-->

    </div>


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

