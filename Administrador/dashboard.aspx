<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="ManagCond.dashboard" %>
<%@ Import Namespace="Model" %>
<%@ Import Namespace="Dao" %>

<%@ Import Namespace="System.Globalization" %>

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
    <script src="../assets/js/charts-lines.js" defer></script>
    <script src="../assets/js/charts-pie.js" defer></script>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load("current", { packages: ["corechart"] });
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
            var data = google.visualization.arrayToDataTable(<%=obtenerGastos()%>);

            var options = {
                legend: 'none',
                pieSliceText: 'label',
                pieStartAngle: 100,
                "backgroundColor": { "fill": "transparent" },
            };


            var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
            chart.draw(data, options);
        }
    </script>
    
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['line'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable(<%=obtenerBalance()%>);

            var options = {
                legend: { position: 'none' },
                "backgroundColor": { "fill": "transparent" },
            };

            var chart = new google.charts.Line(document.getElementById('linechart_material'));

            chart.draw(data, google.charts.Line.convertOptions(options));
        }
    </script>

</head>
<body>
    <div
        class="flex h-screen bg-gray-50 dark:bg-gray-900"
        :class="{ 'overflow-hidden': isSideMenuOpen }">
      <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
            <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid">
                    <input type="hidden" id="TextBoxId" name="TextBoxId" value="7" runat="server">
                    <%
                        int idCondominio = 0;
                        idCondominio = (int)Session["idCondominio"];

                        Condominio cond = CondominioDao.ObtenerDatosCondominio(idCondominio);
                    %>
                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200"><%=cond.Nombre %>
                    </h2>
                    <!-- CTA -->

                    <!-- Cards -->
                    <div class="grid gap-6 mb-8 md:grid-cols-2 xl:grid-cols-4">
                        <!-- Card -->
                        <div
                            class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <div
                                class="p-3 mr-4 text-orange-500 bg-orange-100 rounded-full dark:text-orange-100 dark:bg-orange-500">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z">
                                    </path>
                                </svg>
                            </div>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                                    Total residentes
                                </p>
                                <%
                                    int totalResidentes = 0;
                                    totalResidentes = ResidenteDao.ObtenerTotalResidentes(idCondominio);
                                %>

                                <p
                                    class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                                    <%=totalResidentes %>
                                </p>
                            </div>
                        </div>
                        <!-- Card -->
                        <div
                            class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <div
                                class="p-3 mr-4 text-green-500 bg-green-100 rounded-full dark:text-green-100 dark:bg-green-500">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        fill-rule="evenodd"
                                        d="M4 4a2 2 0 00-2 2v4a2 2 0 002 2V6h10a2 2 0 00-2-2H4zm2 6a2 2 0 012-2h8a2 2 0 012 2v4a2 2 0 01-2 2H8a2 2 0 01-2-2v-4zm6 4a2 2 0 100-4 2 2 0 000 4z"
                                        clip-rule="evenodd">
                                    </path>
                                </svg>
                            </div>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                                    Balance Fondo Común 
                                </p>
                                <p
                                    class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                                    $ 4,760.89
                                </p>
                            </div>
                        </div>


                        <!-- Card -->
                        <div
                            class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <div
                                class="p-3 mr-4 text-teal-500 bg-teal-100 rounded-full dark:text-teal-100 dark:bg-teal-500">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                    <path
                                        fill-rule="evenodd"
                                        d="M18 5v8a2 2 0 01-2 2h-5l-5 4v-4H4a2 2 0 01-2-2V5a2 2 0 012-2h12a2 2 0 012 2zM7 8H5v2h2V8zm2 0h2v2H9V8zm6 0h-2v2h2V8z"
                                        clip-rule="evenodd">
                                    </path>
                                </svg>
                            </div>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                                    Solicitudes de Reservas 
                                </p>

                                <%
                                    int totalReservasP = 0;
                                    totalReservasP = ReservaDao.ObtenerTotalReservasPendientes(idCondominio);


                                 %>

                                <p
                                    class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                                    <%=totalReservasP %>
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- New Table -->
                    <div class="w-full overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full whitespace-no-wrap">
                                <thead>
                                    <tr
                                        class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
                                        <th class="px-4 py-3">Departamento</th>
                                        <th class="px-4 py-3">Gasto Común</th>
                                        <th class="px-4 py-3">Estado</th>
                                        <th class="px-4 py-3">Fecha Emisión</th>
                                    </tr>
                                </thead>
                                <tbody
                                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                    <%
                                        DateTime fechaActual = System.DateTime.Now;
                                        int mesActual = int.Parse(fechaActual.ToString("MM")) -1;
                                        int añoActual = int.Parse(fechaActual.ToString("yyyy"));
                                        string depto = "";
                                        foreach (GastosComunes obj in GastosComunesDao.GetAlGastosComunesV(idCondominio, mesActual, añoActual, depto))
                                        {
                                            int total = obj.GastoComun + obj.FondoReserva + obj.Multas + obj.MoraPeriodo + obj.Varios;

                                    %>
                                    <tr class="text-gray-700 dark:text-gray-400">
                                        <td class="px-4 py-3">
                                            <div class="flex items-center text-sm">

                                                <div>
                                                    <p class="font-semibold">Departamento <%=obj.NumDpto %></p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-4 py-3 text-sm">$<%=total.ToString("N0")%>
                                        </td>
                                        <td class="px-4 py-3 text-xs">
                                            <%if (obj.Estado==2){ %>
                                            <span
                                                class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"><%=obj.Estado %>
                                            </span>

                                            <%}else if (obj.Estado==1)
                                                { %>
                                            <span
                                                class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente
                                            </span>

                                            <%}
                                                else if (obj.Estado==3)
                                                { %>
                                            <span
                                                class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700"><%=obj.Estado %>
                                            </span>
                                        </td>
                                        <%} %>

                                        <td class="px-4 py-3 text-sm"><%=obj.FechaEmision.ToString("dd-MM-yyyy") %>
                                        </td>
                                    </tr>
                                    <%
                                            
                                        }
                                    %>
                                    
                                    

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Charts -->
                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Gráficos
                    </h2>
                    <div class="grid gap-6 mb-8 md:grid-cols-2">
                        <div
                            class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <h4 class="mb-4 font-semibold text-gray-800 dark:text-gray-300">Distribución de Gastos
                            </h4>
                             <div id="donutchart" style="width: 100%; height: 120%; padding: 0;"></div>

                        </div>
                        <div
                            class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <h4 class="mb-4 font-semibold text-gray-800 dark:text-gray-300">Ingresos y Egresos
                            </h4>
                            <div id="linechart_material" style="width: 420px; height: 250px; padding: 0;"></div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>


</body>
</html>
