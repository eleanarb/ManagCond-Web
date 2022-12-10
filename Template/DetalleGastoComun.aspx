<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetalleGastoComun.aspx.cs" Inherits="ManagCond.Template.DetalleGastoComun" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <% string id = Request.QueryString["id"]; %>
            <h1><%=id %></h1>
        </div>
    </form>
</body>
</html>
