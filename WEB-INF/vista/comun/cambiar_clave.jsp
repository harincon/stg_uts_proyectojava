<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: formulario para cambiar la contraseña --%>
<c:set var="tituloPagina" value="Cambiar contraseña"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
        <h1 class="h3">Cambiar contraseña</h1>
        <%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
        <div class="card shadow-sm">
            <div class="card-body">
                <form method="post" action="<c:url value='/controlador/comun/cambiar_clave_guardar.jsp'/>">
                    <div class="mb-3">
                        <label class="form-label" for="actual">Contraseña actual</label>
                        <input type="password" class="form-control" id="actual" name="actual" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="nueva">Nueva contraseña</label>
                        <input type="password" class="form-control" id="nueva" name="nueva" required minlength="8">
                        <div class="form-text">Mínimo 8 caracteres.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="confirmacion">Confirmar nueva contraseña</label>
                        <input type="password" class="form-control" id="confirmacion" name="confirmacion" required minlength="8">
                    </div>
                    <button type="submit" class="btn btn-success w-100">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
