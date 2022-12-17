<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Foro.aspx.cs" Inherits="ManagCond.Residente.Foro" %>
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
      :class="{ 'overflow-hidden': isSideMenuOpen}">
        <!-- #include file ="Template/AsideResidente.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderResidente.html" -->
            <main class="h-full pb-16 overflow-y-auto">
                <form id="foro" runat="server">
                    <div class="container grid px-6 mx-auto">
                        <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Foro </h2>
                        <div class="flex">
                            <asp:DropDownList class="block p-2.5 w-100 z-20 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-multiselect focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListBuscar" runat="server">
                                <asp:ListItem Selected="True" Value="0"> Todas las categorías </asp:ListItem>
                            </asp:DropDownList>
                            <div class="relative w-full">
                                <input type="search" id="search-dropdown" class="block p-2.5 w-full z-20 text-sm text-gray-900 bg-gray-50 rounded-r-lg border-l-gray-50 border-l-2 border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-l-gray-700  dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:border-blue-500" placeholder="Buscar...">
                                <button type="submit" class="absolute top-0 right-0 p-2.5 text-sm font-medium text-white bg-purple-600 rounded-r-lg border border-purple-700 hover:bg-purple-700 focus:ring-4 focus:outline-none focus:ring-purple-300">
                                    <svg aria-hidden="true" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                                    <span class="sr-only">Buscar</span>
                                </button>
                            </div>
                        </div>
                        <br />
                        <ol class="relative border-l border-gray-200 dark:border-gray-700">
                            <%=""%>
                            <% 
                                int idCondominio = 0;
                                idCondominio = (int)Session["idCond"];
                                foreach (Foro obj in ForoDao.GetAlPublicacionesForo(idCondominio))
                                {
                                    int idPublicacion = obj.Id;
                                    string fecha = obj.Fecha.ToString("ddd dd  MMMM  yyyy");
                                    string hora = obj.Hora.ToString("hh':'mm''");

                                    int respuestas = ForoDao.ObtenerTotalRespuestas(idPublicacion);
                                    if (obj.TipoUsuario == 3)
                                    {
                            %>
                            <li class="mb-10 ml-6">
                                <span class="flex absolute -left-3 justify-center items-center w-6 h-6 bg-purple-500 rounded-full dark:bg-purple-500"></span>
                                <div class="p-4 bg-white rounded-lg border border-gray-200 shadow-sm dark:bg-gray-700 dark:border-gray-600">
                                    <div class="justify-between items-center mb-3 sm:flex">
                                        <time class="mb-1 text-xs font-normal text-gray-400 sm:order-last sm:mb-0"><%=fecha %> | <%=hora %></time>
                                        <div class="font-bold font-normal text-gray-700 lex dark:text-gray-100">
                                            <h1><%=obj.Categoria %></h1>
                                        </div>
                                    </div>
                                    <div class="text-sm font-normal text-gray-500 lex dark:text-gray-300">
                                        Publicado por 
                              <a href="#" class="font-semibold text-purple-600 dark:text-purple-800 hover:underline"><%=obj.Nombre %></a>
                                        - Departamento <%=obj.Depto %>
                                    </div>
                                    <div class=" p-3 text-sm italic font-normal text-gray-500 bg-gray-50 rounded-lg border border-gray-200 dark:bg-gray-800 dark:border-gray-600 dark:text-gray-300">
                                        <p>
                                            <%=obj.Mensaje %>
                                            <br />
                                        </p>
                                    </div>
                                    <p class="text-gray-500 dark:text-gray-300">
                                        <a class="inline-flex items-center w-full px-2 py-1 text-sm  transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200" href="publicacionForo.aspx?id=<%= obj.id%>">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 8.25h9m-9 3H12m-9.75 1.51c0 1.6 1.123 2.994 2.707 3.227 1.129.166 2.27.293 3.423.379.35.026.67.21.865.501L12 21l2.755-4.133a1.14 1.14 0 01.865-.501 48.172 48.172 0 003.423-.379c1.584-.233 2.707-1.626 2.707-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0012 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018z"></path>
                                            </svg>
                                            &nbsp;&nbsp;                   
                                  <span><%=respuestas %> Comentarios</span>
                                        </a>
                                    </p>
                                </div>
                            </li>
                            <%      }
                                else
                                {
                                    if (obj.TipoUsuario == 2)
                                    {
                            %>
                            <li class="mb-10 ml-6">
                                <span class="flex absolute -left-3 justify-center items-center w-6 h-6 bg-purple-500 rounded-full dark:bg-purple-500"></span>
                                <div class="p-4 bg-white rounded-lg border border-gray-200 shadow-sm dark:bg-gray-700 dark:border-gray-600">
                                    <div class="justify-between items-center mb-3 sm:flex">
                                        <time class="mb-1 text-xs font-normal text-gray-400 sm:order-last sm:mb-0"><%=fecha %> | <%=hora %></time>
                                        <div class="font-bold font-normal text-gray-700 lex dark:text-gray-100">
                                            <h1><%=obj.Categoria %></h1>
                                        </div>
                                    </div>
                                    <div class="text-sm font-normal text-gray-500 lex dark:text-gray-300">
                                        Publicado por 
                                          <a href="#" class="font-semibold text-purple-600 dark:text-purple-800 hover:underline"><%=obj.Nombre %></a>
                                        - Guardia
                                    </div>
                                    <div class=" p-3 text-sm italic font-normal text-gray-500 bg-gray-50 rounded-lg border border-gray-200 dark:bg-gray-800 dark:border-gray-600 dark:text-gray-300">
                                        <p>
                                            <%=obj.Mensaje %>
                                            <br />
                                        </p>
                                    </div>
                                    <p class="text-gray-500 dark:text-gray-300">
                                        <a class="inline-flex items-center w-full px-2 py-1 text-sm  transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200" href="publicacionForo.aspx?id=<%= obj.id%>">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 8.25h9m-9 3H12m-9.75 1.51c0 1.6 1.123 2.994 2.707 3.227 1.129.166 2.27.293 3.423.379.35.026.67.21.865.501L12 21l2.755-4.133a1.14 1.14 0 01.865-.501 48.172 48.172 0 003.423-.379c1.584-.233 2.707-1.626 2.707-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0012 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018z"></path>
                                            </svg>
                                            &nbsp;&nbsp;                   
                                              <span><%=respuestas %> Comentarios</span>
                                        </a>
                                    </p>
                                </div>
                            </li>
                            <%      }
                            else
                            {%>
                            <li class="mb-10 ml-6">
                                <span class="flex absolute -left-3 justify-center items-center w-6 h-6 bg-purple-500 rounded-full dark:bg-purple-500"></span>
                                <div class="p-4 bg-white rounded-lg border border-gray-200 shadow-sm dark:bg-gray-700 dark:border-gray-600">
                                    <div class="justify-between items-center mb-3 sm:flex">
                                        <time class="mb-1 text-xs font-normal text-gray-400 sm:order-last sm:mb-0"><%=fecha %> | <%=hora %></time>
                                        <div class="font-bold font-normal text-gray-700 lex dark:text-gray-100">
                                            <h1><%=obj.Categoria %></h1>
                                        </div>
                                    </div>
                                    <div class="text-sm font-normal text-gray-500 lex dark:text-gray-300">
                                        Publicado por 
                                          <a href="#" class="font-semibold text-purple-600 dark:text-purple-800 hover:underline"><%=obj.Nombre %></a>
                                        - Administrador
                                    </div>
                                    <div class=" p-3 text-sm italic font-normal text-gray-500 bg-gray-50 rounded-lg border border-gray-200 dark:bg-gray-800 dark:border-gray-600 dark:text-gray-300">
                                        <p>
                                            <%=obj.Mensaje %>
                                            <br />
                                        </p>
                                    </div>
                                    <p class="text-gray-500 dark:text-gray-300">
                                        <a class="inline-flex items-center w-full px-2 py-1 text-sm  transition-colors duration-150 rounded-md hover:bg-gray-100 hover:text-gray-800 dark:hover:bg-gray-800 dark:hover:text-gray-200" href="publicacionForo.aspx?id=<%= obj.id%>">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 8.25h9m-9 3H12m-9.75 1.51c0 1.6 1.123 2.994 2.707 3.227 1.129.166 2.27.293 3.423.379.35.026.67.21.865.501L12 21l2.755-4.133a1.14 1.14 0 01.865-.501 48.172 48.172 0 003.423-.379c1.584-.233 2.707-1.626 2.707-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0012 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018z"></path>
                                            </svg>
                                            &nbsp;&nbsp;                   
                                              <span><%=respuestas %> Comentarios</span>
                                        </a>
                                    </p>
                                </div>
                            </li>
                            <%}
                                    }
                                }%>
                        </ol>
                        <div class="fixed inset-x-0 bottom-2.5 right-3 z-50 px-5 py-3 bg-transparent flex flex-col space-y-3" data-modal-toggle="authentication-modal">
                            <!-- Sticky icon -->
                            <a href="#" title="Publicar">
                                <img id="img1" src="../assets/img/add.png" alt="" />
                            </a>
                        </div>
                    </div>
                    <!-- Main modal -->
                    <div id="authentication-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full md:inset-0 h-modal md:h-full justify-center items-center">
                        <div class="relative p-4 w-full max-w-md h-full md:h-auto">
                            <!-- Modal content -->
                            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                                <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white" data-modal-toggle="authentication-modal">
                                    <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                                    <span class="sr-only">Close modal</span>
                                </button>
                                <div class="py-6 px-6 lg:px-8">
                                    <h3 class="mb-4 text-xl font-medium text-gray-900 dark:text-white">Publica en el foro</h3>
                                    <div>
                                        <label for="DropDownListModal" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Categoría</label>
                                        <asp:DropDownList class="mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-multiselect focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListModal" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <br />
                                    <div class="mb-4 w-full bg-gray-50 rounded-lg border border-gray-200 dark:bg-gray-700 dark:border-gray-600">
                                        <div class="py-2 px-4 bg-white rounded-t-lg dark:bg-gray-800">
                                            <label for="comment" class="sr-only">Your comment</label>
                                            <textarea runat="server" id="TextBoxMensaje" rows="4" class="px-0 w-full text-sm text-gray-900 bg-white border-0 dark:bg-gray-800 focus:ring-0 dark:text-white dark:placeholder-gray-400" placeholder="Escribe un comentario..." required></textarea>
                                        </div>
                                        <div class="flex justify-between items-center py-2 px-3 border-t dark:border-gray-600">
                                            <asp:Button ID="ButtonPublicar" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonPublicar_Click" Text="Publicar" />
                                            <div class="flex pl-0 space-x-1 sm:pl-2">
                                                <button type="button" class="inline-flex justify-center p-2 text-gray-500 rounded cursor-pointer hover:text-gray-900 hover:bg-gray-100 dark:text-gray-400 dark:hover:text-white dark:hover:bg-gray-600">
                                                    <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                        <path fill-rule="evenodd" d="M4 3a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V5a2 2 0 00-2-2H4zm12 12H4l4-8 3 6 2-4 3 6z" clip-rule="evenodd"></path></svg>
                                                    <span class="sr-only">Upload image</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
    </div>
      <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
      <!-- End of modal backdrop -->
  </body>
</html>