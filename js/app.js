// JavaScript del navegador para el Sistema de Gestión de Trabajos de Grado.
document.addEventListener('DOMContentLoaded', function () {

    // Formularios que piden confirmación antes de enviarse (atributo data-confirmar)
    document.querySelectorAll('form[data-confirmar]').forEach(function (formulario) {
        formulario.addEventListener('submit', function (evento) {
            var mensaje = formulario.getAttribute('data-confirmar');
            if (mensaje && !window.confirm(mensaje)) {
                evento.preventDefault();
            }
        });
    });

    // Rechazo definitivo: pide confirmación y solo entonces marca confirmar=SI
    document.querySelectorAll('form[data-confirmar-rechazo]').forEach(function (formulario) {
        formulario.addEventListener('submit', function (evento) {
            if (!window.confirm(formulario.getAttribute('data-confirmar-rechazo'))) {
                evento.preventDefault();
                return;
            }
            formulario.querySelector('input[name=confirmar]').value = 'SI';
        });
    });

    // Muestra los campos de estudiante solo cuando el rol elegido es ESTUDIANTE
    document.querySelectorAll('select[data-campos-estudiante]').forEach(function (selector) {
        var campos = document.querySelector(selector.getAttribute('data-campos-estudiante'));
        function actualizar() {
            var opcion = selector.options[selector.selectedIndex];
            var esEstudiante = opcion && opcion.getAttribute('data-rol') === 'ESTUDIANTE';
            campos.classList.toggle('d-none', !esEstudiante);
            campos.querySelectorAll('select, input').forEach(function (campo) {
                campo.required = esEstudiante;
            });
        }
        selector.addEventListener('change', actualizar);
        actualizar();
    });

    // Casillas que muestran y habilitan un bloque (por ejemplo, "Trabajaré con un compañero")
    document.querySelectorAll('input[type=checkbox][data-activa]').forEach(function (casilla) {
        var bloque = document.querySelector(casilla.getAttribute('data-activa'));
        function actualizar() {
            bloque.classList.toggle('d-none', !casilla.checked);
            bloque.querySelectorAll('select, input').forEach(function (campo) {
                campo.disabled = !casilla.checked;
                campo.required = casilla.checked;
            });
        }
        casilla.addEventListener('change', actualizar);
        actualizar();
    });

    // Búsqueda del compañero por identificación: sugerencias y autorrelleno de sus datos
    document.querySelectorAll('input[data-buscar-companero]').forEach(function (campo) {
        var url = campo.getAttribute('data-buscar-companero');
        var lista = document.querySelector(campo.getAttribute('data-sugerencias'));
        var tarjeta = document.querySelector(campo.getAttribute('data-tarjeta'));
        var espera = null;

        function mostrarTarjeta(estudiante) {
            if (!estudiante) {
                tarjeta.classList.add('d-none');
                return;
            }
            ['nombre', 'identificacion', 'programa', 'semestre'].forEach(function (dato) {
                tarjeta.querySelector('[data-campo="' + dato + '"]').textContent = estudiante[dato];
            });
            tarjeta.classList.remove('d-none');
        }

        function elegir(estudiante) {
            campo.value = estudiante.identificacion;
            lista.innerHTML = '';
            mostrarTarjeta(estudiante);
        }

        function buscar() {
            var texto = campo.value.trim();
            mostrarTarjeta(null);
            if (!/^[0-9]{5,15}$/.test(texto)) {
                lista.innerHTML = '';
                return;
            }
            fetch(url + (url.indexOf('?') >= 0 ? '&' : '?') + 'q=' + encodeURIComponent(texto),
                  { credentials: 'same-origin' })
                .then(function (respuesta) { return respuesta.json(); })
                .then(function (estudiantes) {
                    lista.innerHTML = '';
                    var exacto = estudiantes.filter(function (e) { return e.identificacion === texto; })[0];
                    if (exacto) {
                        mostrarTarjeta(exacto);
                        return;
                    }
                    if (estudiantes.length === 0) {
                        var vacio = document.createElement('div');
                        vacio.className = 'list-group-item small text-muted';
                        vacio.textContent = 'No hay estudiantes disponibles con esa identificación.';
                        lista.appendChild(vacio);
                        return;
                    }
                    estudiantes.forEach(function (estudiante) {
                        var opcion = document.createElement('button');
                        opcion.type = 'button';
                        opcion.className = 'list-group-item list-group-item-action small';
                        opcion.textContent = estudiante.identificacion + ' · ' + estudiante.nombre + ' · ' + estudiante.programa;
                        opcion.addEventListener('click', function () { elegir(estudiante); });
                        lista.appendChild(opcion);
                    });
                })
                .catch(function () { lista.innerHTML = ''; });
        }

        campo.addEventListener('input', function () {
            clearTimeout(espera);
            espera = setTimeout(buscar, 300);
        });
    });

    // Ventana para restablecer la contraseña: copia el usuario elegido
    var modalRestablecer = document.getElementById('modalRestablecer');
    if (modalRestablecer) {
        modalRestablecer.addEventListener('show.bs.modal', function (evento) {
            var boton = evento.relatedTarget;
            document.getElementById('idRestablecer').value = boton.getAttribute('data-id');
            document.getElementById('nombreRestablecer').textContent = boton.getAttribute('data-nombre');
            document.getElementById('claveRestablecer').value = '';
        });
    }
});
