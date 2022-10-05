<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarEncomienda.aspx.cs" Inherits="ManagCond.Guardia.AgregarEncomienda" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <!-- #include file ="Template/HeaderGuardia.html" -->
    <main class="h-full pb-16 overflow-y-auto">
        <div class="container grid px-6 mx-auto">
            <div class="container grid px-6 mx-auto">
                        <br />
                        <asp:Repeater ID="RepeaterImage" runat="server"></asp:Repeater>
                        <ItemTemplate>
                            <div>
                            <img class="object-cover" src="data:image/jpg;base64,<%# Convert.ToBase64String((byte[])DataBinder.Eval(Container.RouteData, "imagen")) %>"/>
                            <%#DataBinder.Eval(Container.Items, "numDpto") %>
                            <br />
                            </div>
                        </ItemTemplate>
                    </div>
            <h2
                class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Agregar Encomienda
            </h2>
            <form id="AgregarEncomienda" runat="server">
                <div class="w-full">
                    <label class="block text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Numero departamento</span><br />
                        <asp:DropDownList ID="DropDownList" runat="server">
                        </asp:DropDownList>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Destinatario</span>
                        <asp:TextBox ID="TextBoxDestinatario" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Fecha</span>
                        <asp:TextBox ID="TextBoxFecha" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server" Enabled="True"></asp:TextBox>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Hora</span>
                        <asp:TextBox ID="TextBoxHora" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Descripcion</span>
                        <asp:TextBox ID="TextBoxDescripcion" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                    </label>
                    <label class="block mt-4 text-sm">
                        <span class="text-gray-700 dark:text-gray-400">Estado</span>
                        <asp:TextBox ID="TextBoxEstado" class="form-control block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input" runat="server"></asp:TextBox>
                    </label>
                    <span class="text-gray-700 dark:text-gray-400">Subir imagen</span><br />
                    <asp:Image ID="ImagenEncomienda" Width="200" runat="server" />
                    <asp:FileUpload ID="FileUploadEncomienda" accept=".jpg" runat="server" />
                    <br />
                    <br />
                    <asp:Button ID="ButtonAgregar" class="px-4 py-2 text-sm font-semibold leading-tight text-green-700 transition-colors duration-150 bg-green-100 border border-transparent rounded-lg active:bg-green-200 hover:bg-green-200 focus:outline-none focus:shadow-outline-white" runat="server" OnClick="ButtonAgregar_Click" Text="Agregar" />
                </div>
            </form>
        </div>
    </main>
</body>
</html>
