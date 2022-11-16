<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perfil.aspx.cs" Inherits="ManagCond.Administrador.perfil" %>
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
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tw-elements/dist/css/index.min.css" />
<script src="https://cdn.tailwindcss.com"></script>

    <!-- You need focus-trap.js to make the modal accessible -->
    <script src="../assets/js/focus-trap.js" defer></script>
  </head>
  <body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen}"
    >
              <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
        <main class="h-full pb-16 overflow-y-auto">

         


          <div class="container grid px-6 mx-auto">
              <br />
              <form id="perfil" runat="server">
                  <ul class="nav nav-tabs flex flex-col md:flex-row flex-wrap list-none border-b-0 pl-0 mb-4" id="tabs-tabFill"
                      role="tablist">
                      <li class="nav-item flex-auto text-center" role="presentation">
                          <a href="#tabs-homeFill" class="
                          nav-link
                          w-full
                          block
                          font-medium
                          text-xs
                          leading-tight
                          uppercase
                          border-x-0 border-t-0 border-b-2 border-transparent
                          px-6
                          py-3
                          my-2
                          hover:border-transparent hover:bg-gray-100
                          focus:border-transparent
                          active "
                              id="tabs-home-tabFill" data-bs-toggle="pill" data-bs-target="#tabs-homeFill" role="tab"
                              aria-controls="tabs-homeFill" aria-selected="true">Perfil</a>
                      </li>
                      <li class="nav-item flex-auto text-center" role="presentation">
                          <a href="#tabs-profileFill" class="
                          nav-link
                          w-full
                          block
                          font-medium
                          text-xs
                          leading-tight
                          uppercase
                          border-x-0 border-t-0 border-b-2 border-transparent
                          px-6
                          py-3
                          my-2
                          hover:border-transparent hover:bg-gray-100
                          focus:border-transparent"
                              id="tabs-profile-tabFill" data-bs-toggle="pill" data-bs-target="#tabs-profileFill" role="tab"
                              aria-controls="tabs-profileFill" aria-selected="false">Contraseña</a>
                      </li>
                      <li class="nav-item flex-auto text-center" role="presentation">
                          <a href="#tabs-messagesFill" class="
                          nav-link
                          w-full
                          block
                          font-medium
                          text-xs
                          leading-tight
                          uppercase
                          border-x-0 border-t-0 border-b-2 border-transparent
                          px-6
                          py-3
                          my-2
                          hover:border-transparent hover:bg-gray-100
                          focus:border-transparent"
                              id="tabs-messages-tabFill" data-bs-toggle="pill" data-bs-target="#tabs-messagesFill" role="tab"
                              aria-controls="tabs-messagesFill" aria-selected="false">Preferencias</a>
                      </li>
                  </ul>
                  <div class="tab-content" id="tabs-tabContentFill">
                      <div class="tab-pane fade show active" id="tabs-homeFill" role="tabpanel" aria-labelledby="tabs-home-tabFill">

                          <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">

                              <h4 class="mb-4 font-semibold text-gray-600 dark:text-gray-300">Perfil </h4>

                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                          <asp:TextBox ID="TextBoxNombres" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server" disabled></asp:TextBox>
                                      </label>
                                  </div>

                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Apellido</span>
                                          <asp:TextBox ID="TextBoxApellidos" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server" disabled></asp:TextBox>
                                      </label>
                                  </div>
                              </div>

                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                          <input type="text" runat="server" id="TextBoxRutt"
                                              class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                              required />
                                          </label>
                                  </div>

                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Fecha Nac</span>
                                          <asp:TextBox ID="TextBoxNac" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server" disabled></asp:TextBox>
                                      </label>
                                  </div>
                              </div>

                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Correo</span>
                                          <asp:TextBox ID="TextBoxCorreo" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                                      </label>
                                  </div>

                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Telefono</span>
                                          <input type="text" runat="server" id="TextBoxTlf"
                                              class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                              required />
                                         </label>
                                  </div>
                              </div>

                              <div class="grid gap-6 mb-8 md:grid-cols-4">
                                  
                                  <div class="col-end-7 col-span-2">
                                      <asp:Button ID="ButtonPerfil" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonPerfil_Click" Text="Guardar Cambios" />
                                  </div>
                              </div>


                          </div>
                      </div>
                      <div class="tab-pane fade" id="tabs-profileFill" role="tabpanel" aria-labelledby="tabs-profile-tabFill">
                          <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">

                              <h4 class="mb-4 font-semibold text-gray-600 dark:text-gray-300">Contraseña </h4>

                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Contraseña Actual</span>
                                          <input type="text" runat="server" id="TextBoxClave1"
                                              class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                              required />
                                          </label>
                                  </div>
                              </div>

                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Nueva Contraseña</span>
                                          <input type="text" runat="server" id="TexBoxClave2"
                                              class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                              required />
                                          </label>
                                  </div>

                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Confirma Contraseña</span>
                                          <input type="text" runat="server" id="TextBoxClave3"
                                              class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                              required />
                                      </label>
                                  </div>
                              </div>


                              <div class="grid gap-6 mb-8 md:grid-cols-4">
                                  
                                  <div class="col-end-7 col-span-2">
                                      <asp:Button ID="ButtonClave" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonClave_Click" Text="Guardar Cambios" />
                                  </div>
                              </div>


                          </div>
                      </div>
                      <div class="tab-pane fade" id="tabs-messagesFill" role="tabpanel" aria-labelledby="tabs-profile-tabFill">
                          Tab 3 content fill
                      </div>
                  </div>



              </form>
          </div>
            
        </main>
      </div>
    </div>

      

    <script src="https://cdn.jsdelivr.net/npm/tw-elements/dist/js/index.min.js"></script>
      <script>
          $('#TextBoxTlf').mask('(+56) 0 0000 0000');
          $('#TextBoxRutt').mask({
              mask: '9{1,2}.9{3}.9{3}-(K|k|9)',
              casing: 'upper',
              clearIncomplete: true,
              numericInput: true,
              positionCaretOnClick: 'none'
          });
      </script>


  </body>
</html>
