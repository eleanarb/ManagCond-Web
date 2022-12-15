<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionarEspaciosComunes.aspx.cs" Inherits="ManagCond.Administrador.GestionarEspaciosComunes" %>
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
</head>
<body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }">
        <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
            <main class="h-full overflow-y-auto">
                <form runat="server" id="form">
                    <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Gestion de espacios comunes</h2>
                        <div class="">
                            <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                                <div class="grid grid-cols-6 items-center">
                                    <div class="">
                                    </div>
                                    <div class="">
                                    </div>
                                    <div class="">
                                    </div>
                                    <div></div>
                                    <div class="col-end-4 ">
                                    </div>
                                    <div class="col-end-4 ">
                                        <button id="buttonList" type="button" @click="openModal" class="px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple">
                                            Agregar espacio comun
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="overflow-x-auto relative shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="py-3 px-6">Nombre</th>
                                        <th scope="col" class="py-3 px-6">Descripcion</th>
                                        <th scope="col" class="py-3 px-6">Monto</th>
                                        <th scope="col" class="py-3 px-6">Rango Horario</th>
                                        <th scope="col" class="py-3 px-6">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        int idCondominio = (int)Session["idCondominio"];

                                        int totalEspaciosComunes = EspacioComunDao.ObtenerTotalEspacioComunes(idCondominio);

                                        if (totalEspaciosComunes == 0)
                                        {
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <th colspan="4" scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">No hay espacios comues registrados en el mes 
                                        </th>
                                    </tr>
                                    <%
                                        }
                                        else
                                        {

                                            foreach (EspacioComun obj in EspacioComunDao.GetAlEspacioComunes(idCondominio))
                                            {
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white"><%=obj.Nombre %>
                                        </th>
                                        <td class="py-4 px-6"><%=obj.Descripcion %>
                                        </td>
                                        <td class="py-4 px-6"><%=obj.Monto %>
                                        </td>
                                        <td class="py-4 px-6"><%=obj.RangoHorario %>
                                        </td>
                                        <td class="py-4 px-6 md:grid-cols-2">

                                            <a class="text-white bg-green-700 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-green-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800" href="EditarEspacioComun.aspx?id=<%= obj.Id %>">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                                            </a>



                                            <button type="button" data-modal-toggle="popup-modal" data-id="<%=obj.Id %>" class="btnEliminar text-white bg-red-700 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-800">
                                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                                            </button>

                                        </td>
                                    </tr>
                                    <%}
                                        }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <br>
                    <br>
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
              <p class="mb-2 text-lg font-semibold text-gray-700 dark:text-gray-300">Agregar Encomienda </p>
              <!-- Modal description -->
                  <div class="w-full">
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                        <asp:TextBox ID="TextBoxNombre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeNombre" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Descripcion</span>
                                        <asp:TextBox ID="TextBoxDesc" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeDesc" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Monto</span>
                                        <asp:TextBox ID="TextBoxMonto" type="number" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeMonto" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label for="DropDownListHoraIncio" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Hora inicio</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListHoraIncio" runat="server">
                                        <asp:ListItem Value="00:00">00:00</asp:ListItem>
                                        <asp:ListItem Value="01:00">01:00</asp:ListItem>
                                        <asp:ListItem Value="02:00">02:00</asp:ListItem>
                                        <asp:ListItem Value="03:00">03:00</asp:ListItem>
                                        <asp:ListItem Value="04:00">04:00</asp:ListItem>
                                        <asp:ListItem Value="05:00">05:00</asp:ListItem>
                                        <asp:ListItem Value="06:00">06:00</asp:ListItem>
                                        <asp:ListItem Value="07:00">07:00</asp:ListItem>
                                        <asp:ListItem Value="08:00">08:00</asp:ListItem>
                                        <asp:ListItem Value="09:00">09:00</asp:ListItem>
                                        <asp:ListItem Value="10:00">10:00</asp:ListItem>
                                        <asp:ListItem Value="11:00">11:00</asp:ListItem>
                                        <asp:ListItem Value="12:00">12:00</asp:ListItem>
                                        <asp:ListItem Value="13:00">13:00</asp:ListItem>
                                        <asp:ListItem Value="14:00">14:00</asp:ListItem>
                                        <asp:ListItem Value="15:00">15:00</asp:ListItem>
                                        <asp:ListItem Value="15:00">16:00</asp:ListItem>
                                        <asp:ListItem Value="17:00">17:00</asp:ListItem>
                                        <asp:ListItem Value="18:00">18:00</asp:ListItem>
                                        <asp:ListItem Value="19:00">19:00</asp:ListItem>
                                        <asp:ListItem Value="20:00">20:00</asp:ListItem>
                                        <asp:ListItem Value="21:00">21:00</asp:ListItem>
                                        <asp:ListItem Value="22:00">22:00</asp:ListItem>
                                        <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="mensajeHoraInicio" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label for="DropDownListHoraFin" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Hora fin</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListHoraFin" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione hora fin:</asp:ListItem>
                                        <asp:ListItem Value="00:00">00:00</asp:ListItem>
                                        <asp:ListItem Value="01:00">01:00</asp:ListItem>
                                        <asp:ListItem Value="02:00">02:00</asp:ListItem>
                                        <asp:ListItem Value="03:00">03:00</asp:ListItem>
                                        <asp:ListItem Value="04:00">04:00</asp:ListItem>
                                        <asp:ListItem Value="05:00">05:00</asp:ListItem>
                                        <asp:ListItem Value="06:00">06:00</asp:ListItem>
                                        <asp:ListItem Value="07:00">07:00</asp:ListItem>
                                        <asp:ListItem Value="08:00">08:00</asp:ListItem>
                                        <asp:ListItem Value="09:00">09:00</asp:ListItem>
                                        <asp:ListItem Value="10:00">10:00</asp:ListItem>
                                        <asp:ListItem Value="11:00">11:00</asp:ListItem>
                                        <asp:ListItem Value="12:00">12:00</asp:ListItem>
                                        <asp:ListItem Value="13:00">13:00</asp:ListItem>
                                        <asp:ListItem Value="14:00">14:00</asp:ListItem>
                                        <asp:ListItem Value="15:00">15:00</asp:ListItem>
                                        <asp:ListItem Value="15:00">16:00</asp:ListItem>
                                        <asp:ListItem Value="17:00">17:00</asp:ListItem>
                                        <asp:ListItem Value="18:00">18:00</asp:ListItem>
                                        <asp:ListItem Value="19:00">19:00</asp:ListItem>
                                        <asp:ListItem Value="20:00">20:00</asp:ListItem>
                                        <asp:ListItem Value="21:00">21:00</asp:ListItem>
                                        <asp:ListItem Value="22:00">22:00</asp:ListItem>
                                        <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                        <asp:ListItem Value="23:00">23:00</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="mensajeHoraFin" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                             <span id="mensajeRangoHorario" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                      <br />
                      <br />
                  </div>
                  <footer class="flex flex-col items-center justify-end px-6 py-3 -mx-6 -mb-4 space-y-4 sm:space-y-0 sm:space-x-6 sm:flex-row bg-gray-50 dark:bg-gray-800">
                       <button @click="closeModal" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Cancel</button>
                      <asp:Button ID="ButtonAgregar" OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                  </footer>
          </div>  
      </div>
    </div>



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
                                    <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Desea eliminar el espacio comun?</h3>
                                    <asp:Button ID="ButtonEliminar" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2" runat="server" data-id="0" OnClick="ButtoEliminar_Click" Text="Eliminar" />
                                    <input type="hidden" id="TextBoxIdEliminar" name="TextBoxIdEliminar" value="0" runat="server">
                                    <button data-modal-toggle="popup-modal" type="button" class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
        <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
        <script>
            var letras = /[a-zA-Z ]+$/;
            var numeros = /^[0-9]+$/;

            $('#TextBoxNombre').on('keyup', function () {
                if (!letras.test($('#TextBoxNombre').val())) {
                    $('#mensajeNombre').html('Ingrese nombre valido').css('color', 'red');

                } else
                    $('#mensajeNombre').html('').css('color', 'green');
            });
            $('#TextBoxDesc').on('keyup', function () {
                if (!letras.test($('#TextBoxDesc').val())) {
                    $('#mensajeDesc').html('Ingrese descripcion valido').css('color', 'red');

                } else
                    $('#mensajeDesc').html('').css('color', 'green');
            });
            $('#TextBoxMonto').on('keyup', function () {
                if (!numeros.test($('#TextBoxMonto').val())) {
                    $('#mensajeMonto').html('Ingrese monto valido').css('color', 'red');

                } else
                    $('#mensajeMonto').html('').css('color', 'green');
            });
        </script>
        <script>
            function validarFormulario(evento) {
                if (!letras.test($('#TextBoxNombre').val())) {
                    $('#mensajeNombre').html('Ingrese nombre valido').css('color', 'red');
                    return false;
                } else {
                }
                if (!letras.test($('#TextBoxDesc').val())) {
                    $('#mensajeDesc').html('Ingrese descripcion valido').css('color', 'red');
                    return false;
                } else {
                }
                if (!numeros.test($('#TextBoxMonto').val())) {
                    $('#mensajeMonto').html('Ingrese monto valido').css('color', 'red');
                    return false;
                } else {
                }
                var horaInicio = document.getElementById('DropDownListHoraIncio');
                if (horaInicio.value < 1) {
                    $('#mensajeHoraInicio').html('Ingrese hora inicio').css('color', 'red');
                    return false;
                } else {
                    $('#mensajeHoraInicio').html('').css('color', 'green');
                }
                var horaFin = document.getElementById('DropDownListHoraFin');
                if (horaFin.value < 1) {
                    $('#mensajeHoraFin').html('Ingrese hora fin').css('color', 'red');
                    return false;
                } else {
                    $('#mensajeHoraFin').html('').css('color', 'green');
                    return true;
                }
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
        <script>
            let eliminar = document.querySelectorAll(".btnEliminar")

            eliminar.forEach((botonE) => {
                botonE.addEventListener("click", (eventE) => {
                    eventE.preventDefault()
                    var filaE = eventE.target.parentElement.parentElement

                    let idE = filaE.querySelector('.btnEliminar').getAttribute('data-id')
                    localStorage.setItem('espacioComun', idE)
                    document.querySelector('#TextBoxIdEliminar').value = idE;
                })
            })
        </script>
</body>
</html>
