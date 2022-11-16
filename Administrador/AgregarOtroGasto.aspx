<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarOtroGasto.aspx.cs" Inherits="ManagCond.Administrador.AgregarOtroGasto" %>

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

      <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

      <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

      <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
  </head>
  <body>
      <% 
          int idCondominio = 0;
          idCondominio = (int)Session["idCondominio"];
      %>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
    <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
            <main class="h-full overflow-y-auto">
                <div class="container grid px-6 mx-auto">
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Cargo </h2>
                    <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">

                               <form runat="server">
                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div>
                                      <label for="DropDownListDepto" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Departamento</label>
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListDepto" runat="server">
                                        </asp:DropDownList>
                                  </div>
                              </div>

                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div>
                                      <label for="DropDownListCargo" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Cargo</label>
                                        <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListCargo" runat="server">
                                        </asp:DropDownList>
                                  </div>

                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Cantidad</span>
                                          <input type="text" runat="server" id="TextBoxCantidad"
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                              required />
                                      </label>
                                  </div>
                              </div>

                              <div class="grid gap-6 mb-8 md:grid-cols-2">
                                  <div class="grid gap-6 mb-8 md:grid-cols-2">
                                      <div>
                                          <label for="DropDownListMes" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Mes</label>
                                          <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListMes" runat="server">
                                              <asp:ListItem Selected="True" Value="0">Seleccione Mes:</asp:ListItem>
                                              <asp:ListItem  Value="01">Enero</asp:ListItem>
                                              <asp:ListItem  Value="02">Febrero</asp:ListItem>
                                              <asp:ListItem  Value="03">Marzo</asp:ListItem>
                                              <asp:ListItem  Value="04">Abril</asp:ListItem>
                                              <asp:ListItem  Value="05">Mayo</asp:ListItem>
                                              <asp:ListItem  Value="06">Junio</asp:ListItem>
                                              <asp:ListItem  Value="07">Julio</asp:ListItem>
                                              <asp:ListItem  Value="08">Agosto</asp:ListItem>
                                              <asp:ListItem  Value="09">Septiembre</asp:ListItem>
                                              <asp:ListItem  Value="10">Octubre</asp:ListItem>
                                              <asp:ListItem  Value="11">Noviembre</asp:ListItem>
                                              <asp:ListItem  Value="12">Diciembre</asp:ListItem>
                                          </asp:DropDownList>
                                      </div>
                                      <div>
                                          <label for="DropDownListAño" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Año</label>
                                          <asp:DropDownList class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" ID="DropDownListAño" runat="server">
                                              <asp:ListItem Selected="True" Value="0">Seleccione año:</asp:ListItem>
                                              <asp:ListItem  Value="2019">2019</asp:ListItem>
                                              <asp:ListItem  Value="2020">2020</asp:ListItem>
                                              <asp:ListItem  Value="2022">2022</asp:ListItem>
                                              <asp:ListItem  Value="2023">2023</asp:ListItem>
                                              <asp:ListItem  Value="2024">2024</asp:ListItem>
                                              <asp:ListItem  Value="2025">2025</asp:ListItem>
                                              <asp:ListItem  Value="2026">2026</asp:ListItem>
                                          </asp:DropDownList>
                                      </div>
                                  </div>

                                  <div>
                                      <label class="block text-sm">
                                          <span class="text-gray-700 dark:text-gray-400">Descripcion</span>
                                          <input type="text" runat="server" id="TextBoxDesc"
                                              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                              required />
                                         </label>
                                  </div>
                              </div>

                              <div class="grid gap-6 mb-8 md:grid-cols-4">
                                  
                                  <div class="col-end-7 col-span-2">
                                      <asp:Button ID="ButtonAgregar" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                                  </div>
                              </div>

                                   </form>
                          </div>
                
                </div>
            </main>
            </div>
</body>
</html>