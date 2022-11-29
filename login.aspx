﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ManagCond.Login" %>

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

    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>

        <script src=
"https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"> 
    </script> 
</head>
<body>
    <div class="flex items-center min-h-screen p-6 bg-gray-50 dark:bg-gray-900">
        <div
            class="flex-1 h-full max-w-4xl mx-auto overflow-hidden bg-white rounded-lg shadow-xl dark:bg-gray-800">
            <div class="flex flex-col overflow-y-auto md:flex-row">
                <div class="h-32 md:h-auto md:w-1/2">
                    <img
                        aria-hidden="true"
                        class="object-cover w-full h-full dark:hidden"
                        src="../assets/img/login-office.jpeg"
                        alt="Office" />
                    <img
                        aria-hidden="true"
                        class="hidden object-cover w-full h-full dark:block"
                        src="../assets/img/login-office-dark.jpeg"
                        alt="Office" />
                </div>
                <div class="flex items-center justify-center p-6 sm:p-12 md:w-1/2">
                    <form id="login" runat="server">
                        <div class="w-full">
                            <h1
                                class="mb-4 text-xl font-semibold text-gray-700 dark:text-gray-200">Login
                            </h1>
                            <label class="block text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Email</span>
                                <asp:TextBox ID="TextBoxUsuario"  class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                            </label>
                            <span id="messageEmail" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                            <label class="block mt-4 text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Password</span>
                                <asp:TextBox ID="TextBoxClave"  class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server" TextMode="Password"></asp:TextBox>
                            </label>
                             <span id="messageClave" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                            <br />
                            <asp:Button ID="ButtonAceptar" OnClientClick="return validarFormulario()"  class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAceptar_Click" Text="Aceptar" />
                            <hr class="my-8" />
                            <p class="mt-4">
                                <a
                                    class="text-sm font-medium text-purple-600 dark:text-purple-400 hover:underline"
                                    href="RecuperarClave.aspx">Olvidaste tu contraseña?
                                </a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    
     <script>
         var email = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;

         $('#TextBoxUsuario').on('keyup', function () {
             if (!email.test($('#TextBoxUsuario').val())) {
                 $('#messageEmail').html('Ingrese un correo válido').css('color', 'red');

             } else
                 $('#messageEmail').html('').css('color', 'green');
         });

         $('#TextBoxClave').on('keyup', function () {
             if ($('#TextBoxClave').val().length < 6) {
                 $('#messageClave').html('Ingrese una clave válida').css('color', 'red');

             } else
                 $('#messageClave').html('').css('color', 'green');
         });

         

         function validarFormulario(evento) {
             var usuario = document.getElementById('TextBoxUsuario').value;
             if (!email.test(usuario)) {
                 return false;
             } else {
                 return true;
             }

             var clave = document.getElementById('TextBoxClave').value;
             if (clave.length < 6) {
                 return false;
             } else {
                 return true;
             }
         }
     </script>


    
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
</body>
</html>