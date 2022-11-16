<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Calendario.aspx.cs" Inherits="ManagCond.Administrador.Calendario" %>

<!DOCTYPE html>

<html  :class="{ 'theme-dark': dark }" x-data="data()" lang="en">
<head runat="server">
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
    <script src="../assets/js/calendarscript.js" type="text/javascript"></script>     
    <script src="../assets/js/jquery-ui-timepicker-addon-0.6.2.min.js" type="text/javascript"></script>  



</head>
<body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen}"
    >
              <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
        
              <main class="h-full overflow-y-auto">
                <div class="container px-6 mx-auto grid">

                    <form id="form1" runat="server">
                        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>

                        <div id="calendar"></div>

                        <div id="updatedialog" style="font: 70% 'Trebuchet MS', sans-serif; margin: 50px;"
                            title="Actualizar o eliminar evento">
                            <table cellpadding="0" class="style1">
                                <tr>
                                    <td class="alignRight">Título:</td>
                                    <td class="alignLeft">
                                        <input id="eventName" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" type="text" /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="alignRight">Descripción:</td>
                                    <td class="alignLeft">
                                        <textarea id="eventDesc" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" cols="30" rows="3"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="alignRight">Inicio:</td>
                                    <td class="alignLeft">
                                        <span id="eventStart"></span></td>
                                </tr>
                                <tr>
                                    <td class="alignRight">Fin: </td>
                                    <td class="alignLeft">
                                        <span id="eventEnd"></span>
                                        <input type="hidden" id="eventId" /></td>
                                </tr>
                            </table>
                        </div>
                        <div id="addDialog" style="font: 70% 'Trebuchet MS', sans-serif; margin: 50px;" title="Add Event">
                            <table cellpadding="0" class="style1">
                                <tr>
                                    <td class="alignRight">Título:</td>
                                    <td class="alignLeft">
                                        <input id="addEventName" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" type="text" size="80" /><br />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="alignRight">Descripción:</td>
                                    <td class="alignLeft">
                                        <textarea id="addEventDesc" cols="30" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" rows="3"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="alignRight">Inicio:</td>
                                    <td class="alignLeft">
                                        <span id="addEventStartDate"></span></td>
                                </tr>
                                <tr>
                                    <td class="alignRight">Fin:</td>
                                    <td class="alignLeft">
                                        <span id="addEventEndDate"></span></td>
                                </tr>
                            </table>

                        </div>

                        <div runat="server" id="jsonDiv" />
                        <input type="hidden" id="hdClient" runat="server" />
                    </form>


                </div>

            </main>
      </div>
    </div>
</body>
</html>
