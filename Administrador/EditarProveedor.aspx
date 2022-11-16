<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarProveedor.aspx.cs" Inherits="ManagCond.Administrador.EditarProveedor" %>

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
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../assets/css/tailwind.output.css" />
    <script
      src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js"
      defer
    ></script>
    <script src="../assets/js/init-alpine.js"></script>
      <script src="../assets/js/focus-trap.js" defer></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css"
    />
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
      defer
    ></script>
    
    <script src="../assets/js/charts-lines.js" defer></script>
    <script src="../assets/js/charts-pie.js" defer></script>
  </head>
  <body>

    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
     <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
            <main class="h-full overflow-y-auto">
                <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Editar Proveedor</h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">

                        <form runat="server">
                           <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Datos</h2>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div class="grid gap-6 mb-8 md:grid-cols-2">
                                    <div>
                                        <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                        <input type="text" runat="server" id="TextBoxNombre"
                                            class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                            required />
                                    </label>
                                    </div>
                                    <div>
                                        <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Teléfono</span>
                                        <input type="text" runat="server" id="TextBoxTelefono"
                                            class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                            required />
                                    </label>
                                    </div>
                                </div>

                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Correo</span>
                                        <input type="text" runat="server" id="TextBoxCorreo"
                                            class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                            required />
                                    </label>
                                </div>
                            </div>

                            

                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div class="grid gap-6 mb-8 md:grid-cols-2">
                                    <div>
                                        <label for="DropDownListRegion" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Región</label>
                                        <asp:DropDownList class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListRegion" OnSelectedIndexChanged="Region_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div>
                                        <label for="DropDownListComuna" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Comuna</label>
                                        <asp:DropDownList class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListComuna" OnSelectedIndexChanged="Comuna_SelectedIndexChanged" AutoPostBack="true" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Seleccione Comuna:</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>

                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Direccion</span>
                                        <input type="text" runat="server" id="TextBoxDireccion"
                                            class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                            required />
                                    </label>
                                </div>
                            </div>

                            <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Medio de Pago</h2>
                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div>
                                    <label class=" text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nombre</span>
                                        <input type="text" runat="server" id="TextBoxNombrePago"
                                            class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                            required />
                                    </label>
                                </div>

                                <div>
                                    <label class=" text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Rut</span>
                                        <input type="text" runat="server" id="TextBoxRut"
                                            class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                            required />
                                    </label>
                                </div>

                                <div>
                                    <label for="DropDownListBanco" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Banco</label>
                                        <asp:DropDownList class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListBanco" runat="server">
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

                                <div>
                                    <label for="DropDownListCuenta" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Tipo de Cuenta</label>
                                        <asp:DropDownList class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListCuenta" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Seleccione Tipo de Cuenta:</asp:ListItem>
                                            <asp:ListItem Value="Cuenta Corriente">Cuenta Corriente</asp:ListItem>
                                            <asp:ListItem Value="Cuenta Vista">Cuenta Vista</asp:ListItem>
                                            <asp:ListItem Value="Cuenta de Ahorro">Cuenta de Ahorro</asp:ListItem>
                                        </asp:DropDownList>
                                </div>

                                <div>
                                    <label class=" text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Número de Cuenta</span>
                                        <input type="text" runat="server" id="TextBoxNumero"
                                            class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input"
                                            required />
                                    </label>
                                </div>

                                <div>
                                    <label for="DropDownListPago" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Tipo de Pago</label>
                                        <asp:DropDownList class="block w-full mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-select focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListPago" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Seleccione Tipo de Pago:</asp:ListItem>
                                            <asp:ListItem Value="Depósito">Depósito</asp:ListItem>
                                            <asp:ListItem Value="Transferencia">Transferencia</asp:ListItem>
                                        </asp:DropDownList>
                                </div>
                            </div>


                            <div class="grid gap-6 mb-8 md:grid-cols-4">

                                <div class="col-end-7 col-span-2">
                                    <asp:Button ID="ButtonModificar" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonModificar_Click" Text="Modificar" />
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