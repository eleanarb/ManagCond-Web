<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Egresos.aspx.cs" Inherits="ManagCond.Residente.Egresos" %>
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
      <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
  </head>
  <body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }">
        <!-- #include file ="Template/AsideResidente.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderResidente.html" -->
            <main class="h-full overflow-y-auto">
                <form runat="server">
                    <div class="container grid px-6 mx-auto">
                        <%
                            DateTime fechaActual = System.DateTime.Now;
                            string mesActual = fechaActual.ToString("MMMM");
                            string añoActual = fechaActual.ToString("yyyy");
                        %>
                        <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Egresos de <%=mesActual %>-<%=añoActual %></h2>
                        <br />
                        <div class="">
                            <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                                <div class="grid grid-cols-2 items-center">
                                    <div class="grid grid-cols-2">
                                        <div class="">
                                            <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListMes" runat="server" OnSelectedIndexChanged="Mes_SelectedIndexChanged" AutoPostBack="true">
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
                                            <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAño" runat="server" OnSelectedIndexChanged="Año_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Value="2019">2019</asp:ListItem>
                                                <asp:ListItem Value="2020">2020</asp:ListItem>
                                                <asp:ListItem Value="2022">2022</asp:ListItem>
                                                <asp:ListItem Value="2023">2023</asp:ListItem>
                                                <asp:ListItem Value="2024">2024</asp:ListItem>
                                                <asp:ListItem Value="2025">2025</asp:ListItem>
                                                <asp:ListItem Value="2026">2026</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="grid grid-cols-4">
                                        <div></div>
                                        <div></div>
                                        <div class="">
                                        </div>
                                        <div class="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="overflow-x-auto relative shadow-md sm:rounded-lg">
                                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                        <tr>
                                            <th scope="col" class="py-3 px-6">Proveedor</th>
                                            <th scope="col" class="py-3 px-6">Descripcion</th>
                                            <th scope="col" class="py-3 px-6">Monto</th>
                                            <th scope="col" class="py-3 px-6">Fecha</th>
                                            <th scope="col" class="py-3 px-6">Estado</th>
                                            <th scope="col" class="py-3 px-6">Doc Cobro</th>
                                            <th scope="col" class="py-3 px-6">Doc Pago</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                            int idCond = 0;
                                            int mesActualN = 0;
                                            int añoActualN = 0;

                                            idCond = (int)Session["idCond"];
                                            mesActualN = (int)Session["mes"];
                                            añoActualN = (int)Session["año"];

                                            int totalCategorias = 0;
                                            totalCategorias = EgresosDao.ObtenerTotalCategoriaEgresos(idCond, mesActualN, añoActualN);

                                            if (totalCategorias == 0)
                                            {
                                        %>
                                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                            <th colspan="8" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay egresos registrados 
                                            </th>
                                        </tr>
                                        <%
                                            }
                                            else
                                            {
                                                foreach (CategoriaEgresos obj in EgresosDao.GetAlObtenerCategoriasEgresos(idCond, mesActualN, añoActualN))
                                                {
                                        %>
                                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 h-1">
                                            <td colspan="8" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white bg-gray-100 dark:bg-gray-900 dark:text-gray-400"><%=obj.Descrpcion %>
                                            </td>
                                        </tr>
                                        <%
                                            string urlSA = ConfigurationManager.AppSettings["urlSA"].ToString();
                                            string tokenSAS = ConfigurationManager.AppSettings["tokenArchivosSAS"].ToString();
                                            string containerSA = ConfigurationManager.AppSettings["containerArchivosSA"].ToString();

                                            foreach (Egresos obj1 in EgresosDao.GetAlObtenerEgresos(obj.id, idCond, mesActualN, añoActualN))
                                            {
                                                string fecha = obj1.Fecha.ToString("dd-MM-yyyy");
                                                string año = obj1.Fecha.ToString("yyyy");
                                                string mes = obj1.Fecha.ToString("MM");
                                                string url = urlSA + containerSA + "/" + año + "/" + mes + "/" + obj1.DocumentoCobro + tokenSAS;
                                                string url2 = urlSA + containerSA + "/" + año + "/" + mes + "/" + obj1.Comprobante + tokenSAS;
                                        %>
                                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                            <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white" data-id="<%=obj1.IdProveedor %>" data-categoria="<%=obj.id%>" id="idProveedor"><%=obj1.Proveedor %>
                                            </th>
                                            <td class="py-4 px-6"><%=obj1.Descripcion %>
                                            </td>
                                            <td class="py-4 px-6">$<%=obj1.Monto %>
                                            </td>
                                            <td class="py-4 px-6"><%=fecha %>
                                            </td>
                                            <td class="py-4 px-6"><%=obj1.Estado %>
                                            </td>
                                            <td class="py-4 px-6"><%if (obj1.DocumentoCobro == "")
                                                                      {%><a class="font-medium text-blue-600 dark:text-blue-500 hover:underline">No Tiene Documento</a><%}
                                                                                                                                                                           else
                                                                                                                                                                           { %> <a href="<%=url %>" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Documento</a><%} %></td>
                                            <td class="py-4 px-6"><%if (obj1.Comprobante == "")
                                                                      {%><a class="font-medium text-blue-600 dark:text-blue-500 hover:underline">No Tiene Documento</a><%}
                                                                                                                                                                           else
                                                                                                                                                                           { %> <a href="<%=url2 %>" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Documento</a><%} %></td>
                                        </tr>
                                        <%}
                                                }
                                            }%>
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