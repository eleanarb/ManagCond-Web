<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Encomiendas.aspx.cs" Inherits="ManagCond.Encomiendas" %>
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
      <link rel="stylesheet" href="./assets/css/tailwind.output.css" />
      <script
          src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
          defer></script>
      <script src="./assets/js/init-alpine.js"></script>
      <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
      <script
          src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
          defer></script>
      <script src="./assets/js/charts-lines.js" defer></script>
      <script src="./assets/js/charts-pie.js" defer></script>
  </head>
<body>
    <div
        class="flex h-screen bg-gray-50 dark:bg-gray-900"
        :class="{ 'overflow-hidden': isSideMenuOpen }">
        <!-- Desktop sidebar -->
        <aside
            class="z-20 hidden w-64 overflow-y-auto bg-white dark:bg-gray-800 md:block flex-shrink-0">
            <div class="py-4 text-gray-500 dark:text-gray-400">
                <a
                    class="ml-6 text-lg font-bold text-gray-800 dark:text-gray-200"
                    href="Guardia.aspx">ManagCond
                </a>
                <ul class="mt-6">
                    <li class="relative px-6 py-3">

                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="Guardia.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6">
                                </path>
                            </svg>
                            <span class="ml-4">Home</span>
                        </a>
                    </li>
                </ul>
                <ul>
                    <li class="relative px-6 py-3">
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="#.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01">
                                </path>
                            </svg>
                            <span class="ml-4">Reservas</span>
                        </a>
                    </li>
                    <li class="relative px-6 py-3">
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="#.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10">
                                </path>
                            </svg>
                            <span class="ml-4">Listado</span>
                        </a>
                    </li>
                    <li class="relative px-6 py-3">
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="#.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M11 3.055A9.001 9.001 0 1020.945 13H11V3.055z">
                                </path>
                                <path d="M20.488 9H15V3.512A9.025 9.025 0 0120.488 9z"></path>
                            </svg>
                            <span class="ml-4">Visitas</span>
                        </a>
                    </li>
                    <li class="relative px-6 py-3">
                        <span
                        class="absolute inset-y-0 left-0 w-1 bg-purple-600 rounded-tr-lg rounded-br-lg"
                        aria-hidden="true"
                        ></span>
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold text-gray-800 transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200 dark:text-gray-100"
                            href="Encomiendas.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z">
                                </path>
                            </svg>
                            <span class="ml-4">Encomiendas</span>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>
        <!-- Mobile sidebar -->
        <!-- Backdrop -->
        <div
            x-show="isSideMenuOpen"
            x-transition:enter="transition ease-in-out duration-150"
            x-transition:enter-start="opacity-0"
            x-transition:enter-end="opacity-100"
            x-transition:leave="transition ease-in-out duration-150"
            x-transition:leave-start="opacity-100"
            x-transition:leave-end="opacity-0"
            class="fixed inset-0 z-10 flex items-end bg-black bg-opacity-50 sm:items-center sm:justify-center">
        </div>
        <aside
            class="fixed inset-y-0 z-20 flex-shrink-0 w-64 mt-16 overflow-y-auto bg-white dark:bg-gray-800 md:hidden"
            x-show="isSideMenuOpen"
            x-transition:enter="transition ease-in-out duration-150"
            x-transition:enter-start="opacity-0 transform -translate-x-20"
            x-transition:enter-end="opacity-100"
            x-transition:leave="transition ease-in-out duration-150"
            x-transition:leave-start="opacity-100"
            x-transition:leave-end="opacity-0 transform -translate-x-20"
            @click.away="closeSideMenu"
            @keydown.escape="closeSideMenu">
            <div class="py-4 text-gray-500 dark:text-gray-400">
                <a
                    class="ml-6 text-lg font-bold text-gray-800 dark:text-gray-200"
                    href="Guardia.aspx">ManagCond
                </a>
                <ul class="mt-6">
                    <li class="relative px-6 py-3">
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="Guardia.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6">
                                </path>
                            </svg>
                            <span class="ml-4">Home</span>
                        </a>
                    </li>
                </ul>
                <ul>
                    <li class="relative px-6 py-3">
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="#.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01">
                                </path>
                            </svg>
                            <span class="ml-4">Reservas</span>
                        </a>
                    </li>
                    <li class="relative px-6 py-3">
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="#.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10">
                                </path>
                            </svg>
                            <span class="ml-4">Listado</span>
                        </a>
                    </li>
                    <li class="relative px-6 py-3">
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200"
                            href="#.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M11 3.055A9.001 9.001 0 1020.945 13H11V3.055z">
                                </path>
                                <path d="M20.488 9H15V3.512A9.025 9.025 0 0120.488 9z"></path>
                            </svg>
                            <span class="ml-4">Visitas</span>
                        </a>
                    </li>
                    <li class="relative px-6 py-3">
                        <span
                            class="absolute inset-y-0 left-0 w-1 bg-purple-600 rounded-tr-lg rounded-br-lg"
                            aria-hidden="true"></span>
                        <a
                            class="inline-flex items-center w-full text-sm font-semibold text-gray-800 transition-colors duration-150 hover:text-gray-800 dark:hover:text-gray-200 dark:text-gray-100"
                            href="#.aspx">
                            <svg
                                class="w-5 h-5"
                                aria-hidden="true"
                                fill="none"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path
                                    d="M15 15l-2 5L9 9l11 4-5 2zm0 0l5 5M7.188 2.239l.777 2.897M5.136 7.965l-2.898-.777M13.95 4.05l-2.122 2.122m-5.657 5.656l-2.12 2.122">
                                </path>
                            </svg>
                            <span class="ml-4">Encomiendas</span>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>

        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderGuardia.html" -->
            <main class="h-full pb-16 overflow-y-auto">
                <div class="container grid px-6 mx-auto">
                    <%--<div class="container grid px-6 mx-auto">
                        <br />
                        <asp:Repeater ID="RepeaterImage" runat="server"></asp:Repeater>
                        <ItemTemplate>
                            <div>
                            <img class="object-cover" src="data:image/jpg;base64,<%# Convert.ToBase64String((byte[])DataBinder.Eval(Container.RouteData, "imagen")) %>"/>
                            <%#DataBinder.Eval(Container.GetDataItem, "numDpto") %>
                            <br />
                            </div>
                        </ItemTemplate>
                    </div>--%>
                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Encomienda
                    </h2>
                    <form id="AgregarEncomienda" runat="server">
                        <div class="w-full">
                            <label class="block text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Numero departamento</span><br />
                                <asp:dropdownlist ID="DropDownList" runat="server">

                                </asp:dropdownlist>
                            </label>
                            <label class="block mt-4 text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Destinatario</span>
                                <asp:TextBox ID="TextBoxDestinatario" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                            </label>
                            <label class="block mt-4 text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Fecha</span>
                                <asp:TextBox ID="TextBoxFecha" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server" Enabled="True"></asp:TextBox>
                            </label>
                            <label class="block mt-4 text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Hora</span>
                                <asp:TextBox ID="TextBoxHora" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                            </label>
                            <label class="block mt-4 text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Descripcion</span>
                                <asp:TextBox ID="TextBoxDescripcion" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                            </label>
                            <label class="block mt-4 text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Estado</span>
                                <asp:TextBox ID="TextBoxEstado" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                            </label>
                            <span class="text-gray-700 dark:text-gray-400">Subir imagen</span><br />
                            <asp:Image ID="ImagenEncomienda" Width="200" runat="server" />
                            <asp:FileUpload ID="FileUploadEncomienda" accept=".jpg" runat="server" />
                            <br /><br />
                            <asp:Button ID="ButtonAgregar" class="px-4 py-2 text-sm font-semibold leading-tight text-green-700 transition-colors duration-150 bg-green-100 border border-transparent rounded-lg active:bg-green-200 hover:bg-green-200 focus:outline-none focus:shadow-outline-white" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                        </div>
                    </form>
                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Listado de Encomiendas
                    </h2>
                    <!-- CTA -->
                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full whitespace-no-wrap">
                                <thead>
                                    <tr
                                        class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
                                        <th class="px-4 py-3">Departamento</th>
                                        <th class="px-4 py-3">Destinatario</th>
                                        <th class="px-4 py-3">Fecha</th>
                                        <th class="px-4 py-3">Hora</th>
                                        <th class="px-4 py-3">Descripcion</th>
                                        <th class="px-4 py-3">Imagen</th>
                                        <th class="px-4 py-3">Estado</th>
                                    </tr>
                                </thead>
                                <tbody
                                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                    <%
                                        foreach (Encomienda obj in UsuarioDao.GetAlEncomiendas())
                                        {
                                    %>
                                    <tr class="text-gray-700 dark:text-gray-400">
                                        <td class="px-4 py-3"><%= obj.NumDpto %> </td>
                                        <td class="px-4 py-3"><%= obj.Destinatario %> </td>
                                        <td class="px-4 py-3"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                        <td class="px-4 py-3"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                        <td class="px-4 py-3"><%= obj.Descripcion %> </td>
                                        <td class="px-4 py-3"><%= obj.Imagen %> </td>
                                        <td class="px-4 py-3"><%= obj.Estado %> </td>
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
</body>
</html>

