<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Calendario.aspx.cs" Inherits="ManagCond.Guardia.Calendario" %>


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

    <%--Calendario--%>
    <link href="../assets/css/custom-theme/jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="../assets/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" />
    <script src="../assets/js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../assets/js/jquery-ui-1.7.3.custom.min.js" type="text/javascript"></script>
    <script src="../assets/js/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script>
    <script src="../assets/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
    <script src="../assets/js/calendarscript2.js" type="text/javascript"></script>    
    <script src="../assets/js/jquery-ui-timepicker-addon-0.6.2.min.js" type="text/javascript"></script>  


</head>
<body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen}">
        <!-- #include file ="Template/AsideGuardia.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderGuardia.html" -->
             <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid">

                    <form id="form1" runat="server">
                        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>

                        <div id="calendar"></div>


                        <div runat="server" id="jsonDiv" />
                        <input type="hidden" id="hdClient" runat="server" />
                    </form>


                </div>

            </main>
        </div>
    </div>
  </body>
</html>