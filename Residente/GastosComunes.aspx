<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GastosComunes.aspx.cs" Inherits="ManagCond.Residente.GastosComunes" %>
<%@ Import Namespace="Model" %>
<%@ Import Namespace="Dao" %>

<!DOCTYPE html>

<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>ManagCond</title>
      <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
      <link rel="stylesheet" href="../assets/css/tailwind.output.css" />
      <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
      <script src="../assets/js/init-alpine.js"></script>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
      <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" defer></script>
    
      
    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
</head>
<body>
          <div
        class="flex h-screen bg-gray-50 dark:bg-gray-900"
        :class="{ 'overflow-hidden': isSideMenuOpen }">
        <!-- #include file ="Template/AsideResidente.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderResidente.html" -->
            <main class="h-full overflow-y-auto">
                <form id="gastosComunes" runat="server">
                    <div class="container grid px-6 mx-auto">
                        <br />
                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                        <div class="">
                            <%
                                int idCondominio = (int)Session["idCond"];
                                int idDpto = int.Parse((string)Session["numDpto"]);
                                int pendientes = 0;
                                pendientes = GastosComunesDao.ObtenerTotalGastosComunesPendientes(idDpto, idCondominio);
                                %>

                            <% if (pendientes == 0)
                                { %>
                            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800 text-center" >
                                <div>
                                   
                                    <br />
                                    <h2 class="font-semibold text-gray-700 dark:text-gray-200"><strong>Total a Pagar</strong></h2>
                                    <h1 class="text-4xl font-extrabold dark:text-white"><strong>$ 0</strong></h1>
                                    <p class="mb-4 text-gray-600 dark:text-gray-400">Estás al día!</p>

                                    <br />
                                </div>
                                <br />

                            </div>
                            <%} else { %>

                    
                            <div class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800 text-center" >
                                <div>
                                    <%                                     
                                        GastosComunes gc = GastosComunesDao.ObtenerDatosUltimoGastoComun(idCondominio, idDpto); 
                                        string mes = "";
                                        if( gc.MesCobro == 1){mes = "Enero"; } if( gc.MesCobro == 2){mes = "Febrero"; } if( gc.MesCobro == 3){mes = "Marzo"; } if( gc.MesCobro == 4){mes = "Abril"; } if( gc.MesCobro == 5){mes = "Mayo"; } if( gc.MesCobro == 6){mes = "Junio"; } if( gc.MesCobro == 7){mes = "Julio"; } if( gc.MesCobro == 8){mes = "Agosto"; } if( gc.MesCobro == 9){mes = "Septiembre"; } if( gc.MesCobro == 10){mes = "Octubre"; } if( gc.MesCobro == 11){mes = "Noviembre"; } if( gc.MesCobro == 12){mes = "Diciembre"; }
                    
                                    %>
                                    <br />
                                    <h2 class="font-semibold text-gray-700 dark:text-gray-200"><strong>Total a Pagar</strong></h2>
                                    <h1 class="text-4xl font-extrabold dark:text-white"><strong>$ <%=gc.TotalPagar.ToString("N0") %></strong></h1>
                                    <p class="mb-4 text-gray-600 dark:text-gray-400"><%=mes %> - <%=gc.AñoCobro %></p>

                                    <p class="mb-4 text-gray-600 dark:text-gray-400">Vence el <%=gc.FechaVencimiento.ToString("dd-MM-yyyy") %></p> 
                                    
                                    <a class="text-white bg-green-600 hover:bg-green-700 focus:ring-4 focus:outline-none focus:ring-green-200 dark:focus:ring-green-900 font-medium rounded-lg text-sm px-5 py-2.5 inline-flex justify-center w-full text-center" href="PagarGastoComun.aspx?id=<%=gc.Id %>">Pagar</a>
                                    <br />
                                </div>
                                <br />
                                <div id="accordion-collapse" data-accordion="collapse">
                                    <h2 id="accordion-collapse-heading-1">
                                        <button type="button" class="flex items-center justify-between w-full p-5 font-medium text-left text-gray-500 border border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800" data-accordion-target="#accordion-collapse-body-1" aria-expanded="false" aria-controls="accordion-collapse-body-1">
                                            <span>Ver detalles</span>
                                            <svg class="w-6 h-6 rotate-180 shrink-0" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                        </button>
                                    </h2>
                                    <div id="accordion-collapse-body-1" class="hidden" aria-labelledby="accordion-collapse-heading-1">
                                        <div class="p-5 font-light  dark:border-gray-700 dark:bg-gray-900">
                                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-left">Gasto Común </p>
                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-right">$ <%=gc.GastoComun.ToString("N0") %></p>

                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-left">Fondo Reserva</p>
                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-right">$ <%=gc.FondoReserva.ToString("N0") %></p>

                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-left">Multas</p>
                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-right">$ <%=gc.Multas.ToString("N0") %></p>

                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-left">Días de Atraso</p>
                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-right"><%=gc.DiasAtraso %></p>

                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-left">Intereses por Atraso</p>
                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-right">$ <%=gc.MoraPeriodo.ToString("N0") %></p>

                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-left">Otros</p>
                                                <p style="margin: -5.5% 0;" class="text-sm text-gray-900 dark:text-white text-right">$ <%=gc.Varios.ToString("N0") %></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <%} %>
                            </div>
                            <div class="col-span-2">
                                <h2 class="my-6 text-lg font-semibold text-gray-700 dark:text-gray-200">Gastos Comunes Por Pagar</h2>
                                <div class="overflow-x-auto relative shadow-md sm:rounded-lg" aria-labelledby="">
                                    
                                    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                        <thead class="text-xs text-gray-700 uppercase bg-red-50 dark:bg-red-700 dark:text-gray-300">
                                            <tr>
                                                <th scope="col" class="py-3 px-6">Período
                                                </th>
                                                <th scope="col" class="py-3 px-6">Emisión
                                                </th>
                                                <th scope="col" class="py-3 px-6">Vencimiento
                                                </th>
                                                <th scope="col" class="py-3 px-6">Total 
                                                </th>
                                                <th scope="col" class="py-3 px-6">Acciones
                                                </th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <% 
                                                
                                                int vencidos = 0;
                                                vencidos = GastosComunesDao.ObtenerTotalGastosComunesVencidos(idDpto, idCondominio);
                                                if (vencidos == 0)
                                                {
                                            %>
                                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                                <th colspan="6" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay gastos comunes vencidos
                                                </th>
                                            </tr>
                                            <%}
                                                else
                                                {

                                                    foreach (GastosComunes gcV in GastosComunesDao.GetAlGastosComunesVencidos(idDpto, idCondominio))
                                                    {
                                                        string mes2 = "";
                                                        if( gcV.MesCobro == 1){mes2 = "Enero"; } if( gcV.MesCobro == 2){mes2 = "Febrero"; } if( gcV.MesCobro == 3){mes2 = "Marzo"; } if( gcV.MesCobro == 4){mes2 = "Abril"; } if( gcV.MesCobro == 5){mes2 = "Mayo"; } if( gcV.MesCobro == 6){mes2 = "Junio"; } if( gcV.MesCobro == 7){mes2 = "Julio"; } if( gcV.MesCobro == 8){mes2 = "Agosto"; } if( gcV.MesCobro == 9){mes2 = "Septiembre"; } if( gcV.MesCobro == 10){mes2 = "Octubre"; } if( gcV.MesCobro == 11){mes2 = "Noviembre"; } if( gcV.MesCobro == 12){mes2 = "Diciembre"; }
                    
                                            %>
                                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">                                                
                                                <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white"><%=mes2 %> - <%=gcV.AñoCobro %>
                                                </th>
                                                <td class="py-4 px-6"><%=gcV.FechaEmision.ToString("dd-MM-yyyy") %>
                                                </td>
                                                <td class="py-4 px-6"><%=gcV.FechaVencimiento.ToString("dd-MM-yyyy") %>
                                                </td>
                                                <td class="py-4 px-6">$<%=gcV.TotalPagar.ToString("N0") %>
                                                </td>
                                                <td class="py-4 px-6 md:grid-cols-2">
                                                    <a class="text-white bg-green-600 hover:bg-green-700 focus:ring-4 focus:outline-none focus:ring-green-200 dark:focus:ring-green-900 font-medium rounded-lg text-sm px-5 py-2.5 inline-flex justify-center w-full text-center" href="PagarGastoComun.aspx?id=<%=gcV.Id %>">Pagar</a>
                                    
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                }%>
                                        </tbody>
                                    </table>
                                </div>
                                <br />
                                <h2 class="my-6 text-lg font-semibold text-gray-700 dark:text-gray-200">Gastos Comunes Pagados</h2>
                                <div class="overflow-x-auto relative shadow-md sm:rounded-lg " aria-labelledby="">
                                    

                                    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                        <thead class="text-xs text-gray-700 uppercase g-gray-50 dark:bg-gray-700 dark:text-gray-400 ">
                                            <tr>
                                                <th scope="col" class="py-3 px-6">Período
                                                </th>
                                                <th scope="col" class="py-3 px-6">Emisión
                                                </th>
                                                <th scope="col" class="py-3 px-6">Vencimiento
                                                </th>
                                                <th scope="col" class="py-3 px-6">Total 
                                                </th>
                                                <th scope="col" class="py-3 px-6">Acciones
                                                </th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <% 
                                                int pagados = 0;
                                                pagados = GastosComunesDao.ObtenerTotalGastosComunesPagados(idDpto, idCondominio);
                                                if (pagados == 0)
                                                {
                                            %>
                                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                                <th colspan="8" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay pagos registrados
                                                </th>
                                            </tr>
                                            <%
                                                }
                                                else
                                                {

                                                    foreach (GastosComunes gcP in GastosComunesDao.GetAlGastosComunesPagados(idDpto, idCondominio))
                                                    {
                                                        string mes3 = "";
                                                        if( gcP.MesCobro == 1){mes3 = "Enero"; } if( gcP.MesCobro == 2){mes3 = "Febrero"; } if( gcP.MesCobro == 3){mes3 = "Marzo"; } if( gcP.MesCobro == 4){mes3 = "Abril"; } if( gcP.MesCobro == 5){mes3 = "Mayo"; } if( gcP.MesCobro == 6){mes3 = "Junio"; } if( gcP.MesCobro == 7){mes3 = "Julio"; } if( gcP.MesCobro == 8){mes3 = "Agosto"; } if( gcP.MesCobro == 9){mes3 = "Septiembre"; } if( gcP.MesCobro == 10){mes3 = "Octubre"; } if( gcP.MesCobro == 11){mes3 = "Noviembre"; } if( gcP.MesCobro == 12){mes3 = "Diciembre"; }
                    
                                            %>
                                            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">                                                
                                                <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white"><%=mes3 %> - <%=gcP.AñoCobro %>
                                                </th>
                                                <td class="py-4 px-6"><%=gcP.FechaEmision.ToString("dd-MM-yyyy") %>
                                                </td>
                                                <td class="py-4 px-6"><%=gcP.FechaVencimiento.ToString("dd-MM-yyyy") %>
                                                </td>
                                                <td class="py-4 px-6">$<%=gcP.TotalPagar.ToString("N0") %>
                                                </td>
                                                <td class="py-4 px-6 md:grid-cols-2">

                                                    <a class="text-white bg-purple-700 hover:bg-purple-800 focus:ring-4 focus:outline-none focus:ring-purple-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-purple-600 dark:hover:bg-purple-700 dark:focus:ring-purple-800" href="DetalleGastoComun.aspx?id=<%= gcP.Id %>">
                                                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                                                    </a>


                                                </td>
                                            </tr>
                                            <%}
                                                        }
                                                    
                                                %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            </div>

                       
                    </div>
                </form>
            </main>
        </div>
     </div>


    <script src="https://unpkg.com/flowbite@1.5.4/dist/flowbite.js"></script>
  </body>
</html>
