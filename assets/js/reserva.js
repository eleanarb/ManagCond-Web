const reserva = new ReservaP();
const reservas = document.getElementById('reservas-pendientes');

cargarEventos();

function cargarEventos() {
	document.addEventListener('DOMContentLoaded', reserva.leerLocalStorage());
	reservas.addEventListener('click', (e) => { reserva.reservaPendiente(e) });
}
