<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ManagCond.Residente.Index" %>
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
            <%
                Usuario usuario = (Usuario)Session["usuario"];
                int idCond = int.Parse(Session["idCond"].ToString());
                Condominio condominio = CondominioDao.ObtenerDatosCondominio(idCond);
                 %> 
            <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid">
                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Condominio <%=condominio.Nombre %>
                    </h2>
                    <!-- CTA -->
                    
                    
                </div>
                                 <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Ultimas de Visitas</h2>
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
                                        foreach (Visita obj1 in VisitaDao.GetAlVisitaTOPR(int.Parse(usuario.numDpto), usuario.IdCond))
                                        {
                                    %>
                                    <tr class="text-gray-700 dark:text-gray-400">
                                        <td class="px-4 py-3"><%= obj1.NumDpto %> </td>
                                        <td class="px-4 py-3"><%= obj1.Rut %> </td>
                                        <td class="px-4 py-3"><%= obj1.Nombres %> </td>
                                        <td class="px-4 py-3"><%= obj1.Apellidos %> </td>
                                        <td class="px-4 py-3"><%= obj1.Fecha.ToString("dd/MM/yyyy") %> </td>
                                        <td class="px-4 py-3"><%= obj1.Hora.ToString("hh':'mm''") %> </td>
                                        <td class="px-4 py-3"><%= obj1.Patente %> </td>
                                        <td class="px-4 py-3 text-xs">
                                        <%if (obj1.Estado.Equals("Pendiente"))
                                            { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente</span><%}
                                          else
                                         {
                                          if (obj1.Estado.Equals("Registrado"))
                                          { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Registrado</span><%}
                                          else
                                          {
                                          if (obj1.Estado.Equals("Aprobado"))
                                          { %><span class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">Aprobado</span><%}
                                          else
                                          {%><span class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700">Rechazado</span> <%}
                                          }}%>
                                        </td>
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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Ultimas encomiendas</h2>
                    <!-- CTA -->
                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full whitespace-no-wrap">
                                <thead>
                                    <tr
                                        class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
                                        <th class="px-4 py-3">Departamento</th>
                                        <th class="px-4 py-3">Recepción</th>
                                        <th class="px-4 py-3">Destinatario</th>
                                        <th class="px-4 py-3">Fecha</th>
                                        <th class="px-4 py-3">Hora</th>
                                        <th class="px-4 py-3">Descripción</th>
                                        <th class="px-4 py-3">Imagen</th>
                                        <th class="px-4 py-3">Estado</th>
                                    </tr>
                                </thead>
                                <tbody
                                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                    <%
                                        string urlSA = ConfigurationManager.AppSettings["urlSA"].ToString();
                                        string tokenSAS = ConfigurationManager.AppSettings["tokenSAS"].ToString();
                                        string containerSA = ConfigurationManager.AppSettings["containerSA"].ToString();
                                         

                                        foreach (Encomienda obj in EncomiendaDao.GetAlEncomiendasTOPR(int.Parse(usuario.numDpto),usuario.IdCond))
                                        {
                                            string url = obj.Imagen == ""? "../assets/img/notImage.jpg" :  urlSA + containerSA + "/" + obj.Fecha.ToString("yyyy") + "/" + obj.Fecha.ToString("MM") + "/" + obj.IdNumDpto + "/" + obj.Imagen + tokenSAS;
                                    %>
                                    <tr class="text-gray-700 dark:text-gray-400">
                                        <td class="px-4 py-3"><%= obj.NumDpto %> </td>
                                        <td class="px-4 py-3"><%= usuario.Nombres %> <%= usuario.Apellidos %> </td>
                                        <td class="px-4 py-3"><%= obj.Destinatario %> </td>
                                        <td class="px-4 py-3"><%= obj.Fecha.ToString("dd/MM/yyyy") %> </td>
                                        <td class="px-4 py-3"><%= obj.Hora.ToString("hh':'mm''") %> </td>
                                        <td class="px-4 py-3"><%= obj.Descripcion %> </td>
                                        <td class="px-4 py-3"><img id="img1" src="<%=url%>" alt="" style="width:100px; height:100px"/></td>
                                        <td class="px-4 py-3 text-xs">
                                        <%if (obj.Estado.Equals("Pendiente"))
                                            { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente</span><%}
                                            else{ %><span class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">Retirado</span> <%} %>
                                        </td>
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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Ultimas Reservas</h2>
                    <!-- CTA -->
                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full whitespace-no-wrap">
                                <thead>
                                    <tr
                                        class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800">
                                        <th class="px-4 py-3">Departamento</th>
                                        <th class="px-4 py-3">Solicitante</th>
                                        <th class="px-4 py-3">Espacio Común</th>
                                        <th class="px-4 py-3">Fecha</th>
                                        <th class="px-4 py-3">Hora</th>
                                        <th class="px-4 py-3">Estado</th>
                                    </tr>
                                </thead>
                                <tbody
                                     class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800">
                                    <%
                                        foreach (Reserva obj in ReservaDao.GetAlReservasTOPR(usuario.numDpto, usuario.IdCond))
                                        {

                                    %>
                                    <tr class="text-gray-700 dark:text-gray-400">
                                        <td class="px-4 py-3"><%= obj.NumDpto %> </td>
                                        <td class="px-4 py-3"><%= obj.Solicitante %> </td>
                                        <td class="px-4 py-3"><%= obj.EspacioComun %> </td>
                                        <td class="px-4 py-3"><%= obj.Fecha.ToString("dd/MM/yyyy")%></td>
                                        <td class="px-4 py-3"><%= obj.RangoHorario %> </td>
                                        <td class="px-4 py-3 text-xs">
                                        <%if (obj.Estado == 1)
                                            { %><span class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente</span><%}
                                          else
                                         {
                                          if (obj.Estado == 2)
                                          { %><span class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100">Aprobado</span><%}
                                          else
                                          {%><span class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700">Rechazado</span><%}}%>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
