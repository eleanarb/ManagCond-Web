<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="listados.aspx.cs" Inherits="ManagCond.listados" %>

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
  </head>
  <body>
    <div
      class="flex h-screen bg-gray-50 dark:bg-gray-900"
      :class="{ 'overflow-hidden': isSideMenuOpen }"
    >
              <!-- #include file ="Template/AsideAdministrador.html" -->
        <div class="flex flex-col flex-1 w-full">
            <!-- #include file ="Template/HeaderAdministrador.html" -->
                    <main class="h-full pb-16 overflow-y-auto">
          <div class="container grid px-6 mx-auto">
            <h2
              class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200"
            >
              Listado de Residentes
            </h2>
            <!-- CTA -->

            <div class="w-full mb-8 overflow-hidden rounded-lg shadow-xs">
              <div class="w-full overflow-x-auto">
                <table class="w-full whitespace-no-wrap">
                  <thead>
                    <tr
                      class="text-xs font-semibold tracking-wide text-left text-gray-500 uppercase border-b dark:border-gray-700 bg-gray-50 dark:text-gray-400 dark:bg-gray-800"
                    >
                      <th class="px-4 py-3">Departamento</th>
                      <th class="px-4 py-3">Propietario</th>
                      <th class="px-4 py-3">Número de Contacto</th>
                      <th class="px-4 py-3">Correo</th>
                      <th class="px-4 py-3">Estacionamiento</th>
                    </tr>
                  </thead>
                  <tbody
                    class="bg-white divide-y dark:divide-gray-700 dark:bg-gray-800"
                  >
                    <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">701</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Matías Valencia</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 3013 0211
                      </td>
                       <td class="px-4 py-3 text-sm">
                        matias.valencia01@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                        >
                          701
                        </span>
                      </td>                      
                    </tr>

                    <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">702</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Daniela Hurtado</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 4513 0245
                      </td>
                       <td class="px-4 py-3 text-sm">
                        hurtadoda@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-orange-700 bg-orange-100 rounded-full dark:text-white dark:bg-orange-600"
                        >
                          NO
                        </span>
                      </td>                     
                    </tr>
                      <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">701</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Matías Valencia</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 3013 0211
                      </td>
                       <td class="px-4 py-3 text-sm">
                        matias.valencia01@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                        >
                          701
                        </span>
                      </td>                      
                    </tr>

                    <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">702</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Daniela Hurtado</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 4513 0245
                      </td>
                       <td class="px-4 py-3 text-sm">
                        hurtadoda@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-orange-700 bg-orange-100 rounded-full dark:text-white dark:bg-orange-600"
                        >
                          NO
                        </span>
                      </td>                     
                    </tr>
                      <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">701</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Matías Valencia</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 3013 0211
                      </td>
                       <td class="px-4 py-3 text-sm">
                        matias.valencia01@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                        >
                          701
                        </span>
                      </td>                      
                    </tr>

                    <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">702</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Daniela Hurtado</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 4513 0245
                      </td>
                       <td class="px-4 py-3 text-sm">
                        hurtadoda@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-orange-700 bg-orange-100 rounded-full dark:text-white dark:bg-orange-600"
                        >
                          NO
                        </span>
                      </td>                     
                    </tr>
                      <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">701</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Matías Valencia</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 3013 0211
                      </td>
                       <td class="px-4 py-3 text-sm">
                        matias.valencia01@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                        >
                          701
                        </span>
                      </td>                      
                    </tr>

                    <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">702</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Daniela Hurtado</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 4513 0245
                      </td>
                       <td class="px-4 py-3 text-sm">
                        hurtadoda@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-orange-700 bg-orange-100 rounded-full dark:text-white dark:bg-orange-600"
                        >
                          NO
                        </span>
                      </td>                     
                    </tr>
                      <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">701</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Matías Valencia</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 3013 0211
                      </td>
                       <td class="px-4 py-3 text-sm">
                        matias.valencia01@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                        >
                          701
                        </span>
                      </td>                      
                    </tr>

                    <tr class="text-gray-700 dark:text-gray-400">
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">702</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex items-center text-sm">
        
                          <div>
                            <p class="font-semibold">Daniela Hurtado</p>
                          </div>
                        </div>
                      </td>
                      <td class="px-4 py-3 text-sm">
                        +56 9 4513 0245
                      </td>
                       <td class="px-4 py-3 text-sm">
                        hurtadoda@gmail.com
                      </td>
                      <td class="px-4 py-3 text-xs">
                        <span
                          class="px-2 py-1 font-semibold leading-tight text-orange-700 bg-orange-100 rounded-full dark:text-white dark:bg-orange-600"
                        >
                          NO
                        </span>
                      </td>                     
                    </tr>

                    
                  </tbody>
                </table>
              </div>
              <div
                class="grid px-4 py-3 text-xs font-semibold tracking-wide text-gray-500 uppercase border-t dark:border-gray-700 bg-gray-50 sm:grid-cols-9 dark:text-gray-400 dark:bg-gray-800"
              >
                <span class="flex items-center col-span-3">
                  Showing 21-30 of 100
                </span>
                <span class="col-span-2"></span>
                <!-- Pagination -->
                <span class="flex col-span-4 mt-2 sm:mt-auto sm:justify-end">
                  <nav aria-label="Table navigation">
                    <ul class="inline-flex items-center">
                      <li>
                        <button
                          class="px-3 py-1 rounded-md rounded-l-lg focus:outline-none focus:shadow-outline-purple"
                          aria-label="Previous"
                        >
                          <svg
                            aria-hidden="true"
                            class="w-4 h-4 fill-current"
                            viewBox="0 0 20 20"
                          >
                            <path
                              d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                              clip-rule="evenodd"
                              fill-rule="evenodd"
                            ></path>
                          </svg>
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          1
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          2
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 text-white transition-colors duration-150 bg-purple-600 border border-r-0 border-purple-600 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          3
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          4
                        </button>
                      </li>
                      <li>
                        <span class="px-3 py-1">...</span>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          8
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md focus:outline-none focus:shadow-outline-purple"
                        >
                          9
                        </button>
                      </li>
                      <li>
                        <button
                          class="px-3 py-1 rounded-md rounded-r-lg focus:outline-none focus:shadow-outline-purple"
                          aria-label="Next"
                        >
                          <svg
                            class="w-4 h-4 fill-current"
                            aria-hidden="true"
                            viewBox="0 0 20 20"
                          >
                            <path
                              d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                              clip-rule="evenodd"
                              fill-rule="evenodd"
                            ></path>
                          </svg>
                        </button>
                      </li>
                    </ul>
                  </nav>
                </span>
              </div>
            </div></main>

            </div>


</body>
</html>
