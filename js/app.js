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
