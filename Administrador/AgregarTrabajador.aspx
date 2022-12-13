﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarTrabajador.aspx.cs" Inherits="ManagCond.Administrador.AgregarTrabajador" %>

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
                <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Trabajador</h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                        <form runat="server">
                            <div class="grid gap-6 mb-8 md:grid-cols-3">
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                        <asp:TextBox ID="TextBoxRut" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" runat="server"></asp:TextBox>
                                    </label>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nombres</span>
                                        <asp:TextBox ID="TextBoxNombres" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeNombres" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Apellidos</span>
                                        <asp:TextBox ID="TextBoxApellidos" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeApellidos" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-4">
                                <div>
                                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Fecha Nacimiento</label>
                                    <div class="relative">
                                    <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                        <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                                    </div>
                                    <input datepicker datepicker-autohide datepicker-format="dd-mm-yyyy" id="inputFecha" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Seleccione fecha" runat="server" />
                                </div>
                                    <span id="mensajeFecha" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Correo</span>
                                        <asp:TextBox ID="TextBoxCorreo" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeCorreo" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Telefono</span>
                                        <asp:TextBox ID="TextBoxTelefono" type="number" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" requiered="true"></asp:TextBox>
                                    </label>
                                    <span id="mensajeTelefono" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                <span class="text-gray-700 dark:text-gray-200">Cargo</span><br />
                                <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListCargo" runat="server">
                                </asp:DropDownList>
                                <span id="mensajeCargo" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                            </label>
                                </div>
                            </div>
                            
                            <br>
                            <div class="col-end-7 col-span-2">
                                <asp:Button ID="ButtonAgregar" OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script>
        var letras = /^[a-zA-Z]+$/;
        var email = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
        var numeros = /^[0-9]+$/;

        $('#TextBoxNombres').on('keyup', function () {
            if (!letras.test($('#TextBoxNombres').val())) {
                $('#mensajeNombres').html('Ingrese nombres validos').css('color', 'red');
            } else
                $('#mensajeNombres').html('').css('color', 'green');
        });
        $('#TextBoxApellidos').on('keyup', function () {
            if (!letras.test($('#TextBoxApellidos').val())) {
                $('#mensajeApellidos').html('Ingrese apellidos validos').css('color', 'red');
            } else
                $('#mensajeApellidos').html('').css('color', 'green');
        });
        $('#TextBoxCorreo').on('keyup', function () {
            if (!email.test($('#TextBoxCorreo').val())) {
                $('#mensajeCorreo').html('Ingrese correo valido').css('color', 'red');
            } else
                $('#mensajeCorreo').html('').css('color', 'green');
        });
        $('#TextBoxTelefono').on('keyup', function () {
            if (!numeros.test($('#TextBoxTelefono').val())) {
                $('#mensajeTelefono').html('Ingrese telefono valido').css('color', 'red');
            } else
                $('#mensajeTelefono').html('').css('color', 'green');
        });
    </script>
    <script>
        function validarFormulario(evento) {
            if (!letras.test($('#TextBoxNombres').val())) {
                $('#mensajeNombres').html('Ingrese nombres validos').css('color', 'red');
                return false;
            } else {
            }
            if (!letras.test($('#TextBoxApellidos').val())) {
                $('#mensajeApellidos').html('Ingrese apellidos validos').css('color', 'red');
                return false;
            } else {
            }
            var fecha = document.getElementById('inputFecha').value;
            if (fecha.length < 1) {
                $('#mensajeFecha').html('Ingrese fecha').css('color', 'red');
                return false;
            } else {
                $('#mensajeFecha').html('').css('color', 'green');
            }
            if (!email.test($('#TextBoxCorreo').val())) {
                $('#mensajeCorreo').html('Ingrese correo valido').css('color', 'red');
                return false;
            } else {
            }
            if (!numeros.test($('#TextBoxTelefono').val())) {
                $('#mensajeTelefono').html('Ingrese telefono valido').css('color', 'red');
                return false;
            } else {
            }
            var cargo = document.getElementById('DropDownListCargo');
            if (cargo.value < 1) {
                $('#mensajeCargo').html('Ingrese cargo').css('color', 'red');
                return false;
            } else {
                $('#mensajeCargo').html('').css('color', 'green');
                return true;
            }
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
</body>
</html>