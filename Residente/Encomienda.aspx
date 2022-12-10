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
                   <div class="container grid px-6 mx-auto">
                       <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Listado de Encomiendas</h2>
                       <!-- CTA -->
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

                                           foreach (Encomienda obj in EncomiendaDao.ObtenerDatosEncomienda(int.Parse(usuario.NumDpto), usuario.IdCond))
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
                       <h2
                           class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Historial de Encomiendas
                       </h2>
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
                                           foreach (Encomienda obj in EncomiendaDao.ObtenerDatosEncomiendaH(int.Parse(usuario.NumDpto), usuario.IdCond))
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
               </main>
           </div>
       </div>
</body>
</html>
