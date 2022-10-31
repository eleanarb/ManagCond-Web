<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditarEncomienda.aspx.cs" Inherits="ManagCond.Guardia.EditarEncomienda" %>

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
            <h2
                class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Editar Encomienda
            </h2>
            <form id="EditarEncomienda" runat="server">
                <div class="w-full">
                    <label class="block text-sm">
                        <span class="text-gray-700 dark:text-gray-200">Numero departamento</span><br />
                        <asp:DropDownList class="mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-multiselect focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownList" runat="server">
                        </asp:DropDownList>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-200">Destinatario</span>
                        <asp:TextBox ID="TextBoxDestinatario" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-200">Descripcion</span>
                        <asp:TextBox ID="TextBoxDescripcion" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                    </label>
                    <span class="text-gray-700 dark:text-gray-200">Subir imagen</span><br />
                    <INPUT ID="FileUploadEncomienda" accept="image/*" type="file" runat="server" NAME="oFile">
                    <label class="block text-sm">
                        <span class="text-gray-700 dark:text-gray-200">Estado</span><br />
                        <asp:DropDownList class="mt-1 text-sm dark:text-gray-300 dark:border-gray-600 dark:bg-gray-700 form-multiselect focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:focus:shadow-outline-gray" ID="DropDownListEstado" runat="server">
                        </asp:DropDownList>
                    </label>
                    <br />
                    <br />
                    <asp:Button ID="ButtonAceptar" class="px-4 py-2 text-sm font-semibold leading-tight text-green-700 transition-colors duration-150 bg-green-100 border border-transparent rounded-lg active:bg-green-200 hover:bg-green-200 focus:outline-none focus:shadow-outline-white" runat="server" OnClick="ButtonAceptar_Click" Text="Aceptar" />
                </div>
            </form>
        </div>
    </main>
   </div>
</div>
</body>
</html>