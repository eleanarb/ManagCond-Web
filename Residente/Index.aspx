<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ManagCond.Residente.Index" %>
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
      <link  rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
      <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" defer></script>
      <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
      <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
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
            <%
                Usuario usuario = (Usuario)Session["usuario"];
                int idDpto = int.Parse((string)Session["numDpto"]);
                int idCond = int.Parse(Session["idCond"].ToString());
                Condominio condominio = CondominioDao.ObtenerDatosCondominio(idCond);
                 %> 
            <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid">
                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Condominio <%=condominio.Nombre %>
                    </h2>
                    <!-- CTA -->

                    <div class="grid gap-6 mb-8 md:grid-cols-2 xl:grid-cols-4">
                        <!-- Card -->
                        <div class="flex items-center p-4 bg-green-100 rounded-lg shadow-xs ">
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 ">
                                    Último Pago
                                </p>
                                <%
                                    GastosComunes gastosComunes = GastosComunesDao.ObtenerDatosUltimoPago(idCond, idDpto);
                                %>
                                <h1 class="text-4xl font-extrabold ">$<%=gastosComunes.TotalPagar.ToString("N0") %></h1>

                                <p
                                    class="mb-3 font-light text-gray-500 ">
                                    <%=gastosComunes.FechaPago.ToString("dd MMM yyyy") %>
                                </p>
                            </div>
                        </div>
                        <!-- Card -->
                        <div class="flex items-center p-4 bg-red-100 rounded-lg shadow-xs " >
                            <% int pendientes = 0;
                                pendientes = GastosComunesDao.ObtenerTotalGastosComunesPendientes(idDpto, idCond);
                                if (pendientes == 0)
                                {%>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 ">
                                    Deuda total
                                </p>
                                <h1 class="text-4xl font-extrabold">Estás al día!</h1>

                            </div>
                            <%}
                                else
                                { %>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 ">
                                    Deuda total
                                </p>
                                <%
                                    int deudaTotal = GastosComunesDao.ObtenerDeudaTotal(idDpto, idCond);
                                    GastosComunes gastoComunU = GastosComunesDao.ObtenerDatosUltimoGastoComun(idCond, idDpto);
                                %>
                                <h1 class="text-4xl font-extrabold ">$<%=deudaTotal.ToString("N0") %></h1>

                            </div>
                            <%} %>
                        </div>


                    </div>
                    <div class="grid gap-6 mb-8 md:grid-cols-3 xl:grid-cols-4">
                        <!-- Card -->
                        <div
                            class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <div
                                class="p-3 mr-4 text-teal-500 bg-blue-100 rounded-full dark:text-blue-100 dark:bg-blue-500">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z"></path></svg>
                            </div>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                                    Reservas Activas 
                                </p>

                                <%
                                     int totalReservasP = ReservaDao.ObtenerTotalReservasPendientesDpto(idDpto);

                                %>

                                <p
                                    class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                                    <%=totalReservasP %>
                                </p>
                            </div>
                        </div>
                        <!-- Card -->
                        <div
                            class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <div
                                class="p-3 mr-4 text-teal-500 bg-teal-100 rounded-full dark:text-teal-100 dark:bg-teal-500">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path></svg>
                            </div>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                                    Visitas pendientes 
                                </p>

                                <%                                  
                                    int totalVisitasP = VisitaDao.ObtenerTotalVisitasPendientes(idDpto);
                                %>

                                <p
                                    class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                                    <%=totalVisitasP %>
                                </p>
                            </div>
                        </div>
                        <!-- Card -->
                        <div
                            class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800">
                            <div
                                class="p-3 mr-4 text-orange-500 bg-orange-100 rounded-full dark:text-orange-100 dark:bg-orange-500">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"></path></svg>
                            </div>
                            <div>
                                <p
                                    class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                                    Encomiendas pendientes 
                                </p>

                                <%
                                    int totalEncomiendasP = EncomiendaDao.ObtenerTotalEncomiendasPendientes(idDpto);


                                %>

                                <p
                                    class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                                    <%=totalEncomiendasP %>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="container px-6 mx-auto grid">
                    <div class="grid gap-6 mb-8 md:grid-cols-3 xl:grid-cols-4">
                         <!-- Card -->
                        <div class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                            <div>
                                <p class="mb-2 text-sm font-medium text-gray-700 dark:text-gray-200 ">
                                    Últimas Reservas &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp  <a href="Reservas.aspx" class="inline-flex items-center font-medium text-purple-600 dark:text-purple-500 hover:underline">Ver más
                                        <svg aria-hidden="true" class="ml-1 w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                    </a>
                                </p>
                                <%--filas--%>
                                <%
                                    foreach (Reserva reserva in ReservaDao.GetAlReservasTOPR(idDpto, idCond))
                                    { %>
                                <div class="flex items-center">

                                     <img class="w-96 h-96 rounded-full" style="width:20%; height:20%;" src="../assets/img/reserva.png" alt="image description">
                                      &nbsp
                                    <div>
                                        <p
                                            class="mb-2 text-sm font-medium text-gray-700 dark:text-gray-200">
                                            <%=reserva.EspacioComun %> 
                                        </p>

                                        <p
                                            class="text-sm  text-gray-600 dark:text-gray-400">
                                            <%=reserva.Fecha.ToString("dd MMM yyyy")%>
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <%} %>
                            </div>
                        </div>

                        <!-- Card -->
                        <div class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                            <div>
                                <p class="mb-2 text-sm font-medium text-gray-700 dark:text-gray-200  ">
                                    Últimas Visitas &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp  <a href="Visitas.aspx" class="inline-flex items-center font-medium text-purple-600 dark:text-purple-500 hover:underline">Ver más
                                        <svg aria-hidden="true" class="ml-1 w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                    </a>
                                </p>
                                <%--filas--%>
                                <%
                                    foreach (Visita visita in VisitaDao.GetAlVisitaTOPR(idDpto, idCond))
                                    { %>
                                <div class="flex items-center">

                                     <img class="w-96 h-96 rounded-full" style="width:20%; height:20%;" src="../assets/img/profile.jpg" alt="image description">
                                      &nbsp
                                    <div>
                                        <p
                                            class="mb-2 text-sm font-medium text-gray-700 dark:text-gray-200">
                                            <%=visita.Nombres %> 
                                        </p>

                                        <p
                                            class="text-sm  text-gray-600 dark:text-gray-400">
                                            <%=visita.Fecha.ToString("dd MMM yyyy") %> - <%=visita.Hora%>
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <%} %>
                            </div>
                        </div>

                         <!-- Card -->
                        <div class="flex items-center p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                            <div>
                                <p class="mb-2 text-sm font-medium text-gray-700 dark:text-gray-200 ">
                                    Últimas Encomiendas  &nbsp &nbsp &nbsp &nbsp <a href="Encomienda.aspx" class="inline-flex items-center font-medium text-purple-600 dark:text-purple-500 hover:underline">Ver más
                                        <svg aria-hidden="true" class="ml-1 w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                    </a>
                                </p>
                                <%--filas--%>
                                <%
                                    foreach (Encomienda encomienda in EncomiendaDao.GetAlEncomiendasTOPR(idDpto, idCond))
                                    { %>
                                <div class="flex items-center">

                                     <img class="w-96 h-96 rounded-full" style="width:20%; height:20%;" src="../assets/img/paquete.png" alt="image description">
                                      &nbsp
                                    <div>
                                        <p
                                            class="mb-2 text-sm font-medium text-gray-700 dark:text-gray-200">
                                            <%=encomienda.Descripcion %>: <%=encomienda.Destinatario %>
                                        </p>

                                        <p
                                            class="text-sm  text-gray-600 dark:text-gray-400">
                                            <%=encomienda.Fecha.ToString("dd MMM yyyy")%>
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <%} %>
                            </div>
                        </div>

                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>