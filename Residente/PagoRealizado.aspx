<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PagoRealizado.aspx.cs" Inherits="ManagCond.Residente.PagoRealizado" %>
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

    <link rel="stylesheet" href="https://unpkg.com/flowbite@1.5.3/dist/flowbite.min.css" />

    <script src="https://unpkg.com/flowbite@1.5.3/dist/datepicker.js"></script>

        <script src=
"https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"> 
    </script> 
</head>
<body>
    <div class="flex items-center justify-center min-h-screen p-6 bg-gray-50 dark:bg-gray-900 ">

        <div class="flex items-center justify-center ">

            <form id="login" runat="server">       
                
                <div class="w-full max-w-sm p-4 bg-white border rounded-lg shadow-md sm:p-8 dark:bg-gray-800 dark:border-gray-700">

                    <nav class="flex" aria-label="Breadcrumb">
                    <ol class="inline-flex items-center space-x-1 md:space-x-3">
                        <li class="inline-flex items-center">
                            <a href="GastosComunes.aspx" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path></svg>
                                Gastos Comunes
                            </a>
                        </li>
                    </ol>
                </nav>
                    <br />


                    <li class="flex space-x-3">
                        <img style="width:20%; height:20%;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Check_green_circle.svg/1200px-Check_green_circle.svg.png">
                        <p class=" text-xl  leading-tight font-bold text-gray-900 dark:text-white">SE HA REALIZADO SU PAGO CORRECTAMENTE</p>
                    </li>
                    <br />
                    <% 
                        int idCondominio = (int)Session["idCond"];
                        Condominio cond = CondominioDao.ObtenerDatosCondominio(idCondominio);
                        int id = int.Parse(Request.QueryString["id"]);
                        GastosComunes gc = GastosComunesDao.ObtenerDatosGastoComun(idCondominio, id);
                        string mes = "";
                        if( gc.MesCobro == 1){mes = "Enero"; } if( gc.MesCobro == 2){mes = "Febrero"; } if( gc.MesCobro == 3){mes = "Marzo"; } if( gc.MesCobro == 4){mes = "Abril"; } if( gc.MesCobro == 5){mes = "Mayo"; } if( gc.MesCobro == 6){mes = "Junio"; } if( gc.MesCobro == 7){mes = "Julio"; } if( gc.MesCobro == 8){mes = "Agosto"; } if( gc.MesCobro == 9){mes = "Septiembre"; } if( gc.MesCobro == 10){mes = "Octubre"; } if( gc.MesCobro == 11){mes = "Noviembre"; } if( gc.MesCobro == 12){mes = "Diciembre"; }
                    %>
                    <p class="text-sm text-gray-900 dark:text-white">Condominio <%=cond.Nombre %></p>
                    <h5 class="mb-4 text-lg  font-medium text-gray-900 dark:text-white">Gasto Común de <%=mes %>  <%=gc.AñoCobro %></h5>
                    <p class="text-sm text-gray-900 dark:text-white">falta poner la fecha </p>
                   
                    
                     <div class="grid gap-6 mb-8 md:grid-cols-2 justify-center">
                        <p style="margin: -2.5% 0;" class="text-sm font-bold text-gray-900 dark:text-white text-left">Total</p>
                        <p style="margin: -2.5% 0;" class="text-2xl font-extrabold  text-gray-900 dark:text-white text-right">$ <%=gc.TotalPagar.ToString("N0") %></p>                       
                    </div>            
                    

                    <p class="text-sm text-gray-900 dark:text-white">A través de</p>
                    <div class="grid gap-6 mb-8 md:grid-cols-2 justify-center"  style="margin: 0% 0;">
                        <img  src="https://s3.amazonaws.com/static.khipu.com/buttons/2021/110x50-white.png">
                        <img  src="https://www.gamewarrior.cl/wp-content/uploads/2018/07/es-transferencia-bancaria.png">                       
                    </div>
                    
                    </div>

            </form>

        </div>

    </div>


</body>
</html>