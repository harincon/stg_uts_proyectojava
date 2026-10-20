<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: registro del estudiante. Recibe programas y, si hubo un error, los datos enviados en los parámetros. --%>
<c:set var="tituloPagina" value="Registro de estudiante"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <h1 class="h3">Registro de estudiante</h1>
        <p class="text-muted">Después de registrarse, el comité de trabajos de grado revisará su inscripción.</p>
        <%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
        <div class="card shadow-sm">
            <div class="card-body">
                <form method="post" action="<c:url value='/controlador/registro_guardar.jsp'/>">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label" for="nombres">Nombres</label>
                            <input type="text" class="form-control" id="nombres" name="nombres" required maxlength="100"
                                   value="<c:out value='${param.nombres}'/>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="apellidos">Apellidos</label>
                            <input type="text" class="form-control" id="apellidos" name="apellidos" required maxlength="100"
                                   value="<c:out value='${param.apellidos}'/>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="identificacion">Identificación</label>
                            <input type="text" class="form-control" id="identificacion" name="identificacion" required
                                   inputmode="numeric" pattern="[0-9]{5,15}" maxlength="15"
                                   value="<c:out value='${param.identificacion}'/>">
                            <div class="form-text">Solo números, entre 5 y 15 dígitos.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="correo">Correo</label>
                            <input type="email" class="form-control" id="correo" name="correo" required maxlength="150"
                                   value="<c:out value='${param.correo}'/>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="clave">Contraseña</label>
                            <input type="password" class="form-control" id="clave" name="clave" required minlength="8">
                            <div class="form-text">Mínimo 8 caracteres.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="confirmacion">Confirmar contraseña</label>
                            <input type="password" class="form-control" id="confirmacion" name="confirmacion" required minlength="8">
                        </div>
                        <div class="col-md-8">
                            <label class="form-label" for="id_programa">Programa académico</label>
                            <select class="form-select" id="id_programa" name="id_programa" required>
                                <option value="">Seleccione…</option>
                                <c:forEach var="p" items="${programas.rows}">
                                    <option value="${p.id_programa}" ${param.id_programa eq p.id_programa ? 'selected' : ''}>
                                        <c:out value="${p.nombre}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label" for="semestre">Semestre</label>
                            <input type="number" class="form-control" id="semestre" name="semestre" required min="1" max="10"
                                   value="<c:out value='${param.semestre}'/>">
                        </div>
                    </div>
                    <div class="d-flex gap-2 mt-4">
                        <button type="submit" class="btn btn-success">Registrarme</button>
                        <a class="btn btn-outline-secondary" href="<c:url value='/index.jsp'/>">Volver al inicio</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
