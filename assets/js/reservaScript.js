class ReservaP {
	reservaPendiente(e) {
		e.preventDefault();
		if (e.target.classList.contains('btnReservaP')) {
			const reserva = e.target.parentElement;
			this.leerDatosReserva(reserva);
		}
	}

	leerDatosReserva(reserva) {
		const descripcion = {
			espacioComun: reserva.querySelector('h2').textContent,
			depto: reserva.querySelector('i').textContent,
			fecha: reserva.querySelector('p').textContent,
			id: reserva.querySelector('.btnReservaP').getAttribute('data-id'),
		}
		let reservaGuardada;
		this.guardarReserva(descripcion);
	}

	guardarReserva(reserva) {
		this.guardarLocal(reserva);
	}

	guardarLocal(reserva) {
		localStorage.setItem('reserva', JSON.stringify(reserva));
	}

	obtenerReserva() {
		let reservaGuardada;
		if (localStorage.getItem('reserva') === null) {
			reservaGuardada = [];
		} else {
			reservaGuardada = JSON.parse(localStorage.getItem('reserva'));
        }
		return reservaGuardada;
	}

	leerLocalStorage() {
		let reservaGuardada;
		reservaGuardada = this.obtenerReserva();
		document.querySelector('#titulo').innerText = reservaGuardada.espacioComun;
		document.querySelector('#depto').innerText = reservaGuardada.depto;
		document.querySelector('#fecha').innerText = reservaGuardada.fecha;
		document.querySelector('#idReserva').value = reservaGuardada.id;
	}

}
