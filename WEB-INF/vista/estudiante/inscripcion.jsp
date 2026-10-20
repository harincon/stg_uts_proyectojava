<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: estado de la inscripción del estudiante. Recibe inscripcion y, si fue rechazada, programas. --%>
<c:set var="datos" value="${inscripcion.rows[0]}"/>
<c:set var="tituloPagina" value="Estado de mi inscripción"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Estado de mi inscripción</h1>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<div class="card shadow-sm mb-4">
    <div class="card-body">
        <p class="mb-1"><strong>Estudiante:</strong> <c:out value="${datos.nombres} ${datos.apellidos}"/></p>
        <p class="mb-1"><strong>Programa:</strong> <c:out value="${datos.programa}"/></p>
        <p class="mb-3"><strong>Semestre:</strong> <c:out value="${datos.semestre}"/></p>

        <c:choose>
            <c:when test="${datos.estado_inscripcion eq 'APROBADO'}">
                <div class="alert alert-success mb-0">
                    Su inscripción fue aprobada por el comité.
                    <a href="<c:url value='/controlador/estudiante/panel.jsp'/>" class="alert-link">Ir a mi panel</a>
                </div>
            </c:when>
            <c:when test="${datos.estado_inscripcion eq 'RECHAZADO'}">
                <div class="alert alert-danger mb-0">
                    <p class="mb-1">Su inscripción fue rechazada por el comité.</p>
                    <p class="mb-0"><strong>Motivo:</strong> <c:out value="${datos.observacion_inscripcion}"/></p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning mb-0">
                    Su inscripción está pendiente: el comité todavía no ha tomado una decisión.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<c:if test="${datos.estado_inscripcion eq 'RECHAZADO'}">
    <h2 class="h5">Corregir mis datos y volver a solicitar</h2>
    <div class="card shadow-sm">
        <div class="card-body">
            <form method="post" action="<c:url value='/controlador/estudiante/inscripcion_reenviar.jsp'/>">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="nombres">Nombres</label>
                        <input type="text" class="form-control" id="nombres" name="nombres" required maxlength="100"
                               value="<c:out value='${datos.nombres}'/>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="apellidos">Apellidos</label>
                        <input type="text" class="form-control" id="apellidos" name="apellidos" required maxlength="100"
                               value="<c:out value='${datos.apellidos}'/>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="identificacion">Identificación</label>
                        <input type="text" class="form-control" id="identificacion" name="identificacion" required
                               inputmode="numeric" pattern="[0-9]{5,15}" maxlength="15"
                               value="<c:out value='${datos.identificacion}'/>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="correo">Correo</label>
                        <input type="email" class="form-control" id="correo" name="correo" required maxlength="150"
                               value="<c:out value='${datos.correo}'/>">
                    </div>
                    <div class="col-md-8">
                        <label class="form-label" for="id_programa">Programa académico</label>
                        <select class="form-select" id="id_programa" name="id_programa" required>
                            <c:forEach var="p" items="${programas.rows}">
                                <option value="${p.id_programa}" ${p.id_programa eq datos.id_programa ? 'selected' : ''}>
                                    <c:out value="${p.nombre}"/>
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="semestre">Semestre</label>
                        <input type="number" class="form-control" id="semestre" name="semestre" required min="1" max="10"
                               value="<c:out value='${datos.semestre}'/>">
                    </div>
                </div>
                <button type="submit" class="btn btn-success mt-4">Enviar de nuevo al comité</button>
            </form>
        </div>
    </div>
</c:if>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
