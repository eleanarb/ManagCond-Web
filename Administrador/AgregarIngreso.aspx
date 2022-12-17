<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarIngreso.aspx.cs" Inherits="ManagCond.Administrador.AgregarIngreso" %>

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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Ingreso </h2>
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
                                        <span class="text-gray-700 dark:text-gray-400">Comentario</span>
                                        <asp:TextBox ID="TextBoxComentario" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeComentario" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
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
                                    <label for="DropDownListAño" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Mes</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListMes" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione Mes:</asp:ListItem>
                                        <asp:ListItem Value="01">Enero</asp:ListItem>
                                        <asp:ListItem Value="02">Febrero</asp:ListItem>
                                        <asp:ListItem Value="03">Marzo</asp:ListItem>
                                        <asp:ListItem Value="04">Abril</asp:ListItem>
                                        <asp:ListItem Value="05">Mayo</asp:ListItem>
                                        <asp:ListItem Value="06">Junio</asp:ListItem>
                                        <asp:ListItem Value="07">Julio</asp:ListItem>
                                        <asp:ListItem Value="08">Agosto</asp:ListItem>
                                        <asp:ListItem Value="09">Septiembre</asp:ListItem>
                                        <asp:ListItem Value="10">Octubre</asp:ListItem>
                                        <asp:ListItem Value="11">Noviembre</asp:ListItem>
                                        <asp:ListItem Value="12">Diciembre</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="mensajeMes" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label for="DropDownListAño" class="block mb-2 text-sm font-medium text-gray-700 dark:text-gray-400">Año</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAño" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione año:</asp:ListItem>
                                        <asp:ListItem Value="2019">2019</asp:ListItem>
                                        <asp:ListItem Value="2020">2020</asp:ListItem>
                                        <asp:ListItem Value="2022">2022</asp:ListItem>
                                        <asp:ListItem Value="2023">2023</asp:ListItem>
                                        <asp:ListItem Value="2024">2024</asp:ListItem>
                                        <asp:ListItem Value="2025">2025</asp:ListItem>
                                        <asp:ListItem Value="2026">2026</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="mensajeAño" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div>
                                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Fecha Ingreso:</label>
                                    <div class="relative">
                                        <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                            <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                                        </div>
                                        <input datepicker datepicker-autohide datepicker-format="dd-mm-yyyy" id="inputFecha" type="noi" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Seleccione fecha" runat="server" />
                                    </div>
                                    <span id="mensajeFecha" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <span class="text-gray-700 dark:text-gray-400">Documento</span>
                                    <label class="block text-sm">
                                        <input id="FileUploadDocumento" accept="image/*,.pdf,.xlsx,.docx" type="file" runat="server" name="oFile">
                                    </label>
                                </div>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-4">
                                <div class="col-end-7 col-span-2">
                                    <asp:Button ID="ButtonAgregar"  OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
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

        const datePicker = document.getElementById('inputFecha');

        const today = new Date();
        const minDate = today.toISOString().split('T')[0];

        datePicker.attr('min', minDate);



        var letras = /[a-zA-Z ]+$/;
        var numeros = /^[0-9]+$/;

        $('#TextBoxNombre').on('keyup', function () {
            if (!letras.test($('#TextBoxNombre').val())) {
                $('#mensajeNombre').html('Ingrese nombre valido').css('color', 'red');

            } else
                $('#mensajeNombre').html('').css('color', 'green');
        });
        $('#TextBoxComentario').on('keyup', function () {
            if (!letras.test($('#TextBoxComentario').val())) {
                $('#mensajeComentario').html('Ingrese comentario valido').css('color', 'red');

            } else
                $('#mensajeComentario').html('').css('color', 'green');
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
                $('#mensajeNombre').html('Ingrese nombre').css('color', 'red');
                return false;
            } else {
            }
            if (!letras.test($('#TextBoxComentario').val())) {
                $('#mensajeComentario').html('Ingrese comentario').css('color', 'red');
                return false;
            } else {
            }
            if (!numeros.test($('#TextBoxMonto').val())) {
                $('#mensajeMonto').html('Ingrese monto').css('color', 'red');
                return false;
            } else {
            }
            var mes = document.getElementById('DropDownListMes');
            if (mes.value < 1) {
                $('#mensajeMes').html('Ingrese mes').css('color', 'red');
                return false;
            } else {
                $('#mensajeMes').html('').css('color', 'green');
            }
            var año = document.getElementById('DropDownListAño');
            if (año.value < 1) {
                $('#mensajeAño').html('Ingrese año').css('color', 'red');
                return false;
            } else {
                $('#mensajeAño').html('').css('color', 'green');
            }
            var fecha = document.getElementById('inputFecha').value;
            if (fecha.length < 1) {
                $('#mensajeFecha').html('Ingrese fecha').css('color', 'red');
                return false;
            } else {
                $('#mensajeFecha').html('').css('color', 'green');
                return true;
            }
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
</body>
</html>
