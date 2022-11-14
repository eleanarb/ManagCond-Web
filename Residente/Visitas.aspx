<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Visitas.aspx.cs" Inherits="ManagCond.Residente.Visitas" %>
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
      <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
      <script
          src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
          defer></script>
      <script src="../assets/js/charts-lines.js" defer></script>
      <script src="../assets/js/charts-pie.js" defer></script>
  </head>
<body>
    <div
        class="flex h-screen bg-gray-50 dark:bg-gray-900"
        :class="{ 'overflow-hidden': isSideMenuOpen }">
        <!-- #include file ="Template/AsideResidente.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderResidente.html" -->
            <main class="h-full overflow-y-auto">
                <div class="container grid px-6 mx-auto">
                    <div class="grid grid-cols-4 gap-4">
                        <div>
                            <h2
                                class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Historial de Visitas
                            </h2>
                                <button id="buttonList"" @click="openModal" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">Agregar Visita</button>
                        </div>
                        <br>
                    </div>
                    <!-- CTA -->
                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full whitespace-no-wrap">
                                <thead>
                                    <tr
                                        class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
                                        <th class="px-4 py-3">Departamento</th>
                                        <th class="px-4 py-3">Rut</th>
                                        <th class="px-4 py-3">Nombres</th>
                                        <th class="px-4 py-3">Apellidos</th>
                                        <th class="px-4 py-3">Fecha</th>
                                        <th class="px-4 py-3">Hora</th>
                                        <th class="px-4 py-3">Patente</th>
                                        <th class="px-4 py-3">Estado</th>
                                        <th class="px-4 py-3">Editar</th>
                                    </tr>
                                </thead>
                                <tbody
                                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                    <%
                                        Usuario usuario = (Usuario)Session["usuario"];

                                        foreach (Visita obj in VisitaDao.ObtenerDatosVisitaPendiente(usuario.NumDpto.ToString(), usuario.IdCond))
                                        {
                                    %>
                                    <tr class="text-gray-700 dark:text-gray-400">
                                        <td class="px-4 py-3"><%= obj.NumDpto %> </td>
                                        <td class="px-4 py-3"><%= obj.Rut %> </td>
                                        <td class="px-4 py-3"><%= obj.Nombres %> </td>
                                        <td class="px-4 py-3"><%= obj.Apellidos %> </td>
                                        <td class="px-4 py-3"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                        <td class="px-4 py-3"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                        <td class="px-4 py-3"><%= obj.Patente %> </td>
                                        <td class="px-4 py-3"><%if (obj.Estado.Equals("Pendiente"))
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
                                        <td class="px-4 py-3 text-xs"><%if (obj.Estado.Equals("Registrado")){%> <a href="EditarVisita.aspx?id=<%= obj.Id %>">Editar</a><% }else
                                                                      { %><a href="EditarVisitaR.aspx?id=<%= obj.Id %>">Editar</a><%} %></td>
                                        <td></td>
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
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Historial de Visitas
                    </h2>
                    <!-- CTA -->
                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full whitespace-no-wrap">
                                <thead>
                                    <tr
                                        class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
                                        <th class="px-4 py-3">Departamento</th>
                                        <th class="px-4 py-3">Rut</th>
                                        <th class="px-4 py-3">Nombres</th>
                                        <th class="px-4 py-3">Apellidos</th>
                                        <th class="px-4 py-3">Fecha</th>
                                        <th class="px-4 py-3">Hora</th>
                                        <th class="px-4 py-3">Patente</th>
                                        <th class="px-4 py-3">Estado</th>
                                    </tr>
                                </thead>
                                <tbody
                                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                    <%
                                        foreach (Visita obj in VisitaDao.ObtenerDatosVisita(usuario.NumDpto.ToString(), usuario.IdCond))
                                        {
                                    %>
                                    <tr class="text-gray-700 dark:text-gray-400">
                                        <td class="px-4 py-3"><%= obj.NumDpto %> </td>
                                        <td class="px-4 py-3"><%= obj.Rut %> </td>
                                        <td class="px-4 py-3"><%= obj.Nombres %> </td>
                                        <td class="px-4 py-3"><%= obj.Apellidos %> </td>
                                        <td class="px-4 py-3"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                        <td class="px-4 py-3"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                        <td class="px-4 py-3"><%= obj.Patente %> </td>
                                        <td class="px-4 py-3"><%if (obj.Estado.Equals("Pendiente"))
                                                                { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente</span><%}
                                                                else{
                                                                if (obj.Estado.Equals("Registrado"))
                                                                { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Registrado</span><%}
                                                                else{
                                                                if (obj.Estado.Equals("Aprobado"))
                                                                { %><span class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">Aprobado</span><%}
                                                                else
                                                                {%><span class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700">Rechazado</span> <%}
                                                                }}%> </td>
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
             <form id="AgregarVisita" runat="server">
                             <div class="w-full">
                                 <label class="block text-sm">
                                     <span class="text-gray-700 dark:text-gray-200">Numero departamento</span><br />
                                     <asp:DropDownList class="mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-multiselect focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownList" runat="server" disabled="true">
                                     </asp:DropDownList>
                                 </label>
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                     <asp:TextBox ID="TextBoxRut" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                                 </label>
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Nombres</span>
                                     <asp:TextBox ID="TextBoxNombres" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                                 </label>
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Apellidos</span>
                                     <asp:TextBox ID="TextBoxApellidos" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                                 </label>
                                 <label class="block mt-4 text-sm">
                                     <span class="text-gray-700 dark:text-gray-400">Patente</span>
                                     <asp:TextBox ID="TextBoxPatente" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                                 </label>
                                 <br />
                                 <br />
                             </div>
                        <footer class="flex flex-col items-center justify-end px-6 py-3 -mx-6 -mb-4 space-y-4 sm:space-y-0 sm:space-x-6 sm:flex-row bg-gray-50 dark:bg-gray-800">
                       <button @click="closeModal" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white text-gray-700 transition-colors duration-150 border border-gray-300 rounded-lg dark:text-gray-400 sm:px-4 sm:py-2 sm:w-auto active:bg-transparent hover:border-gray-500 focus:border-gray-500 active:text-gray-500 focus:outline-none focus:shadow-outline-gray">Cancel</button>
                       <asp:Button ID="ButtonAgregar" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                       </footer>
             </form>
          </div>
        </div>
    </div>
    <!-- End of modal backdrop -->
</body>
</html>
