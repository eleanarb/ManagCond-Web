﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GastosComunes.aspx.cs" Inherits="ManagCond.Administrador.GastosComunes" %>
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
    <script src="../assets/js/focus-trap.js" defer></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" defer></script>
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
                        <%DateTime fechaActual = System.DateTime.Now;
                            string mesActual = fechaActual.ToString("MMMM");
                            string añoActual = fechaActual.ToString("yyyy");%>
                        <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">GastosComunes de <%=mesActual %>-<%=añoActual %></h2>
                        <div class="">
                            <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                                <div class="grid grid-cols-6 text-center">
                                    <div class="">
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListDepto" runat="server" OnSelectedIndexChanged="Depto_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="">
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListMesF" runat="server" OnSelectedIndexChanged="Mes_SelectedIndexChanged" AutoPostBack="true">
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
                                    </div>
                                    <div class="">
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAñoF" runat="server" OnSelectedIndexChanged="Año_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="2019">2019</asp:ListItem>
                                            <asp:ListItem Value="2020">2020</asp:ListItem>
                                            <asp:ListItem Value="2022">2022</asp:ListItem>
                                            <asp:ListItem Value="2023">2023</asp:ListItem>
                                            <asp:ListItem Value="2024">2024</asp:ListItem>
                                            <asp:ListItem Value="2025">2025</asp:ListItem>
                                            <asp:ListItem Value="2026">2026</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div></div>
                                    <div class="col-end-4 align-middle">
                                        <a class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800" href="DetalleGastoComun.aspx">Descargar Colillas</a>
                                    </div>
                                    <div class="col-end-4 ">
                                        <asp:Button ID="ButtonAgregar" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Generar Gasto Comun" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
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
                                        <th scope="col" class="py-3 px-6">Mes De Cobro</th>
                                        <th scope="col" class="py-3 px-6">Unidad</th>
                                        <th scope="col" class="py-3 px-6">Gasto Comun</th>
                                        <th scope="col" class="py-3 px-6">Fondo Reserva</th>
                                        <th scope="col" class="py-3 px-6">Multas</th>
                                        <th scope="col" class="py-3 px-6">Varios</th>
                                        <th scope="col" class="py-3 px-6">Fecha Vancimiento</th>
                                        <th scope="col" class="py-3 px-6">Total a pagar</th>
                                        <th scope="col" class="py-3 px-6">Estado</th>
                                        <th scope="col" class="py-3 px-6">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        Usuario usuario = (Usuario)Session["usuario"];
                                        int idCond = (int)Session["idCondominio"];
                                        int mesActualN = (int)Session["mes"];
                                        int añoActualN = (int)Session["año"];
                                        string depto = (String)Session["depto"];
                                        int totalGastosComunes = 0;
                                        totalGastosComunes = GastosComunesDao.ObtenerTotalGastoComunes(idCond, mesActualN, añoActualN);
                                        if (totalGastosComunes == 0)
                                        {
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                        <th colspan="13" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay gastos registrados en el mes 
                                        </th>
                                    </tr>
                                    <%
                                        }
                                        else
                                        {
                                            foreach (GastosComunes obj in GastosComunesDao.GetAlGastosComunesV(usuario.IdCond, mesActualN, añoActualN, depto.ToString()))
                                            {
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td class="p-4 w-4">
                                            <div class="flex items-center">
                                                <input id="checkbox-table-search-1" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 rounded border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
                                                <label for="checkbox-table-search-1" class="sr-only">Nombre</label>
                                            </div>
                                        </td>
                                        <td class="py-4 px-6"><%=obj.MesCobro %></td>
                                        <td class="py-4 px-6"><%=obj.NumDpto %></td>
                                        <td class="py-4 px-6">$<%=obj.GastoComun.ToString("N0") %></td>
                                        <td class="py-4 px-6">$<%=obj.FondoReserva.ToString("N0") %></td>
                                        <td class="py-4 px-6">$<%=obj.Multas.ToString("N0") %></td>
                                        <td class="py-4 px-6">$<%=obj.Varios.ToString("N0")%></td>
                                        <td class="py-4 px-6"><%=obj.FechaVencimiento.ToString("dd/MM/yyyy") %></td>
                                        <td class="py-4 px-6">$<%=obj.TotalPagar.ToString("N0") %></td>
                                        <td class="py-4 px-6"><%=obj.Estado %></td>
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
