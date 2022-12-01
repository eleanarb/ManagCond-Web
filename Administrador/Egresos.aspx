<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Egresos.aspx.cs" Inherits="ManagCond.Administrador.Egresos" %>
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
      <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
  </head>
  <body>

    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
      <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
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
                                        <a class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" href="GestionProveedores.aspx">Proveedores</a>
                                    </div>
                                    <div class="">
                                        <a class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" href="AgregarEgreso.aspx">Agregar Egreso</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <br />
                    <div class="overflow-x-auto relative shadow-md sm:rounded-lg">
                        
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="py-3 px-6">Proveedor
                                    </th>
                                    <th scope="col" class="py-3 px-6">Descripcion
                                    </th>
                                    <th scope="col" class="py-3 px-6">Monto
                                    </th>
                                    <th scope="col" class="py-3 px-6">Fecha
                                    </th>
                                     <th scope="col" class="py-3 px-6">Estado
                                    </th>
                                     <th scope="col" class="py-3 px-6">Doc Cobro
                                    </th>
                                    <th scope="col" class="py-3 px-6">Doc Pago
                                    </th>
                                    <th scope="col" class="py-3 px-6">Acciones
                                    </th>
                                </tr>
                            </thead>
                           
                            <tbody>
                            <% 
                                int idCondominio = 0;
                                int mesActualN = 0;
                                int añoActualN = 0;

                                idCondominio = (int)Session["idCondominio"];
                                mesActualN = (int)Session["mes"];
                                añoActualN = (int)Session["año"];

                                int totalCategorias = 0;
                                totalCategorias = EgresosDao.ObtenerTotalCategoriaEgresos(idCondominio, mesActualN, añoActualN);

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

                                        foreach (CategoriaEgresos obj in EgresosDao.GetAlObtenerCategoriasEgresos(idCondominio, mesActualN, añoActualN))
                                        {

                                %>

                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 h-1">
                                    <td  colspan="8" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white bg-gray-100 dark:bg-gray-900 dark:text-gray-400"><%=obj.Descrpcion %>
                                    </td>
                                    
                                </tr>
                                <%
                                    string urlSA = ConfigurationManager.AppSettings["urlSA"].ToString();
                                    string tokenSAS = ConfigurationManager.AppSettings["tokenArchivosSAS"].ToString();
                                    string containerSA = ConfigurationManager.AppSettings["containerArchivosSA"].ToString();

                                    foreach (Egresos obj1 in EgresosDao.GetAlObtenerEgresos(obj.id, idCondominio, mesActualN, añoActualN))
                                    {
                                        string fecha = obj1.Fecha.ToString("dd-MM-yyyy");
                                        string año = obj1.Fecha.ToString("yyyy");
                                        string mes = obj1.Fecha.ToString("MM");
                                        string url = urlSA + containerSA + "/" + año + "/" + mes + "/" + obj1.DocumentoCobro  + tokenSAS;
                                        string url2 = urlSA + containerSA + "/" + año + "/" + mes + "/" + obj1.Comprobante  + tokenSAS;
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
                                    <td class="py-4 px-6 md:grid-cols-2">
                                        <div class="editar ">
                                         <button type="button" data-id="<%=obj1.id %>" @click="openModal"
                                              class="btnEditar text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800">
                                              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                        </button>



                                        <button type="button" data-id="<%=obj1.id %>" data-modal-toggle="popup-modal" class="btnEliminar text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800">
                                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                        </button>

                                        </div>
                                        
                                    </td>
                                </tr>

                                <%}
                                        }
                                    }%>
                            </tbody>
                        </table>

                    </div>
                </div>
                </div>
                    <br />

                      <!-- Modal backdrop. This what you want to place close to the closing body tag -->
    <div
      x-show="isModalOpen"
      x-transition:enter="transition ease-out duration-150"
      x-transition:enter-start="opacity-0"
      x-transition:enter-end="opacity-100"
      x-transition:leave="transition ease-in duration-150"
      x-transition:leave-start="opacity-100"
      x-transition:leave-end="opacity-0"
      class="fixed inset-0 z-30 flex items-end bg-black bg-opacity-50 sm:items-center sm:justify-center"
    >
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
        id="modal"
      >
        <!-- Remove header if you don't want a close icon. Use modal body to place modal tile. -->
        <header class="flex justify-end">
          <button type="button"
            class="inline-flex items-center justify-center w-6 h-6 text-gray-400 transition-colors duration-150 rounded dark:hover:text-gray-200 hover: hover:text-gray-700"
            aria-label="close"
            @click="closeModal"
          >
            <svg
              class="w-4 h-4"
              fill="currentColor"
              viewBox="0 0 20 20"
              role="img"
              aria-hidden="true"
            >
              <path
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"
                fill-rule="evenodd"
              ></path>
            </svg>
          </button>
        </header>
          <!-- Modal body -->

          <div class="mt-4 mb-6 grid">
              <div class="grid gap-6 mb-8 md:grid-cols-2">
                  <div class="col-span-2 ">
                      <label for="DropDownListCategoria" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Categoría </label>
                      <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListCategoria" runat="server">
                      </asp:DropDownList>
                  </div>

                  <div>
                      <label for="DropDownListProveedor" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Proveedor</label>
                      <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListProveedor" runat="server">
                      </asp:DropDownList>
                  </div>

                  <div>
                      <label  class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Fecha</label>
                      
                      <div class="relative">
                          <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                              <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                  <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                          </div>
                          <input datepicker datepicker-autohide datepicker-format="dd-mm-yyyy" id="TextBoxFechaModal" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Seleccione fecha" runat="server" />
                      </div>
                  </div>

                  <div class="col-span-2 ">
                      <label class="block text-sm">
                          <span class="text-gray-700 dark:text-gray-400">Descripción</span>
                          <input type="text" runat="server" id="TextBoxDescModal"
                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t"
                               />
                      </label>
                  </div>
              </div>

              <div class="grid gap-6 mb-8 md:grid-cols-2">
                  <div>
                      <label class="block text-sm">
                          <span class="text-gray-700 dark:text-gray-400">Monto</span>
                          <input type="text" runat="server" id="TextBoxMontoModal"
                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" />
                      </label>
                  </div>

                  <div>
                      <label for="DropDownListEstado" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Estado</label>
                      <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListEstado" runat="server">
                          <asp:ListItem  Value="0">Seleccione Estado:</asp:ListItem>
                          <asp:ListItem Value="Pagado">Pagado</asp:ListItem>
                          <asp:ListItem Value="Pendiente">Pendiente</asp:ListItem>
                      </asp:DropDownList>
                  </div>
              </div>
          </div>
          <footer class="flex flex-col items-center justify-end px-6 py-3 -mx-6 -mb-4 space-y-4 sm:space-y-0 sm:space-x-6 sm:flex-row bg-gray-50 dark:bg-gray-800">
              <asp:Button ID="ButtonModificar" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purplee" runat="server" data-id="0" OnClick="ButtonModificar_Click" Text="Modificar" />                                 
              <input type="hidden" id="TextBoxId" name="TextBoxId" value="0" runat="server">                       
          </footer>

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
                                    <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Desea eliminar el egreso?</h3>
                                    <asp:Button ID="ButtonEliminar" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2" runat="server" data-id="0" OnClick="ButtonEliminar_Click" Text="Eliminar" />                                 
                                    <input type="hidden" id="TextBoxIdEliminar" name="TextBoxIdEliminar" value="0" runat="server">  
                                    <button data-modal-toggle="popup-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

      </form>
            </main>
            </div>
        </div>
      <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>

      <script>
          let editar = document.querySelectorAll(".btnEditar")

          editar.forEach((boton) => {
              boton.addEventListener("click", (event) => {
                  event.preventDefault()
                  var fila = event.target.parentElement.parentElement.parentElement.parentElement
                  let descripcion = fila.children[1].innerHTML

                  let monto = fila.children[2].innerHTML
                  let monto2 = monto.slice(1)

                  let id = fila.querySelector('.btnEditar').getAttribute('data-id')
                  let fecha = fila.children[3].innerHTML
                  let fecha2 = fecha.slice(0, -37)

                  let idProveedor = fila.querySelector('#idProveedor').getAttribute('data-id')
                  let selectProveedor = document.getElementById("DropDownListProveedor")
                  selectProveedor.value = idProveedor

                  let categoria = fila.querySelector('#idProveedor').getAttribute('data-categoria')
                  let selectCategoria = document.getElementById("DropDownListCategoria")
                  selectCategoria.value = categoria

                  let estado = fila.children[4].innerHTML
                  let estado2 = estado.slice(0, -37)
                  let selectEstado = document.getElementById("DropDownListEstado")
                  selectEstado.value = estado2

                  document.querySelector('#TextBoxDescModal').value = descripcion;
                  document.querySelector('#TextBoxMontoModal').value = monto2;
                  document.querySelector('#TextBoxFechaModal').value = fecha2;
                  document.querySelector('#TextBoxId').value = id;
                  document.querySelector('#ButtonModificar').setAttribute('data-id', id)
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
</body>
</html>