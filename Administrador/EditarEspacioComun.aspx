<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarEspacioComun.aspx.cs" Inherits="ManagCond.Administrador.EditarEspacioComun" %>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
                        <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Editar espacio comun</h2>
                        <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                            <div class="grid gap-6 mb-8 md:grid-cols-3">
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                        <asp:TextBox ID="TextBoxNombre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeNombre" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Descripcion</span>
                                        <asp:TextBox ID="TextBoxDesc" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeDesc" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Monto</span>
                                        <asp:TextBox ID="TextBoxMonto" type="number" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeMonto" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <span id="mensajeRangoHorario" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                            <div class="grid gap-6 mb-8 md:grid-cols-4">
                                <div class="col-end-7 col-span-2">
                                    <asp:Button ID="ButtonAgregar" OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonModificar_Click" Text="Modificar" />
                                </div>
                            </div>
                        </div>
                        
                        <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Rango Horarios</h2>
                        <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                            <div class="grid grid-cols-2 items-center">
                                <div class="grid grid-cols-2">
                                    <div class="">
                                        <label for="default-search" class="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-gray-300">Search</label>
                                        <div class="relative">
                                            <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                                <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                            </div>
                                            <input type="search" id="default-search" class="block p-4 pl-10 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Buscar por nombre">
                                            <button type="submit" class="text-white absolute right-2.5 bottom-2.5 bg-purple-600 hover:bg-purple-700 focus:ring-4 focus:outline-none focus:ring-purple-300 font-medium rounded-lg text-sm px-4 py-2">Buscar</button>
                                        </div>
                                    </div>
                                    <div class="">
                                    </div>
                                </div>
                                <div class="grid grid-cols-4">
                                    <div></div>
                                    <div></div>
                                    <div class="">
                                    </div>
                                    <div class="">
                                        <button id="btnagregar" type="button" onclick="mostrar();"
                                            class="block w-full px-4 py-2 mt-4 text-sm text-center font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">
                                            Agregar rango horario</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="overflow-x-auto relative shadow-md sm:rounded-lg">

                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="py-3 px-6">Hora inicio</th>
                                        <th scope="col" class="py-3 px-6">Hora fin</th>
                                        <th scope="col" class="py-3 px-6">Acciones</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <tr id="filaAgregar" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">

                                        <th class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            <label for="DropDownListHoraIncio" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Hora inicio</label>
                                            <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListHoraIncio" runat="server">
                                                <asp:ListItem Selected="True" Value="0">Seleccione hora inicio:</asp:ListItem>
                                                <asp:ListItem Value="00:00">00:00</asp:ListItem>
                                                <asp:ListItem Value="01:00">01:00</asp:ListItem>
                                                <asp:ListItem Value="02:00">02:00</asp:ListItem>
                                                <asp:ListItem Value="03:00">03:00</asp:ListItem>
                                                <asp:ListItem Value="04:00">04:00</asp:ListItem>
                                                <asp:ListItem Value="05:00">05:00</asp:ListItem>
                                                <asp:ListItem Value="06:00">06:00</asp:ListItem>
                                                <asp:ListItem Value="07:00">07:00</asp:ListItem>
                                                <asp:ListItem Value="08:00">08:00</asp:ListItem>
                                                <asp:ListItem Value="09:00">09:00</asp:ListItem>
                                                <asp:ListItem Value="10:00">10:00</asp:ListItem>
                                                <asp:ListItem Value="11:00">11:00</asp:ListItem>
                                                <asp:ListItem Value="12:00">12:00</asp:ListItem>
                                                <asp:ListItem Value="13:00">13:00</asp:ListItem>
                                                <asp:ListItem Value="14:00">14:00</asp:ListItem>
                                                <asp:ListItem Value="15:00">15:00</asp:ListItem>
                                                <asp:ListItem Value="15:00">16:00</asp:ListItem>
                                                <asp:ListItem Value="17:00">17:00</asp:ListItem>
                                                <asp:ListItem Value="18:00">18:00</asp:ListItem>
                                                <asp:ListItem Value="19:00">19:00</asp:ListItem>
                                                <asp:ListItem Value="20:00">20:00</asp:ListItem>
                                                <asp:ListItem Value="21:00">21:00</asp:ListItem>
                                                <asp:ListItem Value="22:00">22:00</asp:ListItem>
                                                <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                            </asp:DropDownList>
                                            <span id="mensajeHoraInicio" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                        </th>
                                        <td class="py-4 px-6">
                                            <label for="DropDownListHoraFin" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Hora fin</label>
                                            <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListHoraFin" runat="server">
                                                <asp:ListItem Selected="True" Value="0">Seleccione hora fin:</asp:ListItem>
                                                <asp:ListItem Value="00:00">00:00</asp:ListItem>
                                                <asp:ListItem Value="01:00">01:00</asp:ListItem>
                                                <asp:ListItem Value="02:00">02:00</asp:ListItem>
                                                <asp:ListItem Value="03:00">03:00</asp:ListItem>
                                                <asp:ListItem Value="04:00">04:00</asp:ListItem>
                                                <asp:ListItem Value="05:00">05:00</asp:ListItem>
                                                <asp:ListItem Value="06:00">06:00</asp:ListItem>
                                                <asp:ListItem Value="07:00">07:00</asp:ListItem>
                                                <asp:ListItem Value="08:00">08:00</asp:ListItem>
                                                <asp:ListItem Value="09:00">09:00</asp:ListItem>
                                                <asp:ListItem Value="10:00">10:00</asp:ListItem>
                                                <asp:ListItem Value="11:00">11:00</asp:ListItem>
                                                <asp:ListItem Value="12:00">12:00</asp:ListItem>
                                                <asp:ListItem Value="13:00">13:00</asp:ListItem>
                                                <asp:ListItem Value="14:00">14:00</asp:ListItem>
                                                <asp:ListItem Value="15:00">15:00</asp:ListItem>
                                                <asp:ListItem Value="15:00">16:00</asp:ListItem>
                                                <asp:ListItem Value="17:00">17:00</asp:ListItem>
                                                <asp:ListItem Value="18:00">18:00</asp:ListItem>
                                                <asp:ListItem Value="19:00">19:00</asp:ListItem>
                                                <asp:ListItem Value="20:00">20:00</asp:ListItem>
                                                <asp:ListItem Value="21:00">21:00</asp:ListItem>
                                                <asp:ListItem Value="22:00">22:00</asp:ListItem>
                                                <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                            </asp:DropDownList>
                                            <span id="mensajeHoraFin" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                        </td>
                                        <td class="py-4 px-6 grid grid-rows-4 text-center">
                                            <div>
                                                <asp:Button ID="Button1" OnClientClick="return validarFormulario2()" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purplee" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                                            </div>
                                            <br />
                                            <div>
                                                <a style="cursor: pointer; text-decoration-line: underline;" onclick="ocultar();" class="font-medium text-red-600 dark:text-red-500 hover:underline">Cancelar</a>

                                            </div>
                                        </td>
                                    </tr>
                                    <% 
                                        int idCondominio = 0;
                                        idCondominio = (int)Session["idCondominio"];

                                        int totalRangoHorario = 0;
                                        int id = int.Parse(Request.QueryString["id"]);
                                        totalRangoHorario = EspacioComunDao.ObtenerTotalRangoHorario(id, idCondominio);

                                        if (totalRangoHorario == 0)
                                        {
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                        <th colspan="5" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay rango horario asignado
                                        </th>
                                    </tr>
                                    <%
                                        }
                                        else
                                        {
                                            foreach (RangoHorario obj in EspacioComunDao.GetAlRangoHorario(id, idCondominio))
                                            {
                                                string[] rangoHorario = obj.RangoHora.Split('-');
                                                string horaInicio = rangoHorario[0];
                                                string horaFin = rangoHorario[1];
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td class="py-4 px-6"><%=horaInicio%></td>
                                        <td class="py-4 px-6"><%=horaFin %></td>
                                        <td class="py-4 px-6 md:grid-cols-2">
                                            <button type="button" data-id="<%=obj.Id %>" @click="openModal" class="btnEditar text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </button>
                                            <button type="button" data-modal-toggle="popup-modal" data-id="<%=obj.Id %>" class="btnEliminar text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                        </td>
                                    </tr>
                                    <%}
                                        }%>
                                </tbody>
                            </table>
                        </div>
                    <br />
                    <br />
                    <!-- Modal backdrop. This what you want to place close to the closing body tag -->
                    <div
                        x-show="isModalOpen"
                        x-transition:enter="transition ease-out duration-150"
                        x-transition:enter-start="opacity-0"
                        x-transition:enter-end="opacity-100"
                        x-transition:leave="transition ease-in duration-150"
                        x-transition:leave-start="opacity-100"
                        x-transition:leave-end="opacity-0"
                        class="fixed inset-0 z-30 flex items-end bg-black bg-opacity-50 sm:items-center sm:justify-center">
                        <!-- Modal -->
                        <div
                            x-show="isModalOpen"
                            x-transition:enter="transition ease-out duration-150"
                            x-transition:enter-start="opacity-0 transform translate-y-1/2"
                            x-transition:enter-end="opacity-100"
                            x-transition:leave="transition ease-in duration-150"
                            x-transition:leave-start="opacity-100"
                            x-transition:leave-end="opacity-0  transform translate-y-1/2"
                            @click.away="closeModal"
                            @keydown.escape="closeModal" 
                            class="w-full px-6 py-4 overflow-hidden bg-white rounded-t-lg dark:bg-gray-800 sm:rounded-lg sm:m-4 sm:max-w-xl"
                            role="dialog"
                            id="modal">
                            <!-- Remove header if you don't want a close icon. Use modal body to place modal tile. -->
                            <header class="flex justify-end">
                                <button type="button"
                                    class="inline-flex items-center justify-center w-6 h-6 text-gray-400 transition-colors duration-150 rounded dark:hover:text-gray-200 hover: hover:text-gray-700"
                                    aria-label="close"
                                    @click="closeModal">
                                    <svg
                                        class="w-4 h-4"
                                        fill="currentColor"
                                        viewBox="0 0 20 20"
                                        role="img"
                                        aria-hidden="true">
                                        <path
                                            d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                            clip-rule="evenodd"
                                            fill-rule="evenodd">
                                        </path>
                                    </svg>
                                </button>
                            </header>
                            <!-- Modal body -->
                            <div class="mt-4 mb-6 grid">
                                <div class="grid gap-6 mb-8 md:grid-cols-2">
                                    <div>
                                        <label for="DropDownListHoraIncioModal" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Hora inicio</label>
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListHoraIncioModal" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Seleccione hora inicio:</asp:ListItem>
                                            <asp:ListItem Value="00:00">00:00</asp:ListItem>
                                            <asp:ListItem Value="01:00">01:00</asp:ListItem>
                                            <asp:ListItem Value="02:00">02:00</asp:ListItem>
                                            <asp:ListItem Value="03:00">03:00</asp:ListItem>
                                            <asp:ListItem Value="04:00">04:00</asp:ListItem>
                                            <asp:ListItem Value="05:00">05:00</asp:ListItem>
                                            <asp:ListItem Value="06:00">06:00</asp:ListItem>
                                            <asp:ListItem Value="07:00">07:00</asp:ListItem>
                                            <asp:ListItem Value="08:00">08:00</asp:ListItem>
                                            <asp:ListItem Value="09:00">09:00</asp:ListItem>
                                            <asp:ListItem Value="10:00">10:00</asp:ListItem>
                                            <asp:ListItem Value="11:00">11:00</asp:ListItem>
                                            <asp:ListItem Value="12:00">12:00</asp:ListItem>
                                            <asp:ListItem Value="13:00">13:00</asp:ListItem>
                                            <asp:ListItem Value="14:00">14:00</asp:ListItem>
                                            <asp:ListItem Value="15:00">15:00</asp:ListItem>
                                            <asp:ListItem Value="15:00">16:00</asp:ListItem>
                                            <asp:ListItem Value="17:00">17:00</asp:ListItem>
                                            <asp:ListItem Value="18:00">18:00</asp:ListItem>
                                            <asp:ListItem Value="19:00">19:00</asp:ListItem>
                                            <asp:ListItem Value="20:00">20:00</asp:ListItem>
                                            <asp:ListItem Value="21:00">21:00</asp:ListItem>
                                            <asp:ListItem Value="22:00">22:00</asp:ListItem>
                                            <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                        </asp:DropDownList>
                                        <span id="mensajeHoraInicioModal" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                    </div>
                                    <div>
                                        <label for="DropDownListHoraFinMdoal" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Hora fin</label>
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListHoraFinMdoal" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Seleccione hora fin:</asp:ListItem>
                                            <asp:ListItem Value="00:00">00:00</asp:ListItem>
                                            <asp:ListItem Value="01:00">01:00</asp:ListItem>
                                            <asp:ListItem Value="02:00">02:00</asp:ListItem>
                                            <asp:ListItem Value="03:00">03:00</asp:ListItem>
                                            <asp:ListItem Value="04:00">04:00</asp:ListItem>
                                            <asp:ListItem Value="05:00">05:00</asp:ListItem>
                                            <asp:ListItem Value="06:00">06:00</asp:ListItem>
                                            <asp:ListItem Value="07:00">07:00</asp:ListItem>
                                            <asp:ListItem Value="08:00">08:00</asp:ListItem>
                                            <asp:ListItem Value="09:00">09:00</asp:ListItem>
                                            <asp:ListItem Value="10:00">10:00</asp:ListItem>
                                            <asp:ListItem Value="11:00">11:00</asp:ListItem>
                                            <asp:ListItem Value="12:00">12:00</asp:ListItem>
                                            <asp:ListItem Value="13:00">13:00</asp:ListItem>
                                            <asp:ListItem Value="14:00">14:00</asp:ListItem>
                                            <asp:ListItem Value="15:00">15:00</asp:ListItem>
                                            <asp:ListItem Value="15:00">16:00</asp:ListItem>
                                            <asp:ListItem Value="17:00">17:00</asp:ListItem>
                                            <asp:ListItem Value="18:00">18:00</asp:ListItem>
                                            <asp:ListItem Value="19:00">19:00</asp:ListItem>
                                            <asp:ListItem Value="20:00">20:00</asp:ListItem>
                                            <asp:ListItem Value="21:00">21:00</asp:ListItem>
                                            <asp:ListItem Value="22:00">22:00</asp:ListItem>
                                            <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                        </asp:DropDownList>
                                        <span id="mensajeHoraFinModal" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                    </div>
                                </div>
                            </div>
                            <footer class="flex flex-col items-center justify-end px-6 py-3 -mx-6 -mb-4 space-y-4 sm:space-y-0 sm:space-x-6 sm:flex-row bg-gray-50 dark:bg-gray-800">
                                <asp:Button ID="ButtonModificarRango" OnClientClick="return validarFormulario()" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purplee" runat="server" OnClick="ButtonModificarRango_Click" data-id="0" Text="Modificar" />
                                <input type="hidden" id="TextBoxId" name="TextBoxId" value="0" runat="server">
                            </footer>

                        </div>
                    </div>
                    <!-- End of modal backdrop -->
                        <div id="popup-modal" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full">
                            <div class="relative p-4 w-full max-w-md h-full md:h-auto">
                                <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                                    <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white" data-modal-toggle="popup-modal">
                                        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                        <span class="sr-only">Close modal</span>
                                    </button>
                                    <div class="p-6 text-center">
                                        <svg aria-hidden="true" class="mx-auto mb-4 w-14 h-14 text-gray-400 dark:text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                        <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Desea eliminar el rango horario?</h3>
                                        <asp:Button ID="ButtonEliminar" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2" runat="server" data-id="0" OnClick="ButtoEliminar_Click" Text="Eliminar" />
                                        <input type="hidden" id="TextBoxIdEliminar" name="TextBoxIdEliminar" value="0" runat="server">
                                        <button data-modal-toggle="popup-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Cancelar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
    </div>
    <script>
        let eliminar = document.querySelectorAll(".btnEliminar")

        eliminar.forEach((botonE) => {
            botonE.addEventListener("click", (eventE) => {
                eventE.preventDefault()
                var filaE = eventE.target.parentElement.parentElement.parentElement

                let idE = filaE.querySelector('.btnEliminar').getAttribute('data-id')
                document.querySelector('#TextBoxIdEliminar').value = idE;
            })

        })
    </script>
    <script>
        document.getElementById('filaAgregar').style.display = 'none';
        document.etElementsByClassName('guardarCambios').style.display = 'none';
        function mostrar() {
            document.getElementById('filaAgregar').style.display = '';
        }

        function ocultar() {
            document.getElementById('filaAgregar').style.display = 'none';
        }
    </script>
    <script>
        let editar = document.querySelectorAll(".btnEditar")

        editar.forEach((boton) => {
            boton.addEventListener("click", (event) => {
                event.preventDefault()
                var fila = event.target.parentElement.parentElement.parentElement
                let horaInicio = fila.children[0].innerHTML
                let horaFin = fila.children[1].innerHTML

                let id = fila.querySelector('.btnEditar').getAttribute('data-id')

                document.querySelector('#DropDownListHoraIncioModal').value = horaInicio;
                document.querySelector('#DropDownListHoraFinMdoal').value = horaFin;
                document.querySelector('#TextBoxId').value = id;
                document.querySelector('#ButtonModificarRango').setAttribute('data-id', id)
            })
        })
    </script>
    <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
    <script>
        var letras = /[a-zA-Z ]+$/;
        var numeros = /^[0-9]+$/;

        $('#TextBoxNombre').on('keyup', function () {
            if (!letras.test($('#TextBoxNombre').val())) {
                $('#mensajeNombre').html('Ingrese nombre de manera correcta').css('color', 'red');

            } else
                $('#mensajeNombre').html('').css('color', 'green');
        });
        $('#TextBoxDesc').on('keyup', function () {
            if (!letras.test($('#TextBoxDesc').val())) {
                $('#mensajeDesc').html('Ingrese descripcion de manera correcta').css('color', 'red');

            } else
                $('#mensajeDesc').html('').css('color', 'green');
        });
        $('#TextBoxMonto').on('keyup', function () {
            if (!numeros.test($('#TextBoxMonto').val())) {
                $('#mensajeMonto').html('Ingrese monto de manera correcta').css('color', 'red');

            } else
                $('#mensajeMonto').html('').css('color', 'green');
        });
    </script>
    <script>
        function validarFormulario2(evento) {
            if (!letras.test($('#TextBoxNombre').val())) {
                $('#mensajeNombre').html('Ingrese nombre de manera correcta').css('color', 'red');
                return false;
            } else {
            }
            if (!letras.test($('#TextBoxDesc').val())) {
                $('#mensajeDesc').html('Ingrese descripcion de manera correcta').css('color', 'red');
                return false;
            } else {
            }
            if (!numeros.test($('#TextBoxMonto').val())) {
                $('#mensajeMonto').html('Ingrese monto de manera correcta').css('color', 'red');
                return false;
            } else {
            }
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
</body>
</html>