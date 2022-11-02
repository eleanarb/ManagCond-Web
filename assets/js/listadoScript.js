class listadoResidente {
	datosResidente(e) {
		e.preventDefault();
		if (e.target.classList.contains('buttonList')) {
			localStorage.setItem('listado', 'Prueba');
			const listado = e.target.parentNode;
			this.leerDatosListado(listado);
		}
	}

	leerDatosListado(listado) {
		const descripcion = {
			rutP: listado.children[0].texContent,
			telefonoR: listado.children[1].texContent,
			correoR: listado.children[2].texContent,
			rutP: listado.children[3].texContent,
			nombreP: listado.children[4].texContent,
			telefonoP: listado.children[5].texContent,
			correoP: listado.children[6].texContent
		}
		let listadoGuardado;
		this.guardarListado(descripcion);
	}

	guardarListado(listado) {
		this.guardarLocal(listado);
	}

	guardarLocal(listado) {
		localStorage.setItem('listado', JSON.stringify(listado));
	}

	obtenerListado() {
		let listadoGuardado;
		if (localStorage.getItem('listado') === null) {
			listadoGuardado = [];
		} else {
			listadoGuardado = JSON.parse(localStorage.getItem('listado'));
		}
		return listadoGuardado;
	}

	leerLocalStorage() {
		let listadoGuardado;
		listadoGuardado = this.obtenerListado();
		document.querySelector('#rutR').value = listadoGuardado.rutP;
		document.querySelector('#telefonoR').value = listadoGuardado.telefonoR;
		document.querySelector('#correoR').value = listadoGuardado.correoR;
		document.querySelector('#rutP').value = listadoGuardado.rutP;
		document.querySelector('#nombreP').value = listadoGuardado.nombreP;
		document.querySelector('#telefonoP').value = listadoGuardado.telefonoP;
		document.querySelector('#correoP').value = listadoGuardado.correoP;
	}

}
