<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gestionCargos.aspx.cs" Inherits="ManagCond.Administrador.tipoGastos" %>

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
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../assets/css/tailwind.output.css" />
    <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
      defer
    ></script>
    <script src="../assets/js/init-alpine.js"></script>
      <script src="../assets/js/focus-trap.js" defer></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css"
    />
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
      defer
    ></script>
    
    <script src="../assets/js/charts-lines.js" defer></script>
    <script src="../assets/js/charts-pie.js" defer></script>
    
<link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Gestión de Cargos</h2>
                    <div class="">                         
                        
                        
                       
                            <div class="grid grid-cols-5 items-center">
                                <div class="col-span-3">
                                    <label for="default-search" class="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-gray-300">Search</label>
                                    <div class="relative">
                                        <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                            <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                        </div>
                                        <input type="search" id="default-search" class="block p-4 pl-10 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Search Mockups, Logos...">
                                        <button type="submit" class="text-white absolute right-2.5 bottom-2.5 bg-purple-600 hover:bg-purple-700 focus:ring-4 focus:outline-none focus:ring-purple-300 font-medium rounded-lg text-sm px-4 py-2">Search</button>
                                    </div>
                                </div>

                                <div></div>

                                <div class="col-end-5 ">
                                    <button id="btnagregar" type="button" onclick="mostrar();"
                                        class="block w-full px-4 py-2 mt-4 text-sm text-center font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">
                                        Agregar
                                    </button>
                                </div>
                       


                        </div>
                        <br />
                    <div class="overflow-x-auto relative shadow-md sm:rounded-lg">
                        
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="py-3 px-6">Nombre
                                    </th>
                                    <th scope="col" class="py-3 px-6">Descripcion
                                    </th>
                                    <th scope="col" class="py-3 px-6">Monto
                                    </th>
                                    <th scope="col" class="py-3 px-6">Multa
                                    </th>
                                    <th scope="col" class="py-3 px-6">Acciones
                                    </th>
                                </tr>
                            </thead>
                           
                            <tbody>
                             <tr id="filaAgregar" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                 
                                    <th class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        <input type="text" id="TextBoxNombre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Nombre" runat="server" >                                    
                                    </th>
                                    <td class="py-4 px-6">
                                        <input type="text" id="TextBoxDesc" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Descripcion" runat="server" >
                                    </td>
                                    <td class="py-4 px-6">
                                        <input type="number" id="TextBoxMonto" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Monto" runat="server" >
                                    </td>
                                    
                                    <td class="py-4 px-6">
                                        <div class="grid grid-cols-4">
                                            <div>
                                                <label class="inline-flex items-center text-gray-600 dark:text-gray-400">
                                                    <input runat="server" type="radio" class="text-purple-600 form-radio focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" id="MultaSi" name="CheckMulta" value="2">
                                                    <span class="ml-2">Si</span>
                                                </label>
                                            </div>
                                            <div>
                                                <label class="inline-flex items-center ml-6 text-gray-600 dark:text-gray-400">
                                                    <input runat="server" type="radio" class="text-purple-600 form-radio focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" id="MultaNo" name="CheckMulta" value="1">
                                                    <span class="ml-2">No</span>
                                                </label>
                                            </div>
                                        </div>
                                    </td>

                                 <td class="py-4 px-6 grid grid-rows-4 text-center">
                                     <div>
                                         <asp:Button ID="ButtonAgregar" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purplee" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />                                 
                                     </div>
                                     <br />
                                     <div>
                                         <a style="cursor: pointer; text-decoration-line: underline;" onclick="ocultar();" class="font-medium text-red-600 dark:text-red-500 hover:underline">Cancelar</a>

                                     </div>
                                 </td>
                             </tr>
                            <% 
                                int idCondominio = 0;
                                idCondominio = (int)Session["idCondominio"];

                                int totalTipoGastos = 0;
                                totalTipoGastos = OtrosGastosDao.ObtenerTotalTipoGastos(idCondominio);

                                if (totalTipoGastos == 0)
                                {
                            %>
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">                                    
                                    <th colspan="5" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay cargos registrados 
                                    </th>
                                </tr>
                                <%
                                    }
                                    else
                                    {

                                        foreach (TipoGastos obj in OtrosGastosDao.GetAlTipoGastos(idCondominio))
                                        {
                                %>
                                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                 
                                    <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white"><%=obj.Nombre %>
                                    </th>
                                    <td class="py-4 px-6"><%=obj.Descripcion %>
                                    </td>
                                    <td class="py-4 px-6">$<%=obj.Monto %>
                                    </td>
                                    <%if (obj.Multa == 1)
                                    { %>
                                    <td class="py-4 px-6">NO</td>
                                    <%}
                                    else
                                    { %>
                                    <td class="py-4 px-6">SI</td>
                                    <%} %>
                                    <td class="py-4 px-6">
                                        <div class="editar">
                                            <button type="button" data-id="<%=obj.id %>" @click="openModal"
                                                class="btnEditar block w-full px-4 py-2 mt-4 text-sm text-center font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">
                                                Editar
                                            </button>

                                        </div>
                                        
                                    </td>
                                </tr>

                                <%}
                                    }%>
                            </tbody>
                        </table>
                    </div>
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
        @click.away="closeModal"
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

                  <div>
                      <label class="block text-sm">
                          <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                          <input type="text" runat="server" id="TextBoxNombreModal"
                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                               />
                      </label>
                  </div>
                  <div>
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
                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                               />
                      </label>
                  </div>

                  <div>
                      <span class="text-gray-700 dark:text-gray-400">Multa</span>
                      <div class="grid grid-cols-4">
                          <div>
                              <label class="inline-flex items-center text-gray-600 dark:text-gray-400">
                                  <input value="2" name="CheckMulta" type="radio" id="MultaSiModal" class="text-purple-600 form-radio focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" runat="server">
                                  <span class="ml-2">Si</span>
                              </label>
                          </div>
                          <div>
                              <label class="inline-flex items-center ml-6 text-gray-600 dark:text-gray-400">
                                  <input value="1" name="CheckMulta" type="radio" id="MultaNoModal" class="text-purple-600 form-radio focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" runat="server">
                                  <span class="ml-2">No</span>
                              </label>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          <footer class="flex flex-col items-center justify-end px-6 py-3 -mx-6 -mb-4 space-y-4 sm:space-y-0 sm:space-x-6 sm:flex-row bg-gray-50 dark:bg-gray-800">
              <asp:Button ID="ButtonModificar" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purplee" runat="server" OnClick="ButtonModificar_Click" data-id="0" Text="Modificar" />                                 
              <input type="hidden" id="TextBoxId" name="TextBoxId" value="0" runat="server">                       
          </footer>

      </div>
    </div>
      <!-- End of modal backdrop -->

      </form>
            </main>
            </div>
        </div>
    

            <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>

            <script>
                document.getElementById('filaAgregar').style.display = 'none';
                document.etElementsByClassName('guardarCambios').style.display = 'none';
                function mostrar() {
                    document.getElementById('filaAgregar').style.display = '';
                }

                function ocultar() {
                    document.getElementById('filaAgregar').style.display = 'none';
                }

            </script>

      <script>
          let editar = document.querySelectorAll(".btnEditar")

          editar.forEach((boton) => {
              boton.addEventListener("click", (event) => {
                  event.preventDefault()
                  var fila = event.target.parentElement.parentElement.parentElement
                  let nombre = fila.children[0].innerHTML
                  let descripcion = fila.children[1].innerHTML

                  let monto = fila.children[2].innerHTML
                  let monto2 = monto.slice(1)

                  let id = fila.querySelector('.btnEditar').getAttribute('data-id')
                  let multa = fila.children[3].innerHTML

                  document.querySelector('#TextBoxNombreModal').value = nombre;
                  document.querySelector('#TextBoxDescModal').value = descripcion;
                  document.querySelector('#TextBoxMontoModal').value = monto2;
                  document.querySelector('#TextBoxId').value = id;
                  document.querySelector('#ButtonModificar').setAttribute('data-id', id)

                  localStorage.setItem('multa', multa)
                  if (multa == 'SI') {
                      document.querySelector('#MultaSiModal').checked = true;
                      localStorage.setItem('modal', 'si')

                  } else {
                      document.querySelector('#MultaNoModal').checked = true;
                      localStorage.setItem('modal', 'no')
                  }
                  
              })
              
          })
      </script>

</body>




</html>