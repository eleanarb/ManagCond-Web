﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reservas.aspx.cs" Inherits="ManagCond.reservas" %>
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

     


    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
    />

    <!-- Demo styles -->
    <style>
      

      .swiper {
        width: 100%;
        height: 100%;
      }

      .swiper-slide {
        text-align: center;
        font-size: 18px;;
      }

      .swiper-slide img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
    </style>
  </head>
  <body>
      <% 
          int idCondominio = 0;
          idCondominio = (int)Session["idCondominio"];
      %>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
              <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
            <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid">

                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Reservas Solicitadas
                    </h2>
                    
                        <div class="swiper mySwiper" id="reservas-pendientes">
                            <div class="swiper-wrapper">
                                
                                    <%
                                        int totalReservasP = 0;
                                        totalReservasP = ReservaDao.ObtenerTotalReservasPendientes(idCondominio);

                                        if(totalReservasP == 0)
                                        { %>
                                        
                                        <div class="flex-1 p-6"><div class="text-center py-24 text-gray-500 dark:text-slate-400"><p>Estás al día, no hay reservas pendientes!</p></div></div>  
                                       <% }else{
                                        
                                        foreach (Reserva obj1 in ReservaDao.GetAlReservasPendientes(idCondominio))
                                        {
                                            int idReserva = obj1.Id;
                                            string fecha = obj1.Fecha.ToString("ddd dd  MMMM  yyyy");
                                    %>

                                    <div class="swiper-slide">
                                        <div
                                            class="px-4 py-3 mb-8 bg-white rounded-lg shadow-md dark:bg-gray-800">
                                            <h2 class="font-semibold text-gray-700 dark:text-gray-200"><strong><%=obj1.EspacioComun %></strong></h2>
                                            <i class="mb-4 text-gray-600 dark:text-gray-400">Dpto <%=obj1.NumDpto%> - <%=obj1.Solicitante %> </i>
                                            <br />
                                            <p class="mb-4 text-gray-600 dark:text-gray-400"><%=fecha %> <br />
                                                <%=obj1.RangoHorario %></p>

                                            <button data-id="<%=idReserva%>"
                                                @click="openModal"
                                                class="btnReservaP px-4 py-2 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple"
                                              >
                                                Modificar
                                           </button>
                                        </div>                                           
                                    </div>
                                    <%} }%>
                            </div>
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-pagination"></div>
                        </div>
                        	
                        
     
                    
                        

                    <h2
                        class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Historial de Reservas
                    </h2>

                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
              <div class="w-full overflow-x-auto">
                <table class="w-full whitespace-no-wrap">
                  <thead>
                    <tr
                      class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800"
                    >
                      <th class="px-4 py-3">Departamento</th>
                      <th class="px-4 py-3">Solicitante</th>
                      <th class="px-4 py-3">Espacio Común</th>
                      <th class="px-4 py-3">Fecha</th>
                      <th class="px-4 py-3">Hora</th>
                      <th class="px-4 py-3">Estado</th>

                    </tr>
                  </thead>
                    

                    <tbody
                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800"
                  >
                    <%

                      foreach (Reserva obj in ReservaDao.GetAlReservasAnteriores(idCondominio))
                       {
                                
                    %>

                    <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold"><%=obj.NumDpto %></p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold"><%=obj.Solicitante %></p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        <%=obj.EspacioComun %>
                      </td>
                       <td class="px-4 py-3 text-sm">
                        <%=obj.Fecha %>
                      </td>
                        <td class="px-4 py-3 text-sm">
                        <%=obj.RangoHorario %>
                      </td>
                       <td class="px-4 py-3 text-xs">
                            <%if (obj.Estado == 2)
                                { %>
                            <span
                                class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-700">Aprobado
                            </span>

                            <%}
                                                else if (obj.Estado == 1)
                                                { %>
                            <span
                                class="px-2 py-1 font-semibold leading-tight text-gray-700 bg-gray-100 rounded-full dark:text-gray-100 dark:bg-gray-700">Pendiente
                            </span>

                            <%}
                                                else if (obj.Estado == 3)
                                                { %>
                            <span
                                class="px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700">Rechazado
                            </span>
                        </td>       
                        <%} %>
                    </tr>
                    <%
                                            
                       }
                    %>
                    
                  </tbody>
                </table>
              </div>
              <div
                class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800"
              >
                <span class="flex items-center col-span-3">
                  Showing 21-30 of 100
                </span>
                <span class="col-span-2"></span>
                <!-- Pagination -->
                <span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
                  <nav aria-label="Table navigation">
                    <ul class="inline-flex items-center">
                      <li>
                        <button
                          class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple"
                          aria-label="Previous"
                        >
                          <svg
                            aria-hidden="true"
                            class="w-4 h-4 fill-current"
                            viewBox="0 0 20 20"
                          >
                            <path
                              d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                              clip-rule="evenodd"
                              fill-rule="evenodd"
                            ></path>
                          </svg>
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          1
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          2
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 text-white transition-colors duration-150 bg-purple-600 border border-r-0 border-purple-600 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          3
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          4
                        </button>
                      </li>
                      <li>
                        <span class="px-3 py-1">...</span>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          8
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          9
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple"
                          aria-label="Next"
                        >
                          <svg
                            class="w-4 h-4 fill-current"
                            aria-hidden="true"
                            viewBox="0 0 20 20"
                          >
                            <path
                              d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                              clip-rule="evenodd"
                              fill-rule="evenodd"
                            ></path>
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
          <button
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
          <form id="reserva" runat="server">
        <div class="mt-4 mb-6">
            <input type="hidden" id="idReserva" name="TextBoxId" value="0" runat="server">     
          <!-- Modal title -->
          <p class="mb-2 text-lg font-semibold text-gray-700 dark:text-gray-300" id="titulo">
            titulo-evento
          </p>
          <!-- Modal description -->
          <p class="text-sm text-gray-700 dark:text-gray-400" id="depto">
            depto
          </p>
          <p class="text-sm text-gray-700 dark:text-gray-400" id="fecha">
            fecha
          </p>
        </div>
        <footer
          class="flex flex-col items-center justify-end px-6 py-3 -mx-6 -mb-4 space-y-4 sm:space-y-0 sm:space-x-6 sm:flex-row bg-gray-50 dark:bg-gray-800"
        >
          <asp:Button ID="ButtonAprobar" class="form-control w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-teal-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-teal-600 hover:bg-teal-600 focus:outline-none focus:shadow-outline-green" runat="server" OnClick="ButtonAprobar_Click" Text="Aprobar" />
          <asp:Button ID="ButtonRechazar" class="form-control w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-red-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-red-600 hover:bg-red-700 focus:outline-none focus:shadow-outline-red" runat="server" OnClick="ButtonRechazar_Click" Text="Rechazar" />
         
        </footer>
              </form>
      </div>
    </div>
    <!-- End of modal backdrop -->

        </div>
</body>

    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
        var swiper = new Swiper(".mySwiper", {
            slidesPerView: 3,
            spaceBetween: 30,
            slidesPerGroup: 3,
            loop: true,
            loopFillGroupWithBlank: true,
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
        });
    </script>

    <script>
        let editar = document.querySelectorAll(".btnReservaP")

          editar.forEach((boton) => {
              boton.addEventListener("click", (event) => {
                  event.preventDefault()
                  var reserva = event.target.parentElement

                  espacioComun = reserva.querySelector('h2').textContent
                  depto = reserva.querySelector('i').textContent
                  fecha =  reserva.querySelector('p').textContent
                  id =  reserva.querySelector('.btnReservaP').getAttribute('data-id')

                  document.querySelector('#titulo').innerText = espacioComun;
                  document.querySelector('#depto').innerText = depto;
                  document.querySelector('#fecha').innerText = fecha;
                  document.querySelector('#idReserva').value = id;
                  
              })
          })
    </script>



</html>
