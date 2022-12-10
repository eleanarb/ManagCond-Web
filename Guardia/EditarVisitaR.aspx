<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarVisitaR.aspx.cs" Inherits="ManagCond.Guardia.EditarVisitaR" %>

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
        <!-- #include file ="Template/AsideGuardia.html" -->
         <div class="flex flex-col flex-1 w-full">
             <!-- #include file ="Template/HeaderGuardia.html" -->
             <main class="h-full pb-16 overflow-y-auto">
                 <div class="container grid px-6 mx-auto">
                     <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Editar Visita</h2>
                     <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                         <form id="AgregarVisita" runat="server">
                             <div class="grid gap-6 mb-8 md:grid-cols-2">
                                 <label class="block text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Numero departamento</span><br />
                                     <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownList" runat="server" disabled="true">
                                     </asp:DropDownList>
                                 </label>
                             </div>
                             <div class="grid gap-6 mb-8 md:grid-cols-2">
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                     <asp:TextBox ID="TextBoxRut" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" disabled="true"></asp:TextBox>
                                 </label>
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Nombres</span>
                                     <asp:TextBox ID="TextBoxNombres" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" disabled="true"></asp:TextBox>
                                 </label>
                             </div>
                             <div class="grid gap-6 mb-8 md:grid-cols-2">
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Apellidos</span>
                                     <asp:TextBox ID="TextBoxApellidos" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" disabled="true"></asp:TextBox>
                                 </label>
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Patente</span>
                                     <asp:TextBox ID="TextBoxPatente" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" disabled="true"></asp:TextBox>
                                 </label>
                             </div>
                             <div class="grid gap-6 mb-8 md:grid-cols-2">
                                 <label class="block text-sm">
                                     <span class="text-gray-700 dark:text-gray-200">Estado</span><br />
                                     <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListEstado" runat="server">
                                     </asp:DropDownList>
                                 </label>
                             </div>
                             <br />
                             <br />
                             <asp:Button ID="ButtonAgregar" class="px-4 py-2 text-sm font-semibold leading-tight text-green-700 transition-colors duration-150 bg-green-100 border border-transparent rounded-lg active:bg-green-200 hover:bg-green-200 focus:outline-none focus:shadow-outline-white" runat="server" OnClick="ButtonAceptar_Click" Text="Aceptar" />
                         </form>
                     </div>
                 </div>
             </main>
         </div>
     </div>
</body>
</html>
