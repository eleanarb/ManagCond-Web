<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Liquidaciones.aspx.cs" Inherits="ManagCond.Administrador.Liquidaciones" %>
<%@ Import Namespace="Model" %>
<%@ Import Namespace="Dao" %>

<!DOCTYPE html>

<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ManagCond</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet" />
    <link rel="stylesheet" href="../assets/css/tailwind.output.css" />
    <script
        src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
        defer></script>
    <script src="../assets/js/init-alpine.js"></script>
    <script src="../assets/js/focus-trap.js" defer></script>
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
        defer></script>

    <script src="../assets/js/charts-lines.js" defer></script>
    <script src="../assets/js/charts-pie.js" defer></script>

    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
</head>
<body>
    <div
        class="flex h-screen bg-gray-50 dark:bg-gray-900"
        :class="{ 'overflow-hidden': isSideMenuOpen }">
        <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
            <main class="h-full overflow-y-auto">
                <form runat="server">
                    <div class="container grid px-6 mx-auto">
                         <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Liquidaciones de Noviembre</h2>

                        <div class="grid grid-cols-6 text-center">
                            <div class="">
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListBuscar" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione Trabajador</asp:ListItem>

                                    </asp:DropDownList>
                                </div>

                                <div class="">
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownList1" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione Mes</asp:ListItem>

                                    </asp:DropDownList>
                                </div>

                                <div class="">
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownList2" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione Año</asp:ListItem>

                                    </asp:DropDownList>
                                </div>

                            <div>
                                <a class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" href="AgregarContrato.aspx">Agregar Contrato</a>                            
                            </div>
                            <div>
                                <a class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" href="AgregarTrabajador.aspx">Agregar Trabajador</a>
                            </div>
                            <div>
                                <a class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" href="AgregarLiquidacion.aspx">Agregar Liquidacion</a>
                            </div>
                            
                        </div>
                        <br />
                             <div class="overflow-x-auto relative shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="p-4">
                                        <div class="flex items-center">
                                            <input id="checkbox-all-search" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                            <label for="checkbox-all-search" class="sr-only">Nombre</label>
                                        </div>
                                    </th>
                                    <th scope="col" class="py-3 px-6">Fecha</th>
                                    <th scope="col" class="py-3 px-6">Rut Trabajador</th>
                                    <th scope="col" class="py-3 px-6">Otros Ingresos</th>
                                    <th scope="col" class="py-3 px-6">Total Remuneracion</th>
                                    <th scope="col" class="py-3 px-6">Total Haberes</th>
                                    <th scope="col" class="py-3 px-6">Cotizacion Previsional</th>
                                    <th scope="col" class="py-3 px-6">Cotizacion Salud</th>
                                    <th scope="col" class="py-3 px-6">Total Descuentos Previnsionales</th>
                                    <th scope="col" class="py-3 px-6">Otros Descuentos</th>
                                    <th scope="col" class="py-3 px-6">Dias No Trabajados</th>
                                    <th scope="col" class="py-3 px-6">Descuentos Dias No Trabajados</th>
                                    <th scope="col" class="py-3 px-6">Saldo Liquido</th>
                                    <th scope="col" class="py-3 px-6">Acciones</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    int totalLiquidaciones = 0;
                                    totalLiquidaciones = LiquidacionesDao.ObtenerTotalLiquidaciones();

                                    if (totalLiquidaciones == 0)
                                    {
                                %>
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <th colspan="8" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay gastos registrados en el mes 
                                    </th>
                                </tr>
                                <%
                                    }
                                    else
                                    {

                                        foreach (Liquidacion obj in LiquidacionesDao.GetAlLiquidaciones())
                                        {
                                %>
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <td class="p-4 w-4">
                                        <div class="flex items-center">
                                            <input id="checkbox-table-search-1" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                            <label for="checkbox-table-search-1" class="sr-only">Nombre</label>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6"><%=obj.Fecha.ToString("dd/MM/yyyy") %></td>
                                    <td class="py-4 px-6"><%=obj.RutTrabajador %></td>
                                    <td class="py-4 px-6">$<%=obj.OtrosIngresos %></td>
                                    <td class="py-4 px-6"><%=obj.TotalRemuneracion %>
                                    <td class="py-4 px-6"><%=obj.TotalHaberes %>
                                    <td class="py-4 px-6"><%=obj.CotizacionPrevisional %></td>
                                    <td class="py-4 px-6"><%=obj.CotizacionSalud %></td>
                                    <td class="py-4 px-6"><%=obj.TotalDescuentosPrevisionales %></td>
                                    <td class="py-4 px-6"><%=obj.OtrosDescuentos %></td>
                                    <td class="py-4 px-6"><%=obj.DiasNoTrabajados %></td>
                                    <td class="py-4 px-6"><%=obj.DescuentosDiasNoTrabajados %></td>
                                    <td class="py-4 px-6"><%=obj.SaldoLiquido %></td>
                                    <td class="py-4 px-6">
                                        <button type="button" data-id="<%=obj.Id %>" @click="openModal" class="btnEditar block w-full px-4 py-2 mt-4 text-sm text-center font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">Editar</button>
                                        <a href="EliminarIngreso.aspx?id=<%=obj.Id %>" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Elimnar</a>
                                    </td>
                                </tr>
                                <%}
                                    }%>
                            </tbody>
                        </table>
                       </div>
                    </div>
                </form>
            </main>
        </div>
    </div>
</body>
</html>
