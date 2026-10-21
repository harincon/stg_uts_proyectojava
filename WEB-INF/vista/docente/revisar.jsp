<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: revisión del director o del evaluador. Recibe revisionDocente, los datos de la ficha y,
     para el evaluador del informe final, rejilla. --%>
<c:set var="rv" value="${revisionDocente.rows[0]}"/>
<c:set var="tituloPagina" value="Revisar documento"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
<c:set var="nombreDocumento" value="${rv.tipo_documento eq 'F-DC-124' ? 'Anteproyecto (F-DC-124)' : 'Informe final (F-DC-125)'}"/>
<c:set var="enTurno" value="${rv.estado eq 'PENDIENTE_REVISION' and ficha.rows[0].estado eq 'EN_CURSO'
                             and ficha.rows[0].responsable_actual eq rv.funcion}"/>

<div class="card shadow-sm border-success mb-3">
    <div class="card-body">
        <div class="small text-muted">Revisión como <c:out value="${rv.funcion eq 'DIRECTOR' ? 'director' : 'evaluador'}"/></div>
        <h1 class="h4"><c:out value="${nombreDocumento}"/> &middot; versión <c:out value="${rv.version}"/></h1>
        <a class="btn btn-outline-success" href="<c:out value='${rv.url}'/>" target="_blank" rel="noopener">
            <i class="bi bi-box-arrow-up-right"></i> Abrir el documento: <c:out value="${rv.url}"/>
        </a>
    </div>
</div>

<c:choose>
    <c:when test="${not enTurno}">
        <div class="alert alert-info">Esta revisión ya fue resuelta o no es su turno de revisar.</div>
    </c:when>
    <c:otherwise>
        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <div class="card shadow-sm h-100">
                    <div class="card-body">
                        <h2 class="h5">Aprobar</h2>
                        <form method="post" action="<c:url value='/controlador/docente/revision_guardar.jsp'/>">
                            <input type="hidden" name="id_revision" value="${rv.id_revision}">
                            <input type="hidden" name="decision" value="APROBADO">
                            <label class="form-label small" for="obsAprobar">Observaciones (opcional)</label>
                            <textarea class="form-control form-control-sm mb-2" id="obsAprobar" name="observaciones" rows="2"></textarea>
                            <button type="submit" class="btn btn-success w-100"><i class="bi bi-check-lg"></i> Aprobar</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card shadow-sm h-100">
                    <div class="card-body">
                        <h2 class="h5">Solicitar correcciones</h2>
                        <form method="post" action="<c:url value='/controlador/docente/revision_guardar.jsp'/>">
                            <input type="hidden" name="id_revision" value="${rv.id_revision}">
                            <input type="hidden" name="decision" value="EN_CORRECCIONES">
                            <label class="form-label small" for="obsCorrecciones">Observaciones para el estudiante</label>
                            <textarea class="form-control form-control-sm mb-2" id="obsCorrecciones" name="observaciones" rows="2" required></textarea>
                            <button type="submit" class="btn btn-warning w-100">Solicitar correcciones</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="card border-danger mb-4 zona-rechazo">
            <div class="card-body">
                <h2 class="h6 text-danger"><i class="bi bi-exclamation-octagon"></i> Rechazar definitivamente</h2>
                <p class="small mb-2">Solo para situaciones graves (por ejemplo, copia comprobada). Esta acción termina el proyecto
                    y el estudiante pierde el proceso.</p>
                <form method="post" action="<c:url value='/controlador/docente/revision_guardar.jsp'/>"
                      data-confirmar-rechazo="Esta acción termina el proyecto. ¿Está seguro?">
                    <input type="hidden" name="id_revision" value="${rv.id_revision}">
                    <input type="hidden" name="decision" value="RECHAZADO">
                    <input type="hidden" name="confirmar" value="">
                    <label class="form-label small" for="motivoRechazo">Motivo del rechazo</label>
                    <textarea class="form-control form-control-sm mb-2" id="motivoRechazo" name="observaciones" rows="2" required></textarea>
                    <button type="submit" class="btn btn-danger">Rechazar definitivamente</button>
                </form>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/vista/comun/ficha_proyecto.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
