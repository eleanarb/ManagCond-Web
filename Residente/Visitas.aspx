<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Visitas.aspx.cs" Inherits="ManagCond.Residente.Visitas" %>
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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <!-- Demo styles -->
    <style>
        .swiper {
            width: 100%;
            height: 100%;
        }

        .swiper-slide {
            text-align: center;
            font-size: 18px;
        }

            .swiper-slide img {
                display: block;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
    </style>
</head>
<body>
    <div
        class="flex h-screen bg-gray-50 dark:bg-gray-900"
        :class="{ 'overflow-hidden': isSideMenuOpen }"/>
        <!-- #include file ="Template/AsideResidente.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderResidente.html" -->
            <main class="h-full pb-16 overflow-y-auto">
                <form runat="server">
                <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Visitas Pendientes</h2>
                        <div class="swiper mySwiper" id="reservas-pendientes">
                            <div class="swiper-wrapper">
                                <%=""%>
                                <%
                                    Usuario usuario = (Usuario)Session["usuario"];

                                    int totalVisitasP = VisitaDao.ObtenerTotalVisitasPendientes(int.Parse(usuario.numDpto));

                                    if (totalVisitasP == 0)
                                    { %>

                                <div class="flex-1 p-6">
                                    <div class="text-center py-24 text-gray-500 dark:text-slate-400">
                                        <p>No hay visitas pendientes</p>
                                    </div>
                                </div>
                                <% }
                                    else
                                    {
                                        Usuario usuario2 = (Usuario)Session["usuario"];
                                        foreach (Visita obj1 in VisitaDao.GetAlVisitaPendiente(int.Parse(usuario2.NumDpto), usuario2.IdCond))
                                        {
                                            int idVisita = obj1.Id;
                                            string fecha = obj1.Fecha.ToString("ddd dd  MMMM  yyyy");
                                %>

                                <div class="swiper-slide">
                                    <div
                                        class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800">
                                        <h2 class="font-semibold text-gray-700 dark:text-gray-200"><strong>Dpto<%=obj1.NumDpto %></strong></h2>
                                        <i class="mb-4 text-gray-600 dark:text-gray-400"><%=obj1.Rut%> - <%=obj1.Nombres %> <%=obj1.Apellidos %> </i>
                                        <br />
                                        <p class="mb-4 text-gray-600 dark:text-gray-400">
                                            <%=fecha %>
                                            <br />
                                            <%=obj1.Patente %>
                                        </p>
                                        <button type="button" data-id="<%=idVisita%>"  data-modal-toggle="popup-modalVisita"
                                            class="btnVisita px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">
                                            Modificar
                                        </button>
                                    </div>
                                </div>
                                <%}
                                    }%>
                            </div>
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-pagination"></div>
                        </div>
                       <div class="grid grid-cols-4 gap-4">
                           <div>
                               <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Historial de visitas</h2>
                           </div>
                       </div>
                       <!-- CTA -->
                       <div class="">
                           <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                               <div class="grid grid-cols-6 items-center">
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
                                   <div class="">
                                   </div>
                                   <div></div>
                                   <div class="col-end-4 ">
                                   </div>
                                   <div class="col-end-4 ">
                                      <button id="buttonList" type="button" @click="openModal" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">Agregar Visita</button>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <br>
                    <!-- CTA -->
                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="py-3 px-6">Departamento</th>
                                        <th scope="col" class="py-3 px-6">Rut</th>
                                        <th scope="col" class="py-3 px-6">Nombres</th>
                                        <th scope="col" class="py-3 px-6">Apellidos</th>
                                        <th scope="col" class="py-3 px-6">Fecha</th>
                                        <th scope="col" class="py-3 px-6">Hora</th>
                                        <th scope="col" class="py-3 px-6">Patente</th>
                                        <th scope="col" class="py-3 px-6">Estado</th>
                                        <th scope="col" class="py-3 px-6">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int mesActualN = (int)Session["mes"];
                                        int añoActualN = (int)Session["año"];

                                        foreach (Visita obj in VisitaDao.GetAlVisitaRegistrada(int.Parse(usuario.NumDpto), usuario.IdCond, mesActualN, añoActualN))
                                        {
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td class="py-4 px-6"><%= obj.NumDpto %> </td>
                                        <td class="py-4 px-6"><%= obj.Rut %> </td>
                                        <td class="py-4 px-6"><%= obj.Nombres %> </td>
                                        <td class="py-4 px-6"><%= obj.Apellidos %> </td>
                                        <td class="py-4 px-6"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                        <td class="py-4 px-6"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                        <td class="py-4 px-6"><%= obj.Patente %> </td>
                                        <td class="py-4 px-6"><%if (obj.Estado.Equals("Pendiente"))
                                                                  {%>
                                            <span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente</span>
                                            <%}
                                                else
                                                {
                                                    if (obj.Estado.Equals("Registrado"))
                                                    {%>
                                            <span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Registrado</span>
                                            <%}
                                                else
                                                {
                                                    if (obj.Estado.Equals("Aprobado"))
                                                    { %>
                                            <span class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">Aprobado</span>
                                            <%}
                                                else
                                                {%>
                                            <span class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700">Rechazado</span>
                                            <%}
                                                    }
                                                }%> 
                                        </td>
                                        <td class="px-4 py-3 text-xs"><%if (obj.Estado.Equals("Registrado"))
      {%>                                    <a class="text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800" href="EditarVisita.aspx?id=<%= obj.Id %>">
                                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg></a>
                                            <button type="button" data-id="<%=obj.Id %>" data-modal-toggle="popup-modal" class="btnEliminar text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>
                                            <%} %>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <div
                            class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800">
                            <span class="flex items-center col-span-3">Showing 1-30 of 100
                            </span>
                            <span class="col-span-2"></span>
                            <!-- Pagination -->
                            <span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
                                <nav aria-label="Table navigation">
                                    <ul class="inline-flex items-center">
                                        <li>
                                            <button
                                                class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple"
                                                aria-label="Previous">
                                                <svg
                                                    aria-hidden="true"
                                                    class="w-4 h-4 fill-current"
                                                    viewBox="0 0 20 20">
                                                    <path
                                                        d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                                        clip-rule="evenodd"
                                                        fill-rule="evenodd">
                                                    </path>
                                                </svg>
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                class="px-3 py-1 text-white transition-colors duration-150 bg-purple-600 border border-r-0 border-purple-600 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                1
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                2
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                3
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                4
                                            </button>
                                        </li>
                                        <li>
                                            <span class="px-3 py-1">...</span>
                                        </li>
                                        <li>
                                            <button
                                                class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                8
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                9
                                            </button>
                                        </li>
                                        <li>
                                            <button
                                                class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple"
                                                aria-label="Next">
                                                <svg
                                                    class="w-4 h-4 fill-current"
                                                    aria-hidden="true"
                                                    viewBox="0 0 20 20">
                                                    <path
                                                        d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                                        clip-rule="evenodd"
                                                        fill-rule="evenodd">
                                                    </path>
                                                </svg>
                                            </button>
                                        </li>
                                    </ul>
                                </nav>
                            </span>
                        </div>
                    </div>
                </div>
                    <div class="container grid px-6 mx-auto">
                        <div class="grid grid-cols-4 gap-4">
                            <div>
                                <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Historial de visitas</h2>
                            </div>
                        </div>
                        <!-- CTA -->
                        <div class="">
                            <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                                <div class="grid grid-cols-6 items-center">
                                    <div class="">
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListMesF2" runat="server" OnSelectedIndexChanged="Mes_SelectedIndexChanged" AutoPostBack="true">
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
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAñoF2" runat="server" OnSelectedIndexChanged="Año_SelectedIndexChanged" AutoPostBack="true">
                                            <asp:ListItem Value="2019">2019</asp:ListItem>
                                            <asp:ListItem Value="2020">2020</asp:ListItem>
                                            <asp:ListItem Value="2022">2022</asp:ListItem>
                                            <asp:ListItem Value="2023">2023</asp:ListItem>
                                            <asp:ListItem Value="2024">2024</asp:ListItem>
                                            <asp:ListItem Value="2025">2025</asp:ListItem>
                                            <asp:ListItem Value="2026">2026</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="">
                                    </div>
                                    <div></div>
                                    <div class="col-end-4 ">
                                    </div>
                                    <div class="col-end-4 ">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <!-- CTA -->
                        <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                            <div class="w-full overflow-x-auto">
                                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                        <tr>
                                            <th scope="col" class="py-3 px-6">Departamento</th>
                                            <th scope="col" class="py-3 px-6">Rut</th>
                                            <th scope="col" class="py-3 px-6">Nombres</th>
                                            <th scope="col" class="py-3 px-6">Apellidos</th>
                                            <th scope="col" class="py-3 px-6">Fecha</th>
                                            <th scope="col" class="py-3 px-6">Hora</th>
                                            <th scope="col" class="py-3 px-6">Patente</th>
                                            <th scope="col" class="py-3 px-6">Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            int mesActualN2 = (int)Session["mes2"];
                                            int añoActualN2 = (int)Session["año2"];

                                            foreach (Visita obj in VisitaDao.ObtenerDatosVisita(int.Parse(usuario.NumDpto), usuario.IdCond, mesActualN2, añoActualN2))
                                            {
                                        %>
                                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                            <td class="py-4 px-6"><%= obj.NumDpto %> </td>
                                            <td class="py-4 px-6"><%= obj.Rut %> </td>
                                            <td class="py-4 px-6"><%= obj.Nombres %> </td>
                                            <td class="py-4 px-6"><%= obj.Apellidos %> </td>
                                            <td class="py-4 px-6"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                            <td class="py-4 px-6"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                            <td class="py-4 px-6"><%= obj.Patente %> </td>
                                            <td class="py-4 px-6"><%if (obj.Estado.Equals("Pendiente"))
                                                                      { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente</span><%}
                                                                    else
                                                                    {
                                                                    if (obj.Estado.Equals("Registrado"))
                                                                    { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Registrado</span><%}
                                                                    else
                                                                    {
                                                                    if (obj.Estado.Equals("Aprobado"))
                                                                    { %><span class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">Aprobado</span><%}
                                                                    else
                                                                    {%><span class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700">Rechazado</span> <%}
                                                                    }
                                                                    }%> </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <div
                                class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800">
                                <span class="flex items-center col-span-3">Showing 1-30 of 100
                                </span>
                                <span class="col-span-2"></span>
                                <!-- Pagination -->
                                <span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
                                    <nav aria-label="Table navigation">
                                        <ul class="inline-flex items-center">
                                            <li>
                                                <button
                                                    class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple"
                                                    aria-label="Previous">
                                                    <svg
                                                        aria-hidden="true"
                                                        class="w-4 h-4 fill-current"
                                                        viewBox="0 0 20 20">
                                                        <path
                                                            d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                                            clip-rule="evenodd"
                                                            fill-rule="evenodd">
                                                        </path>
                                                    </svg>
                                                </button>
                                            </li>
                                            <li>
                                                <button
                                                    class="px-3 py-1 text-white transition-colors duration-150 bg-purple-600 border border-r-0 border-purple-600 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                    1
                                                </button>
                                            </li>
                                            <li>
                                                <button
                                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                    2
                                                </button>
                                            </li>
                                            <li>
                                                <button
                                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                    3
                                                </button>
                                            </li>
                                            <li>
                                                <button
                                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                    4
                                                </button>
                                            </li>
                                            <li>
                                                <span class="px-3 py-1">...</span>
                                            </li>
                                            <li>
                                                <button
                                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                    8
                                                </button>
                                            </li>
                                            <li>
                                                <button
                                                    class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple">
                                                    9
                                                </button>
                                            </li>
                                            <li>
                                                <button
                                                    class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple"
                                                    aria-label="Next">
                                                    <svg
                                                        class="w-4 h-4 fill-current"
                                                        aria-hidden="true"
                                                        viewBox="0 0 20 20">
                                                        <path
                                                            d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                                            clip-rule="evenodd"
                                                            fill-rule="evenodd">
                                                        </path>
                                                    </svg>
                                                </button>
                                            </li>
                                        </ul>
                                    </nav>
                                </span>
                            </div>
                        </div>
                                                        </div>
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
            @keydown.escape="closeModal"
            class="w-full px-6 py-4 overflow-hidden bg-white rounded-t-lg dark:bg-gray-800 sm:rounded-lg sm:m-4 sm:max-w-xl"
            role="dialog"
            id="modal">
        <!-- Remove header if you don't want a close icon. Use modal body to place modal tile. -->
          <header class="flex justify-end">
              <button
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
            <div class="mt-4 mb-6">
                <!-- Modal title -->
                <p class="mb-2 text-lg font-semibold text-gray-700 dark:text-gray-300">Agregar Visita </p>
                <!-- Modal description -->
                <div class="w-full">
                    <label class="block text-sm">
                        <asp:DropDownList hidden="true" class="mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-multiselect focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownList" runat="server" disabled="true">
                        </asp:DropDownList>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Rut</span>
                        <asp:TextBox ID="TextBoxRut" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Nombres</span>
                        <asp:TextBox ID="TextBoxNombres" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                    </label>
                    <span id="mensajeNombres" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Apellidos</span>
                        <asp:TextBox ID="TextBoxApellidos" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                    </label>
                    <span id="mensajeApellidos" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Patente</span>
                        <asp:TextBox ID="TextBoxPatente" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                    </label>
                        <span class="text-gray-700 dark:text-gray-400">Fecha</span>
                        <div class="relative">
                            <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                            </div>
                            <input datepicker datepicker-autohide datepicker-format="dd-mm-yyyy" id="TextBoxFecha" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Seleccione fecha" runat="server" />
                        </div>
                    <span id="mensajeFecha" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                    <br />
                    <br />
                </div>
                <footer class="flex flex-col items-center justify-end px-6 py-3 -mx-6 -mb-4 space-y-4 sm:space-y-0 sm:space-x-6 sm:flex-row bg-gray-50 dark:bg-gray-800">
                    <button @click="closeModal" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Cancel</button>
                    <asp:Button ID="ButtonAgregar" OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                </footer>
            </div>
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
                                    <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Desea eliminar la visita?</h3>
                                    <asp:Button ID="ButtonEliminar" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2" runat="server" data-id="0" OnClick="ButtonEliminar_Click" Text="Eliminar" />
                                    <input type="hidden" id="TextBoxIdEliminar" name="TextBoxIdEliminar" value="0" runat="server">
                                    <button data-modal-toggle="popup-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End of modal backdrop -->
                    <div id="popup-modalVisita" tabindex="-1" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 md:inset-0 h-modal md:h-full">
                        <div class="relative p-4 w-full max-w-md h-full md:h-auto">
                            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                                <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white" data-modal-toggle="popup-modalVisita">
                                    <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                    <span class="sr-only">Close modal</span>
                                </button>
                                <div class="p-6 text-center">
                                    <input type="hidden" id="idVisita" name="TextBoxId" value="0" runat="server">
                                    <!-- Modal title -->
                                    <p class="mb-2 text-lg font-semibold text-gray-700 dark:text-gray-300" id="depto">
                                        depto
                                    </p>
                                    <!-- Modal description -->
                                    <p class="text-sm text-gray-700 dark:text-gray-400" id="rutNombre">
                                        rut-Nombre
                                    </p>
                                    <p class="text-sm text-gray-700 dark:text-gray-400" id="fecha">
                                        fecha
                                    </p>
                                    <asp:Button ID="ButtonAprobar" class="focus:outline-none text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:ring-green-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800" runat="server" OnClick="ButtonAprobar_Click" Text="Aprobar" />
                                    <asp:Button ID="ButtonRechazar" class="focus:outline-none text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900" runat="server" OnClick="ButtonRechazar_Click" Text="Rechazar" />
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
    <script>
        var letras = /^[a-zA-Z]+$/;

        $('#TextBoxNombres').on('keyup', function () {
            if (!letras.test($('#TextBoxNombres').val())) {
                $('#mensajeNombres').html('Ingrese nombres de manera correcta').css('color', 'red');

            } else
                $('#mensajeNombres').html('').css('color', 'green');
        });
        $('#TextBoxApellidos').on('keyup', function () {
            if (!letras.test($('#TextBoxApellidos').val())) {
                $('#mensajeApellidos').html('Ingrese apellidos de manera correcta').css('color', 'red');

            } else
                $('#mensajeApellidos').html('').css('color', 'green');
        });
        $('#TextBoxFecha').on('keyup', function () {
            if ($('#TextBoxFecha').val().length < 1) {
                $('#mensajeFecha').html('Ingrese fecha').css('color', 'red');

            } else
                $('#mensajeFecha').html('').css('color', 'green');
        });
    </script>
    <script>
        function validarFormulario(evento) {
            if (!letras.test($('#TextBoxNombres').val())) {
                $('#mensajeNombres').html('Ingrese nombres de manera correcta').css('color', 'red');
                return false;
            } else {
            }
            if (!letras.test($('#TextBoxApellidos').val())) {
                $('#mensajeApellidos').html('Ingrese apellidos de manera correcta').css('color', 'red');
                return false;
            } else {
            }
            var fecha = document.getElementById('TextBoxFecha').value;
            if (fecha.length < 1) {
                $('#mensajeFecha').html('Ingrese fecha').css('color', 'red');
                return false;
            } else {
                $('#mensajeFecha').html('').css('color', 'green');
                return true;
            }
        }
    </script>
    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
    <!-- Initialize Swiper -->
    <script>
        var swiper = new Swiper(".mySwiper", {
            slidesPerView: 3,
            spaceBetween: 30,
            slidesPerGroup: 3,
            loop: true,
            loopFillGroupWithBlank: true,
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
        });
    </script>
    <script>
        let editar = document.querySelectorAll(".btnVisita")

        editar.forEach((boton) => {
            boton.addEventListener("click", (event) => {
                event.preventDefault()
                var visita = event.target.parentElement

                depto = visita.querySelector('h2').textContent
                rutNombre = visita.querySelector('i').textContent
                fecha = visita.querySelector('p').textContent
                id = visita.querySelector('.btnVisita').getAttribute('data-id')

                document.querySelector('#depto').innerText = depto;
                document.querySelector('#rutNombre').innerText = rutNombre;
                document.querySelector('#fecha').innerText = fecha;
                document.querySelector('#idVisita').value = id;

            })
        })
    </script>
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

    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
</body>
</html>
