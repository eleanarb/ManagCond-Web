<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ManagCond.Index" %>

<!DOCTYPE html>
<html :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Windmill Dashboard</title>
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
    <div class="cajaLogin">
        <form id="form2" runat="server">
            <h1 style="text-align: center">Login</h1>
            <div class="row">
                <div class="col-12">
                    <label for="TextBoxUsuario">Usuario:</label>
                    <asp:TextBox ID="TextBoxUsuario" class="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <label for="TextBoxClave">Clave:</label>
                    <asp:TextBox ID="TextBoxClave" class="form-control" runat="server" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-12">
                    <asp:Button ID="ButtonAceptar" class="form-control " runat="server" OnClick="ButtonAceptar_Click" Text="Aceptar" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>
