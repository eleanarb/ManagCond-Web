<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambiarClave.aspx.cs" Inherits="ManagCond.CambiarClave" %>

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

    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"> 
    </script> 
</head>
<body>
    <div class="flex items-center min-h-screen p-6 bg-gray-50 dark:bg-gray-900">
        <div
            class="flex-1 h-full max-w-4xl mx-auto overflow-hidden bg-white rounded-lg shadow-xl dark:bg-gray-800">
            <div class="min-w-0 p-4 bg-white rounded-lg shadow-xs dark:bg-gray-800 ">
                
                    <form id="login" runat="server">
                        <div class="w-full">
                            <h4 class="mb-4 font-semibold text-gray-600 dark:text-gray-300">Restablecer contraseña </h4>

                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Contraseña Actual</span>
                                        <input type="password" runat="server" id="TextBoxClave1"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" />
                                    </label>
                                </div>
                            </div>

                            <div class="grid gap-6 mb-8 md:grid-cols-2">
                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Nueva Contraseña</span>
                                        <input type="password" runat="server" id="TextBoxClave2"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" />
                                    </label>
                                </div>

                                <div>
                                    <label class="block text-sm">
                                        <span class="text-gray-700 dark:text-gray-400">Confirma Contraseña</span>
                                        <input type="password" runat="server" id="TextBoxClave3" onchange="checkPasswordMatch();"
                                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500t" />
                                    </label>
                                    <span id='message' class="mt-2 text-sm text-red-600 dark:text-red-500"></span>
                                </div>
                            </div>


                            <div class="grid gap-6 mb-8 md:grid-cols-4">

                                <div class="col-end-7 col-span-2">
                                    <asp:Button ID="ButtonClave" class="w-full px-5 py-3 text-sm font-medium leading-5 text-white transition-colors duration-150 bg-purple-600 border border-transparent rounded-lg sm:w-auto sm:px-4 sm:py-2 active:bg-purple-600 hover:bg-purple-700 focus:outline-none focus:shadow-outline-purple" runat="server" OnClick="ButtonClave_Click" Text="Guardar Cambios" />
                                </div>
                            </div>
                            <%--mensaje exitoso--%>
                            <div runat="server" visible="false" id="mensajeExitoso" class="flex p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg dark:bg-green-200 dark:text-green-800" role="alert">
                                <svg aria-hidden="true" class="flex-shrink-0 inline w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>
                                <span class="sr-only">Info</span>
                                <div>
                                    <span class="font-medium">Se ha restablecido la contraseña <a
                                        class="text-sm font-medium text-purple-600 dark:text-purple-400 hover:underline"
                                        href="Login.aspx"> Iniciar Sesión
                                    </a></span>
                                </div>

                                
                            </div>
                            <%--mensaje error--%>
                            <div>
                                <div runat="server" visible="false" id="mensajeError" class="flex p-4 mb-4 text-sm text-red-700 bg-red-100 rounded-lg dark:bg-red-200 dark:text-red-800" role="alert">
                                    <svg aria-hidden="true" class="flex-shrink-0 inline w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path></svg>
                                    <span class="sr-only">Info</span>
                                    <div>
                                        <span class="font-medium">Error al restablecer la contraseña <a
                                            class="text-sm font-medium text-purple-600 dark:text-purple-400 hover:underline"
                                            href="Login.aspx"> Iniciar Sesión
                                        </a></span>
                                    </div>
                                
                            
                                </div>
                            </div>
                        </div>
                    </form>
                
            </div>
        </div>
    </div>



    <script>
         $('#TextBoxClave2, #TextBoxClave3').on('keyup', function () {
             if ($('#TextBoxClave2').val() == $('#TextBoxClave3').val()) {
                 $('#message').html('Coinciden').css('color', 'green');
             } else
                 $('#message').html('No coinciden').css('color', 'red');
         });

         function validarFormulario(evento) {

             var clave = document.getElementById('TextBoxClave').value;
             if (clave.length < 6) {
                 return false;
             } else {
                 return true;
             }
         }
    </script>


    
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
</body>
</html>