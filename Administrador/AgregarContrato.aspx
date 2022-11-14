<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarContrato.aspx.cs" Inherits="ManagCond.Administrador.AgregarContrato" %>
<%@ Import Namespace="Model" %>
<%@ Import Namespace="Dao" %>

<!DOCTYPE html>

<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ManagCond</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet" />
    <link rel="stylesheet" href="../assets/css/tailwind.output.css" />
    <script
        src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
        defer></script>
    <script src="../assets/js/init-alpine.js"></script>
    <script src="../assets/js/focus-trap.js" defer></script>
    <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
        defer></script>

    <script src="../assets/js/charts-lines.js" defer></script>
    <script src="../assets/js/charts-pie.js" defer></script>

    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Contrato</h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                    <form runat="server">
                        <h6 class="text-lg font-bold dark:text-white">Dato del Contrato</h6><br />
                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Rut Trabajador</span><br />
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListRutTrabajador" runat="server">
                                    </asp:DropDownList>
                                </label>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Tipo Contrato</span><br />
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListTipoContrato" runat="server">
                                    </asp:DropDownList>
                                </label>
                            </div>
                            <div>
                                <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Fecha Ingreso</label>
                                <div class="relative">
                                    <div class="flex absolute inset-y-0 left-0 items-center pl-3 pointer-events-none">
                                        <svg aria-hidden="true" class="w-5 h-5 text-gray-500 dark:text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                            <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"></path></svg>
                                    </div>
                                    <input datepicker datepicker-autohide datepicker-format="dd-mm-yyyy" id="inputFecha" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 p-2.5  dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Seleccione fecha" runat="server" />
                                </div>
                            </div>
                            

                        </div>
                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Región</span><br />
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListRegion" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListRegion_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </label>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-200">Comuna</span><br />
                                    <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListComuna" runat="server">
                                    </asp:DropDownList>
                                </label>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Dirección</span>
                                    <asp:TextBox ID="TextBoxDirección" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                        </div>
                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Sueldo Base</span>
                                    <asp:TextBox ID="TextBoxSueldoBase" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Horas Semanales</span>
                                    <asp:TextBox ID="TextBoxHorasSemanales" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Dias Semanales</span>
                                    <asp:TextBox ID="TextBoxDiasSemanales" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                        </div>
                        <div class="grid gap-6 mb-8 md:grid-cols-2">
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Asignacion Movilizacion</span>
                                    <asp:TextBox ID="TextBoxAsignacionMovilizacion" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Asignacion Colacion</span>
                                    <asp:TextBox ID="TextBoxAsignacionColacion" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                        </div>
                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                            
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Valor Hora Adicional</span>
                                    <asp:TextBox ID="TextBoxValorHoraAdicional" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                            <div>
                                <label for="DropDownListAFP" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">AFP</label>
                                          <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAFP" runat="server">
                                              <asp:ListItem Selected="True" Value="0">Seleccione AFP:</asp:ListItem>
                                              <asp:ListItem Value="No tiene">No tiene</asp:ListItem>
                                              <asp:ListItem Value="Cuprum">Cuprum</asp:ListItem>
                                              <asp:ListItem Value="Habitat">Habitat</asp:ListItem>
                                              <asp:ListItem Value="ProVida">ProVida</asp:ListItem>
                                              <asp:ListItem Value="Colmena">PlanVital</asp:ListItem>
                                              <asp:ListItem Value="Modelo">Modelo</asp:ListItem>
                                              <asp:ListItem Value="Modelo">Capital</asp:ListItem>
                                              <asp:ListItem Value="Uno">Uno</asp:ListItem>
                                          </asp:DropDownList>
                            </div>
                            <div>
                                <label for="DropDownListSalud" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Plan de salud</label>
                                          <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListSalud" runat="server">
                                              <asp:ListItem Selected="True" Value="0">Seleccione plan de salud:</asp:ListItem>
                                              <asp:ListItem Value="Sin isapre">Sin isapre</asp:ListItem>
                                              <asp:ListItem Value="Banmédica">Banmédica</asp:ListItem>
                                              <asp:ListItem Value="Consalud">Consalud</asp:ListItem>
                                              <asp:ListItem Value="Vida Tres">Vida Tres</asp:ListItem>
                                              <asp:ListItem Value="Colmena">Colmena</asp:ListItem>
                                              <asp:ListItem Value="Isapre Cruz Blanca S.A.">Isapre Cruz Blanca S.A.</asp:ListItem>
                                              <asp:ListItem Value="Fonasa">Fonasa</asp:ListItem>
                                              <asp:ListItem Value="Nueva Masvida">Nueva Masvida</asp:ListItem>
                                              <asp:ListItem Value="Isapre de Codelco Ltda.">Isapre de Codelco Ltda.</asp:ListItem>
                                              <asp:ListItem Value="Isapre Bco. Estado">Isapre Bco. Estado</asp:ListItem>
                                              <asp:ListItem Value="Cruz del Norte">Cruz del Norte</asp:ListItem>
                                              <asp:ListItem Value="Esencial">Esencial</asp:ListItem>
                                          </asp:DropDownList>
                            </div>
                        </div>
                        <br />
                        <h6 class="text-lg font-bold dark:text-white">Dato de Pago</h6><br />

                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                    <asp:TextBox ID="TextBoxNombreCuenta" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                    <asp:TextBox ID="TextBoxRut" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                            <div>
                                <label for="DropDownListPago" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Tipo de Pago</label>
                                <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListPago" runat="server">
                                    <asp:ListItem Selected="True" Value="0">Seleccione Tipo de Pago:</asp:ListItem>
                                    <asp:ListItem Value="Depósito">Depósito</asp:ListItem>
                                    <asp:ListItem Value="Transferencia">Transferencia</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                            <div>
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
                                </div>
                            </div>
                            <div>
                                <label for="DropDownListCuenta" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Tipo de Cuenta</label>
                                <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListCuenta" runat="server">
                                    <asp:ListItem Selected="True" Value="0">Seleccione Tipo de Cuenta:</asp:ListItem>
                                    <asp:ListItem Value="Cuenta Corriente">Cuenta Corriente</asp:ListItem>
                                    <asp:ListItem Value="Cuenta Vista">Cuenta Vista</asp:ListItem>
                                    <asp:ListItem Value="Cuenta de Ahorro">Cuenta de Ahorro</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div>
                                <label class="block text-sm">
                                    <span class="text-gray-700 dark:text-gray-400">Numero de Cuenta</span>
                                    <asp:TextBox ID="TextBoxNumCuenta" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" runat="server"></asp:TextBox>
                                </label>
                            </div>
                        </div>
                        <br>
                        <div class="grid gap-6 mb-8 md:grid-cols-3">
                            <div class="col-end-3">
                                <asp:Button ID="ButtonAgregar" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                            </div>
                        </div>
                    </form>
                        </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
