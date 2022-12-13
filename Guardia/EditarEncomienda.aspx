﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarEncomienda.aspx.cs" Inherits="ManagCond.Guardia.EditarEncomienda" %>

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
        <!-- #include file ="Template/AsideGuardia.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderGuardia.html" -->
            <main class="h-full pb-16 overflow-y-auto">
                <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Editar Encomienda</h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                        <form id="EditarEncomienda" runat="server">
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Numero departamento</span><br />
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownList" runat="server">
                                    </asp:DropDownList>
                                     <span id="mensajeDepto" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </label>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <label class="block mt-4 text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Destinatario</span>
                                    <asp:TextBox ID="TextBoxDestinatario" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    <span id="mensajeDestinatario" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </label>
                                <label class="block mt-4 text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Descripcion</span>
                                    <asp:TextBox ID="TextBoxDescripcion" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Subir imagen</span><br/>
                                    <input id="FileUploadEncomienda" accept="image/*" type="file" runat="server" name="oFile">
                                </label>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Estado</span><br/>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListEstado" runat="server">
                                    </asp:DropDownList>
                                </label>
                            </div>
                            <br />
                            <br />
                            <asp:Button ID="ButtonAceptar" OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAceptar_Click" Text="Aceptar" />
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script>
        var letras = /[a-záéíóúñA-ZÁÉÍÓÚÑ ]+$/;

        $('#TextBoxDestinatario').on('keyup', function () {
            if (!letras.test($('#TextBoxDestinatario').val())) {
                $('#mensajeDestinatario').html('Ingrese destinatario de manera correcta').css('color', 'red');

            } else
                $('#mensajeDestinatario').html('').css('color', 'green');
        });
    </script>
    <script>
        function validarFormulario(evento) {
            var depto = document.getElementById('DropDownList');
            if (depto.value < 1) {
                $('#mensajeDepto').html('Ingrese departamento').css('color', 'red');
                return false;
            } else {
                $('#mensajeDepto').html('').css('color', 'green');
            }
            if (!letras.test($('#TextBoxDestinatario').val())) {
                $('#mensajeDestinatario').html('Ingrese destinatario de manera correcta').css('color', 'red');
                return false;
            } else {
                return true;
            }
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
</body>
</html>
