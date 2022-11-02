let listado = new listadoResidente();
const listados = document.getElementById('listadoR');

cargarEventos();

function cargarEventos() {
	document.addEventListener('DOMContentLoaded', listado.leerLocalStorage());
	listados.addEventListener('click', (e) => { listado.datosResidente(e) });
}
