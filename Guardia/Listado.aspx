<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Listado.aspx.cs" Inherits="ManagCond.Guardia.Listado" %>
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
    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
                    <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">Listado de Residentes</h2>
                    <!-- CTA -->
                    <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
                        <div class="w-full overflow-x-auto">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="py-3 px-6">Departamento</th>
                                        <th scope="col" class="py-3 px-6">Nombre</th>
                                        <th scope="col" class="py-3 px-6">Estacionamiento</th>
                                        <th scope="col" class="py-3 px-6">Rut Residente</th>
                                        <th scope="col" class="py-3 px-6">Telefono Residente</th>
                                        <th scope="col" class="py-3 px-6">Correo Residente</th>
                                        <th scope="col" class="py-3 px-6">Rut Propietario</th>
                                        <th scope="col" class="py-3 px-6">Nombre Propietario</th>
                                        <th scope="col" class="py-3 px-6">Telefono Propietario</th>
                                        <th scope="col" class="py-3 px-6">Correo Propietario</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int idCond = (int)Session["idCond"];

                                        foreach (Residente obj in ResidenteDao.GetAlResidente(idCond))
                                        {
                                            String idResidente = obj.RutResidente;
                                    %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td class="py-4 px-6"><%= obj.NumDpto %> </td>
                                        <td class="py-4 px-6"><%= obj.NombresResidente %> <%= obj.ApellidosResidente %></td>
                                        <td class="py-4 px-6"><%= obj.Estacinamiento %> </td>
                                        <td class="py-4 px-6"><%= obj.RutResidente %></td>
                                        <td class="py-4 px-6"><%= obj.TelefonoResidente %> </td>
                                        <td class="py-4 px-6"><%= obj.CorreoResidente %> </td>
                                        <td class="py-4 px-6"><%= obj.RutPropietario %> </td>
                                        <td class="py-4 px-6"><%= obj.NombrePropietario %> </td>
                                        <td class="py-4 px-6"><%= obj.TelefonoPropietario %> </td>
                                        <td class="py-4 px-6"><%= obj.CorreoPropietario %> </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>                     
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>