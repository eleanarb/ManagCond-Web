<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarEspacioComun.aspx.cs" Inherits="ManagCond.Administrador.EditarEspacioComun" %>

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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Editar espacio comun</h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                        <form runat="server">
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                        <asp:TextBox ID="TextBoxNombre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeNombre" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
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
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div>
                                    <label for="DropDownListHoraIncio" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Hora inicio</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListHoraIncio" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione hora inicio:</asp:ListItem>
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
                                    </asp:DropDownList>
                                    <span id="mensajeHoraFin" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                             <span id="mensajeRangoHorario" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                            <div class="grid gap-6 mb-8 md:grid-cols-4">
                                <div class="col-end-7 col-span-2">
                                    <asp:Button ID="ButtonAgregar"  OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonModificar_Click"  Text="Modificar" />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
    <script>
        var letras = /[a-zA-Z ]+$/;
        var numeros = /^[0-9]+$/;

        $('#TextBoxNombre').on('keyup', function () {
            if (!letras.test($('#TextBoxNombre').val())) {
                $('#mensajeNombre').html('Ingrese nombre de manera correcta').css('color', 'red');

            } else
                $('#mensajeNombre').html('').css('color', 'green');
        });
        $('#TextBoxDesc').on('keyup', function () {
            if (!letras.test($('#TextBoxDesc').val())) {
                $('#mensajeDesc').html('Ingrese descripcion de manera correcta').css('color', 'red');

            } else
                $('#mensajeDesc').html('').css('color', 'green');
        });
        $('#TextBoxMonto').on('keyup', function () {
            if (!numeros.test($('#TextBoxMonto').val())) {
                $('#mensajeMonto').html('Ingrese monto de manera correcta').css('color', 'red');

            } else
                $('#mensajeMonto').html('').css('color', 'green');
        });
    </script>
    <script>
        function validarFormulario(evento) {
            if (!letras.test($('#TextBoxNombre').val())) {
                $('#mensajeNombre').html('Ingrese nombre de manera correcta').css('color', 'red');
                return false;
            } else {
            }
            if (!letras.test($('#TextBoxDesc').val())) {
                $('#mensajeDesc').html('Ingrese descripcion de manera correcta').css('color', 'red');
                return false;
            } else {
            }
            if (!numeros.test($('#TextBoxMonto').val())) {
                $('#mensajeMonto').html('Ingrese monto de manera correcta').css('color', 'red');
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
</body>
</html>