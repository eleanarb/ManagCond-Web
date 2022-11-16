<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="publicacionForo.aspx.cs" Inherits="ManagCond.Residente.publicacionForo" %>
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
      <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

      <link href="../assets/css/style.css" rel="stylesheet" type="text/css" />

    <!-- You need focus-trap.js to make the modal accessible -->
    <script src="../assets/js/focus-trap.js" defer></script>
  </head>
  <body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen}"
    >
        <!-- #include file ="Template/AsideResidente.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderResidente.html" -->
        <main class="h-full pb-16 overflow-y-auto">
            
          <div class="container grid px-6 mx-auto">
              <% 
                  int idForo = int.Parse(Request.QueryString["id"]);
                  Foro foro = ForoDao.ObtenerDatosPublicacion(idForo);
                  string fechaF = foro.Fecha.ToString("ddd dd  MMMM  yyyy");
                  string horaF = foro.Hora.ToString("hh':'mm''");
              %>

              <br />
              <nav class="flex" aria-label="Breadcrumb">
                  <ol class="inline-flex items-center space-x-1 md:space-x-3">
                      <li>
                          <div class="flex items-center">
                              <a href="foro.aspx" class="ml-1 text-sm font-medium text-gray-700 hover:text-gray-900 md:ml-2 dark:text-gray-400 dark:hover:text-white">Foro</a>
                          </div>
                      </li>
                      <li aria-current="page">
                          <div class="flex items-center">
                              <svg class="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                  <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                              <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2 dark:text-gray-400"><%=foro.categoria %></span>
                          </div>
                      </li>
                  </ol>
              </nav>

            <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200"> Foro </h2>

              

              <div class="p-4 bg-white rounded-lg border border-gray-200 shadow-sm dark:bg-gray-700 dark:border-gray-600">
                  <div class="justify-between items-center mb-3 sm:flex">
                      <time class="mb-1 text-xs font-normal text-gray-400 sm:order-last sm:mb-0"><%=fechaF %> | <%=horaF %></time>
                      <div class="text-3xl font-bold dark:text-white">
                          <h1><%=foro.Categoria %></h1>
                      </div>

                  </div>
                  <div class="text-sm font-normal text-gray-500 lex dark:text-gray-300">
                      Publicado por 
                             
                      <a href="#" class="font-semibold text-purple-600 dark:text-purple-800 hover:underline"><%=foro.nombre %></a>
                      - Departamento <%=foro.depto %>
                         
                  </div>
                  <br />
                   <div class="font-medium text-gray-900 dark:text-white">
                       <%=foro.mensaje %>
                   </div>
                      

                  <br />
                  <%--Añadir Comentario--%>


                  <form id="AgregarComentario" runat="server">
                      <div class="mb-4 w-full bg-gray-50 rounded-lg border border-gray-200 dark:bg-gray-700 dark:border-gray-600">
                          <div class="py-2 px-4 bg-white rounded-t-lg dark:bg-gray-800">
                              <label for="comment" class="sr-only">Tu respuesta</label>
                              <textarea runat="server" id="TextBoxMensaje" rows="4" class="form-control px-0 w-full text-sm text-gray-900 bg-white border-0 dark:bg-gray-800 focus:ring-0 dark:text-white dark:placeholder-gray-400" placeholder="Escribe un comentario..." required=""></textarea>
                          </div>
                          <div class="flex justify-between items-center py-2 px-3 border-t dark:border-gray-600">
                              <asp:Button ID="ButtonAgregar" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar Respuesta" />
                       
                              <div class="flex pl-0 space-x-1 sm:pl-2">
                                  <button type="button" class="inline-flex justify-center p-2 text-gray-500 rounded cursor-pointer hover:text-gray-900 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600">
                                      <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                          <path fill-rule="evenodd" d="M4 3a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V5a2 2 0 00-2-2H4zm12 12H4l4-8 3 6 2-4 3 6z" clip-rule="evenodd"></path></svg>
                                      <span class="sr-only">Upload image</span>
                                  </button>
                              </div>
                          </div>
                      </div>
                  </form>
                  <p class="ml-auto text-xs text-gray-500 dark:text-gray-400">Recuerda seguir las  <a href="#" class="text-blue-600 dark:text-blue-500 hover:underline">reglas comunitarias</a>.</p>
                  <br>
                  <%--Comentarios--%>
                  <div class="p-5 bg-gray-50 rounded-lg border border-gray-100 dark:bg-gray-800 dark:border-gray-700">
                      <time class="text-lg font-semibold text-gray-900 dark:text-white">Comentarios</time>

                      <% 
                          int respuestas = ForoDao.ObtenerTotalRespuestas(idForo);
                          if (respuestas == 0)
                          {
                      %>
                      <div class="flex-1 p-1"><div class="text-center py-10 text-gray-500 dark:text-slate-400"><p>No hay comentarios...</p></div></div>  
                      <% }
                          else
                          { %>                 

                      <ol class="mt-3 divide-y divider-gray-200 dark:divide-gray-700">
                          <%
                              foreach (RespuestaForo obj in ForoDao.GetAlRespuestasForo(idForo))
                              {
                                  string fechaR = obj.Fecha.ToString("ddd dd  MMMM  yyyy");
                                  string horaR = obj.Hora.ToString("hh':'mm''");

                                  if (obj.TipoUsuario == 1)
                                  {
                              %>
                            <li>
                              <a href="#" class="block items-center p-3 sm:flex  ">
                                  <%--<img class="mr-3 mb-3 w-12 h-12 rounded-full sm:mb-0" src="/docs/images/people/profile-picture-4.jpg" alt="Laura Romeros image">--%>
                                  <div class="text-gray-600 dark:text-gray-400">
                                      <div class="text-base font-normal"><span class="font-medium text-gray-900 dark:text-white"><%=obj.Nombre %></span><span class="text-sm font-normal text-gray-500 lex dark:text-gray-300"> - Administrador</span></div>
                                      <br />
                                      <div class="text-sm font-normal"><%=obj.Mensaje %></div>
                                      <span class="inline-flex items-center text-xs font-normal text-gray-500 dark:text-gray-400">
                                          <%--<svg aria-hidden="true" class="mr-1 w-3 h-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">--%>
                                              <%--<path fill-rule="evenodd" d="M3.707 2.293a1 1 0 00-1.414 1.414l14 14a1 1 0 001.414-1.414l-1.473-1.473A10.014 10.014 0 0019.542 10C18.268 5.943 14.478 3 10 3a9.958 9.958 0 00-4.512 1.074l-1.78-1.781zm4.261 4.26l1.514 1.515a2.003 2.003 0 012.45 2.45l1.514 1.514a4 4 0 00-5.478-5.478z" clip-rule="evenodd"></path><path d="M12.454 16.697L9.75 13.992a4 4 0 01-3.742-3.741L2.335 6.578A9.98 9.98 0 00.458 10c1.274 4.057 5.065 7 9.542 7 .847 0 1.669-.105 2.454-.303z"></path></svg>--%>
                                          <%=fechaR %> | <%=horaR %>
                                      </span>
                                  </div>
                              </a>
                          </li>
                          <%}
                              else
                              { %>
                           <li>
                              <a href="#" class="block items-center p-3 sm:flex  ">
                                  <%--<img class="mr-3 mb-3 w-12 h-12 rounded-full sm:mb-0" src="/docs/images/people/profile-picture-4.jpg" alt="Laura Romeros image">--%>
                                  <div class="text-gray-600 dark:text-gray-400">
                                      <div class="text-base font-normal"><span class="font-medium text-gray-900 dark:text-white"><%=obj.Nombre %></span><span class="text-sm font-normal text-gray-500 lex dark:text-gray-300"> - Departamento <%=obj.Depto %></span></div>
                                      <br />
                                      <div class="text-sm font-normal"><%=obj.Mensaje %></div>
                                      <span class="inline-flex items-center text-xs font-normal text-gray-500 dark:text-gray-400">
                                          <%--<svg aria-hidden="true" class="mr-1 w-3 h-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">--%>
                                              <%--<path fill-rule="evenodd" d="M3.707 2.293a1 1 0 00-1.414 1.414l14 14a1 1 0 001.414-1.414l-1.473-1.473A10.014 10.014 0 0019.542 10C18.268 5.943 14.478 3 10 3a9.958 9.958 0 00-4.512 1.074l-1.78-1.781zm4.261 4.26l1.514 1.515a2.003 2.003 0 012.45 2.45l1.514 1.514a4 4 0 00-5.478-5.478z" clip-rule="evenodd"></path><path d="M12.454 16.697L9.75 13.992a4 4 0 01-3.742-3.741L2.335 6.578A9.98 9.98 0 00.458 10c1.274 4.057 5.065 7 9.542 7 .847 0 1.669-.105 2.454-.303z"></path></svg>--%>
                                          <%=fechaR %> | <%=horaR %>
                                      </span>
                                  </div>
                              </a>
                          </li>
                          <% }
                                  }
                              }%>
                      </ol>
                  </div>



              </div>

              
              

          </div>





            

        </main>
      </div>
    </div>
      <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
    <!-- End of modal backdrop -->
  </body>
</html>

