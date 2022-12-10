<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="ManagCond.Residente.Perfil" %>
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
    <script src="../assets/js/jquery.rut.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tw-elements/dist/css/index.min.css" />
    <!-- You need focus-trap.js to make the modal accessible -->
    <script src="../assets/js/focus-trap.js" defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js"></script>
</head>
<body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen}">
        <!-- #include file ="Template/AsideResidente.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderResidente.html" -->
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
                                                <asp:TextBox ID="TextBoxNombres" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" disabled></asp:TextBox>
                                            </label>
                                        </div>
                                        <div>
                                            <label class="block text-sm">
                                                <span class="text-gray-700 dark:text-gray-400">Apellido</span>
                                                <asp:TextBox ID="TextBoxApellidos" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" disabled></asp:TextBox>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="grid gap-6 mb-8 md:grid-cols-2">
                                        <div>
                                            <label class="block text-sm">
                                                <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                                <input type="text" runat="server" id="TextBoxRut" disabled
                                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500tt" />
                                            </label>
                                        </div>
                                        <div>
                                            <label class="block text-sm">
                                                <span class="text-gray-700 dark:text-gray-400">Fecha Nac</span>
                                                <asp:TextBox ID="TextBoxNac" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500tt" runat="server" disabled></asp:TextBox>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="grid gap-6 mb-8 md:grid-cols-2">
                                        <div>
                                            <label class="block text-sm">
                                                <span class="text-gray-700 dark:text-gray-400">Correo</span>
                                                <asp:TextBox ID="TextBoxCorreo" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                            </label>
                                            <span id="messageEmail" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                        </div>
                                        <div>
                                            <label class="block text-sm">
                                                <span class="text-gray-700 dark:text-gray-400">Telefono</span>
                                                <input type="text" runat="server" id="TextBoxTlf"
                                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" />
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
                                                <input type="password" runat="server" id="TextBoxClave1"
                                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" />
                                            </label>
                                        </div>
                                    </div>
                                    <div class="grid gap-6 mb-8 md:grid-cols-2">
                                        <div>
                                            <label class="block text-sm">
                                                <span class="text-gray-700 dark:text-gray-400">Nueva Contraseña</span>
                                                <input type="password" runat="server" id="TextBoxClave2"
                                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" />
                                            </label>
                                        </div>
                                        <div>
                                            <label class="block text-sm">
                                                <span class="text-gray-700 dark:text-gray-400">Confirma Contraseña</span>
                                                <input type="password" runat="server" id="TextBoxClave3" onchange="checkPasswordMatch();"
                                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" />
                                            </label>
                                            <span id='message' class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
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
                        <%--mensaje error--%>
                        <div>
                            <div runat="server" visible="false" id="mensajeError" class="flex p-4 mb-4 text-sm text-red-700 bg-red-100 rounded-lg dark:bg-red-200 dark:text-red-800" role="alert">
                                <svg aria-hidden="true" class="flex-shrink-0 inline w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>
                                <span class="sr-only">Info</span>
                                <div>
                                    <span class="font-medium">Error al guardar los cambios </span>
                                </div>
                            </div>
                        </div>
                        <%--mensaje error Correo--%>
                        <div>
                            <div runat="server" visible="false" id="mensajeErrorCorreo" class="flex p-4 mb-4 text-sm text-red-700 bg-red-100 rounded-lg dark:bg-red-200 dark:text-red-800" role="alert">
                                <svg aria-hidden="true" class="flex-shrink-0 inline w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>
                                <span class="sr-only">Info</span>
                                <div>
                                    <span class="font-medium">El correo ingresado ya existe </span>
                                </div>
                            </div>
                        </div>
                        <%--mensaje exitoso--%>
                        <div runat="server" visible="false" id="mensajeExitoso" class="flex p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg dark:bg-green-200 dark:text-green-800" role="alert">
                            <svg aria-hidden="true" class="flex-shrink-0 inline w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>
                            <span class="sr-only">Info</span>
                            <div>
                                <span class="font-medium">Los cambios se han guardado exitosamente</span>
                            </div>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/tw-elements/dist/js/index.min.js"></script>
    <script>
        $('#TextBoxTlf').mask('(+56) 9 0000 0000');
        $(function () {
            $("#TextBoxRut").rut().on('rutValido', function (e, rut, dv) {
                alert("El rut " + rut + "-" + dv + " es correcto");
            }, { minimumLength: 7 });
        })

        $(function () {
            $("#TextBoxRut").rut();
        });
    </script>
    <script>
        var email = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;

        $('#TextBoxClave2, #TextBoxClave3').on('keyup', function () {
            if ($('#TextBoxClave2').val() == $('#TextBoxClave3').val()) {
                $('#message').html('Coinciden').css('color', 'green');
            } else
                $('#message').html('No coinciden').css('color', 'red');
        });
        $('#TextBoxCorreo').on('keyup', function () {
            if (!email.test($('#TextBoxCorreo').val())) {
                $('#messageEmail').html('Ingrese un correo válido').css('color', 'red');

            } else
                $('#messageEmail').html('').css('color', 'green');
        });
    </script>
</body>
</html>
