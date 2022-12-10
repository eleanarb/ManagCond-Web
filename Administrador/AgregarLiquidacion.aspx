<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarLiquidacion.aspx.cs" Inherits="ManagCond.Administrador.AgregarLiquidacion" %>
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
    <script src="../assets/js/focus-trap.js" defer></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css"/>
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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Liquidación</h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                        <form runat="server">

                            <div class="grid gap-6 mb-8 md:grid-cols-3">
                                <div class="col-span-2">
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-200">Rut Trabajador</span><br />
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListTrabajador" runat="server">
                                        </asp:DropDownList>
                                    </label>
                                </div>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-4">
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Horas Extras</span>
                                        <asp:TextBox ID="TextBoxHorasExtras" type="number" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeHorasExtras" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Bonos</span>
                                        <asp:TextBox ID="TextBoxBonos" type="number" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeBonos" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Dias No Trabajados</span>
                                        <asp:TextBox ID="TextBoxDiasNoTrabajados" type="number" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeDiasNoTrabajados" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Otros Descuentos</span>
                                        <asp:TextBox ID="TextBoxOtrosDescuentos" type="number" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                    </label>
                                    <span id="mensajeOtrosDescuentos" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <br />
                            <div class="grid gap-6 mb-8 md:grid-cols-3">
                                <div class="col-end-3">
                                    <asp:Button ID="ButtonAgregar" OnClientClick="return validarFormulario()" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script>
        var numeros = /^[0-9]+$/;

        $('#TextBoxHorasExtras').on('keyup', function () {
            if (!numeros.test($('#TextBoxHorasExtras').val())) {
                $('#mensajeHorasExtras').html('Ingrese horas extras validas').css('color', 'red');
            } else
                $('#mensajeHorasExtras').html('').css('color', 'green');
        });
        $('#TextBoxBonos').on('keyup', function () {
            if (!numeros.test($('#TextBoxBonos').val())) {
                $('#mensajeBonos').html('Ingrese bono valido').css('color', 'red');
            } else
                $('#mensajeBonos').html('').css('color', 'green');
        });
        $('#TextBoxDiasNoTrabajados').on('keyup', function () {
            if (!numeros.test($('#TextBoxDiasNoTrabajados').val())) {
                $('#mensajeDiasNoTrabajados').html('Ingrese dias no trabajados validos').css('color', 'red');
            } else
                $('#mensajeDiasNoTrabajados').html('').css('color', 'green');
        });
        $('#TextBoxOtrosDescuentos').on('keyup', function () {
            if (!numeros.test($('#TextBoxOtrosDescuentos').val())) {
                $('#mensajeOtrosDescuentos').html('Ingrese otros descuentos validos').css('color', 'red');
            } else
                $('#mensajeOtrosDescuentos').html('').css('color', 'green');
        });
    </script>
    <script>
        function validarFormulario(evento) {
            if (!numeros.test($('#TextBoxHorasExtras').val())) {
                $('#mensajeHorasExtras').html('Ingrese horas extras validas').css('color', 'red');
                return false;
            } else {
            }
            if (!numeros.test($('#TextBoxBonos').val())) {
                $('#mensajeBonos').html('Ingrese bono valido').css('color', 'red');
                return false;
            } else {
            }
            if (!numeros.test($('#TextBoxDiasNoTrabajados').val())) {
                $('#mensajeDiasNoTrabajados').html('Ingrese dias no trabajados validos').css('color', 'red');
                return false;
            } else {
            }
            if (!numeros.test($('#TextBoxOtrosDescuentos').val())) {
                $('#mensajeOtrosDescuentos').html('Ingrese otros descuentos validos').css('color', 'red');
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
