<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarProveedor.aspx.cs" Inherits="ManagCond.Administrador.AgregarProveedor" %>

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" defer></script>
    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />
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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Proveedor</h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                        <form runat="server">
                            <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Datos</h2>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div class="grid gap-6 mb-8 md:grid-cols-2">
                                    <div>
                                        <label class="block text-sm">
                                            <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                            <input type="text" runat="server" id="TextBoxNombre"
                                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                required />
                                        </label>
                                        <span id="mensajeNombre" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                    </div>
                                    <div>
                                        <label class="block text-sm">
                                            <span class="text-gray-700 dark:text-gray-400">Teléfono</span>
                                            <input type="text" runat="server" id="TextBoxTelefono"
                                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                                required />
                                        </label>
                                        <span id="mensajeTelefono" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Correo</span>
                                        <input type="text" runat="server" id="TextBoxCorreo"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                            required />
                                    </label>
                                    <span id="mensajeEmail" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div class="grid gap-6 mb-8 md:grid-cols-2">
                                    <div>
                                        <label for="DropDownListRegion" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Región</label>
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListRegion" OnSelectedIndexChanged="Region_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        </asp:DropDownList>
                                        <span id="mensajeRegion" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                    </div>
                                    <div>
                                        <label for="DropDownListComuna" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Comuna</label>
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListComuna" OnSelectedIndexChanged="Comuna_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Seleccione Comuna:</asp:ListItem>
                                        </asp:DropDownList>
                                        <span id="mensajeComuna" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Direccion</span>
                                        <input type="text" runat="server" id="TextBoxDireccion"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                            required />
                                    </label>
                                    <span id="mensajeDireccion" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Medio de Pago</h2>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div>
                                    <label class=" text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                        <input type="text" runat="server" id="TextBoxNombrePago"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                            required />
                                    </label>
                                   <span id="mensajeNombrePago" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class=" text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                        <input type="text" runat="server" id="TextBoxRut"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                            required />
                                    </label>
                                </div>
                                <div>
                                    <label for="DropDownListBanco" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Banco</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListBanco" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione Banco:</asp:ListItem>
                                        <asp:ListItem Value="Banco Chile/Edwards">Banco Chile/Edwards</asp:ListItem>
                                        <asp:ListItem Value="Banco Estado">Banco Estado</asp:ListItem>
                                        <asp:ListItem Value="Banco ScotiaBank">Banco ScotiaBank</asp:ListItem>
                                        <asp:ListItem Value="Banco BCI">Banco BCI</asp:ListItem>
                                        <asp:ListItem Value="Corpbanca">Corpbanca</asp:ListItem>
                                        <asp:ListItem Value="Banco do Brasil S.A">Banco do Brasil S.A</asp:ListItem>
                                        <asp:ListItem Value="Banco Bice">Banco Bice</asp:ListItem>
                                        <asp:ListItem Value="Banco HSBC Bank">Banco HSBC Bank</asp:ListItem>
                                        <asp:ListItem Value="Banco Santander">Banco Santander</asp:ListItem>
                                        <asp:ListItem Value="Banco Itau">Banco Itau</asp:ListItem>
                                        <asp:ListItem Value="Banco Security">Banco Security</asp:ListItem>
                                        <asp:ListItem Value="Banco Falabella">Banco Falabella</asp:ListItem>
                                        <asp:ListItem Value="Banco Ripley">Banco Ripley</asp:ListItem>
                                        <asp:ListItem Value="RaboBank">RaboBank</asp:ListItem>
                                        <asp:ListItem Value="Banco Consorcio">Banco Consorcio</asp:ListItem>
                                        <asp:ListItem Value="Banco Paris">Banco Paris</asp:ListItem>
                                        <asp:ListItem Value="BBVA">BBVA</asp:ListItem>
                                        <asp:ListItem Value="Banco del Desarrollo">Banco del Desarrollo</asp:ListItem>
                                        <asp:ListItem Value="Coopeuch">Coopeuch</asp:ListItem>
                                        <asp:ListItem Value="Prepago Los Heroes">Prepago Los Heroes</asp:ListItem>
                                        <asp:ListItem Value="Tenpo Prepago">Tenpo Prepago</asp:ListItem>
                                        <asp:ListItem Value="Mercado Pago">Mercado Pago</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="mensajeBanco" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label for="DropDownListCuenta" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Tipo de Cuenta</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListCuenta" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione Tipo de Cuenta:</asp:ListItem>
                                        <asp:ListItem Value="Cuenta Corriente">Cuenta Corriente</asp:ListItem>
                                        <asp:ListItem Value="Cuenta Vista">Cuenta Vista</asp:ListItem>
                                        <asp:ListItem Value="Cuenta de Ahorro">Cuenta de Ahorro</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="mensajeCuenta" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label class=" text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Número de Cuenta</span>
                                        <input type="number" min="0" runat="server" id="TextBoxNumero"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                            required />
                                    </label>
                                   <span id="mensajeNumero" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                                <div>
                                    <label for="DropDownListPago" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Tipo de Pago</label>
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListPago" runat="server">
                                        <asp:ListItem Selected="True" Value="0">Seleccione Tipo de Pago:</asp:ListItem>
                                        <asp:ListItem Value="Depósito">Depósito</asp:ListItem>
                                        <asp:ListItem Value="Transferencia">Transferencia</asp:ListItem>
                                    </asp:DropDownList>
                                    <span id="mensajePago" class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>
                            <div class="grid gap-6 mb-8 md:grid-cols-4">
                                <div class="col-end-7 col-span-2">
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
        var letras = /^[a-zA-Z]+$/;
        var email = /^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
        var numeros = /^[0-9]+$/;

        $('#TextBoxNombre').on('keyup', function () {
            if (!letras.test($('#TextBoxNombre').val())) {
                $('#mensajeNombre').html('Ingrese nombre valido').css('color', 'red');

            } else
                $('#mensajeNombre').html('').css('color', 'green');
        });
        $('#TextBoxTelefono').on('keyup', function () {
            if ($('#TextBoxTelefono').val().length < 9) {
                $('#mensajeTelefono').html('Ingrese telefono valido').css('color', 'red');

            } else
                $('#mensajeTelefono').html('').css('color', 'green');
        });
        $('#TextBoxCorreo').on('keyup', function () {
            if (!email.test($('#TextBoxCorreo').val())) {
                $('#mensajeEmail').html('Ingrese un correo válido').css('color', 'red');

            } else
                $('#mensajeEmail').html('').css('color', 'green');
        });
        $('#TextBoxDireccion').on('keyup', function () {
            if (!letras.test($('#TextBoxDireccion').val())) {
                $('#mensajeDireccion').html('Ingrese un direccion válido').css('color', 'red');

            } else
                $('#mensajeDireccion').html('').css('color', 'green');
        });
        $('#TextBoxNombrePago').on('keyup', function () {
            if (!letras.test($('#TextBoxNombrePago').val())) {
                $('#mensajeNombrePago').html('Ingrese un nombre válido').css('color', 'red');

            } else
                $('#mensajeNombrePago').html('').css('color', 'green');
        });
        $('#TextBoxNumero').on('keyup', function () {
            if (!numeros.test($('#TextBoxNumero').val())) {
                $('#mensajeNumero').html('Ingrese un numero de cuenta válido').css('color', 'red');

            } else
                $('#mensajeNumero').html('').css('color', 'green');
        });

        function validarFormulario(evento) {
            if (!letras.test($('#TextBoxNombre').val())) {
                $('#mensajeNombre').html('Ingrese nombre valido').css('color', 'red');
                return false;
            } else {
            }
            var telefono = document.getElementById('TextBoxTelefono').value;
            if (telefono.length < 9) {
                $('#mensajeTelefono').html('Ingrese telefono valido').css('color', 'red');
                return false;
            } else {
            }
            var correo = document.getElementById('TextBoxCorreo').value;
            if (!email.test(correo)) {
                $('#mensajeEmail').html('Ingrese un correo válido').css('color', 'red');
                return false;
            } else {
            }
            var region = document.getElementById('DropDownListRegion');
            if (region.value < 1) {
                $('#mensajeRegion').html('Ingrese region').css('color', 'red');
                return false;
            } else {
                $('#mensajeRegion').html('').css('color', 'green');
            }
            var comuna = document.getElementById('DropDownListComuna');
            if (comuna.value < 1) {
                $('#mensajeComuna').html('Ingrese comuna').css('color', 'red');
                return false;
            } else {
                $('#mensajeComuna').html('').css('color', 'green');
            }
            var direccion = document.getElementById('TextBoxDireccion').value;
            if (!letras.test(direccion)) {
                $('#mensajeDireccion').html('Ingrese un correo válido').css('color', 'red');
                return false;
            } else {
            }
            var nombrePago = document.getElementById('TextBoxNombrePago').value;
            if (!letras.test(nombrePago)) {
                $('#mensajeNombrePago').html('Ingrese nombre válido').css('color', 'red');
                return false;
            } else {
            }
            var banco = document.getElementById('DropDownListBanco');
            if (banco.value < 1) {
                $('#mensajeBanco').html('Ingrese banco').css('color', 'red');
                return false;
            } else {
                $('#mensajeBanco').html('').css('color', 'green');
            }
            var cuenta = document.getElementById('DropDownListCuenta');
            if (cuenta.value < 1) {
                $('#mensajeCuenta').html('Ingrese cuenta').css('color', 'red');
                return false;
            } else {
                $('#mensajeCuenta').html('').css('color', 'green');
            }
            var numero = document.getElementById('TextBoxNumero').value;
            if (!numeros.test(numero)) {
                $('#mensajeNumero').html('Ingrese un un numero de cuenta válido').css('color', 'red');
                return false;
            } else {
            }
            var pago = document.getElementById('DropDownListPago');
            if (pago.value < 1) {
                $('#mensajePago').html('Ingrese cuenta').css('color', 'red');
                return false;
            } else {
                $('#mensajePago').html('').css('color', 'green');
                return true;
            }
        }
    </script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
    <script src="https://unpkg.com/flowbite@1.5.3/dist/flowbite.js"></script>
</body>
</html>
