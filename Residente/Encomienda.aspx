﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Encomienda.aspx.cs" Inherits="ManagCond.Residente.Encomienda" %>
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
    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
  </head>
<body>
       <div
        class="flex h-screen bg-gray-50 dark:bg-gray-900"
        :class="{ 'overflow-hidden': isSideMenuOpen }">
        <!-- #include file ="Template/AsideResidente.html" -->
           <div class="flex flex-col flex-1 w-full">
               <!-- #include file ="Template/HeaderResidente.html" -->
               <main class="h-full pb-16 overflow-y-auto">
                   <form runat="server">
                       <div class="container grid px-6 mx-auto">
                       <div class="grid grid-cols-4 gap-4">
                           <div>
                               <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Listado de Encomiendas</h2>
                           </div>
                           <br>
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
                                   </div>
                               </div>
                           </div>
                       </div>
                       <br>
                       <%=""%>
                       <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                           <div class="w-full overflow-x-auto">
                               <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                   <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                       <tr>
                                           <th scope="col" class="py-3 px-6">Departamento</th>
                                           <th scope="col" class="py-3 px-6">Recepcion</th>
                                           <th scope="col" class="py-3 px-6">Destinatario</th>
                                           <th scope="col" class="py-3 px-6">Fecha</th>
                                           <th scope="col" class="py-3 px-6">Hora</th>
                                           <th scope="col" class="py-3 px-6">Descripcion</th>
                                           <th scope="col" class="py-3 px-6"">Imagen</th>
                                           <th scope="col" class="py-3 px-6">Estado</th>
                                       </tr>
                                   </thead>
                                   <tbody>
                                       <%
                                           Usuario usuario = (Usuario)Session["usuario"];
                                           string urlSA = ConfigurationManager.AppSettings["urlSA"].ToString();
                                           string tokenSAS = ConfigurationManager.AppSettings["tokenSAS"].ToString();
                                           string containerSA = ConfigurationManager.AppSettings["containerSA"].ToString();

                                           int mesActualN = (int)Session["mes"];
                                           int añoActualN = (int)Session["año"];

                                           foreach (Encomienda obj in EncomiendaDao.ObtenerDatosEncomienda(int.Parse(usuario.NumDpto), usuario.IdCond, mesActualN, añoActualN))
                                           {
                                               string url = obj.Imagen == "" ? "../assets/img/notImage.jpg" : urlSA + containerSA + "/" + obj.Fecha.ToString("yyyy") + "/" + obj.Fecha.ToString("MM") + "/" + obj.IdNumDpto + "/" + obj.Imagen + tokenSAS;
                                       %>
                                       <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                           <td class="py-4 px-6"><%= obj.NumDpto %> </td>
                                           <td class="py-4 px-6"><%= obj.Recepcion %> </td>
                                           <td class="py-4 px-6"><%= obj.Destinatario %> </td>
                                           <td class="py-4 px-6"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                           <td class="py-4 px-6"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                           <td class="py-4 px-6"><%= obj.Descripcion %> </td>
                                           <td class="py-4 px-6">
                                               <img id="img1" src="<%=url%>" alt="" style="width: 100px; height: 100px" /></td>
                                           <td class="px-4 py-3"><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente</span></td>
                                       </tr>
                                       <%
                                           }
                                       %>
                                   </tbody>
                               </table>
                           </div>                       
                       </div>
                   </div>
                   <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Historial de Encomiendas</h2>
                       <!-- CTA -->
                       <div class="">
                           <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                               <div class="grid grid-cols-6 items-center">
                                   <div class="">
                                       <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListMesF2" runat="server" OnSelectedIndexChanged="Mes_SelectedIndexChanged2" AutoPostBack="true">
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
                                       <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAñoF2" runat="server" OnSelectedIndexChanged="Año_SelectedIndexChanged2" AutoPostBack="true">
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
                                           <th scope="col" class="py-3 px-6">Recepcion</th>
                                           <th scope="col" class="py-3 px-6">Destinatario</th>
                                           <th scope="col" class="py-3 px-6">Fecha</th>
                                           <th scope="col" class="py-3 px-6">Hora</th>
                                           <th scope="col" class="py-3 px-6">Descripcion</th>
                                           <th scope="col" class="py-3 px-6">Imagen</th>
                                           <th scope="col" class="py-3 px-6">Estado</th>
                                       </tr>
                                   </thead>
                                   <tbody>
                                       <%
                                           int mesActualN2 = (int)Session["mes2"];
                                           int añoActualN2 = (int)Session["año2"];

                                           foreach (Encomienda obj in EncomiendaDao.ObtenerDatosEncomiendaH(int.Parse(usuario.NumDpto), usuario.IdCond, mesActualN2, añoActualN2))
                                           {
                                               string url = obj.Imagen == "" ? "../assets/img/notImage.jpg" : urlSA + containerSA + "/" + obj.Fecha.ToString("yyyy") + "/" + obj.Fecha.ToString("MM") + "/" + obj.IdNumDpto + "/" + obj.Imagen + tokenSAS;
                                       %>
                                       <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                           <td class="py-4 px-6"><%= obj.NumDpto %> </td>
                                           <td class="py-4 px-6"><%= obj.Recepcion %> </td>
                                           <td class="py-4 px-6"><%= obj.Destinatario %> </td>
                                           <td class="py-4 px-6"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                           <td class="py-4 px-6"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                           <td class="py-4 px-6"><%= obj.Descripcion %> </td>
                                           <td class="py-4 px-6">
                                               <img id="img2" src="<%=url%>" alt="" style="width: 100px; height: 100px" /></td>
                                           <td class="py-4 px-6"><span class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">Retirado</span></td>
                                       </tr>
                                       <%
                                           }
                                       %>
                                   </tbody>
                               </table>
                           </div>
                       </div>
                   </div>
                   </form>
               </main>
           </div>
       </div>
</body>
</html>
