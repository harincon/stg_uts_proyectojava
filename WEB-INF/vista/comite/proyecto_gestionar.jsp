<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: gestión del proyecto por el comité. Recibe los datos de la ficha, revisionComite y,
     en la fase 1, docentesDisponibles. --%>
<c:set var="tituloPagina" value="Gestionar proyecto"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
<c:set var="g" value="${ficha.rows[0]}"/>

<div class="row g-3">
    <div class="col-lg-8">
        <%@ include file="/WEB-INF/vista/comun/ficha_proyecto.jspf" %>
    </div>
    <div class="col-lg-4">
        <c:if test="${g.estado eq 'EN_CURSO' and g.responsable_actual eq 'COMITE' and revisionComite.rowCount gt 0}">
            <c:set var="rc" value="${revisionComite.rows[0]}"/>
            <div class="card shadow-sm border-success mb-3">
                <div class="card-body">
                    <h2 class="h5">
                        <c:choose>
                            <c:when test="${rc.tipo_documento eq 'SOPORTE_PAGO'}">Revisar soporte de pago</c:when>
                            <c:when test="${rc.tipo_documento eq 'F-DC-124'}">Aprobar anteproyecto</c:when>
                            <c:otherwise>Aprobar informe final</c:otherwise>
                        </c:choose>
                    </h2>
                    <p class="small">Versión <c:out value="${rc.version}"/>:
                        <a href="<c:out value='${rc.url}'/>" target="_blank" rel="noopener">abrir documento</a></p>
                    <form method="post" action="<c:url value='/controlador/comite/proyecto_accion.jsp'/>" class="mb-2">
                        <input type="hidden" name="accion" value="decidir_revision">
                        <input type="hidden" name="id_proyecto" value="${g.id_proyecto}">
                        <input type="hidden" name="id_revision" value="${rc.id_revision}">
                        <input type="hidden" name="decision" value="APROBADO">
                        <button type="submit" class="btn btn-success w-100"><i class="bi bi-check-lg"></i> Aprobar</button>
                    </form>
                    <form method="post" action="<c:url value='/controlador/comite/proyecto_accion.jsp'/>">
                        <input type="hidden" name="accion" value="decidir_revision">
                        <input type="hidden" name="id_proyecto" value="${g.id_proyecto}">
                        <input type="hidden" name="id_revision" value="${rc.id_revision}">
                        <input type="hidden" name="decision" value="EN_CORRECCIONES">
                        <label class="form-label small" for="obsCorrecciones">Observaciones para el estudiante</label>
                        <textarea class="form-control form-control-sm mb-2" id="obsCorrecciones" name="observaciones" rows="3" required></textarea>
                        <button type="submit" class="btn btn-outline-warning w-100">Solicitar correcciones</button>
                    </form>
                </div>
            </div>
            <c:if test="${rc.tipo_documento ne 'SOPORTE_PAGO'}">
                <div class="card border-danger mb-3 zona-rechazo">
                    <div class="card-body">
                        <h2 class="h6 text-danger"><i class="bi bi-exclamation-octagon"></i> Rechazar definitivamente</h2>
                        <p class="small mb-2">Solo para situaciones graves. Esta acción termina el proyecto.</p>
                        <form method="post" action="<c:url value='/controlador/comite/proyecto_accion.jsp'/>"
                              data-confirmar-rechazo="Esta acción termina el proyecto. ¿Está seguro?">
                            <input type="hidden" name="accion" value="decidir_revision">
                            <input type="hidden" name="id_proyecto" value="${g.id_proyecto}">
                            <input type="hidden" name="id_revision" value="${rc.id_revision}">
                            <input type="hidden" name="decision" value="RECHAZADO">
                            <input type="hidden" name="confirmar" value="">
                            <label class="form-label small" for="motivoRechazo">Motivo del rechazo</label>
                            <textarea class="form-control form-control-sm mb-2" id="motivoRechazo" name="observaciones" rows="2" required></textarea>
                            <button type="submit" class="btn btn-danger w-100">Rechazar definitivamente</button>
                        </form>
                    </div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${g.id_fase eq 1 and g.estado eq 'EN_CURSO'}">
            <c:set var="idDirectorActual" value=""/>
            <c:set var="idEvaluadorActual" value=""/>
            <c:forEach var="d" items="${docentesProyecto.rows}">
                <c:if test="${d.funcion eq 'DIRECTOR'}"><c:set var="idDirectorActual" value="${d.id_usuario}"/></c:if>
                <c:if test="${d.funcion eq 'EVALUADOR'}"><c:set var="idEvaluadorActual" value="${d.id_usuario}"/></c:if>
            </c:forEach>
            <div class="card shadow-sm">
                <div class="card-body">
                    <h2 class="h5">Asignar director y evaluador</h2>
                    <form method="post" action="<c:url value='/controlador/comite/proyecto_accion.jsp'/>">
                        <input type="hidden" name="accion" value="asignar_docentes">
                        <input type="hidden" name="id_proyecto" value="${g.id_proyecto}">
                        <label class="form-label small" for="id_director">Director</label>
                        <select class="form-select form-select-sm mb-2" id="id_director" name="id_director" required>
                            <option value="">Seleccione…</option>
                            <c:forEach var="d" items="${docentesDisponibles.rows}">
                                <option value="${d.id_usuario}" ${d.id_usuario eq idDirectorActual ? 'selected' : ''}><c:out value="${d.nombre}"/></option>
                            </c:forEach>
                        </select>
                        <label class="form-label small" for="id_evaluador">Evaluador</label>
                        <select class="form-select form-select-sm mb-3" id="id_evaluador" name="id_evaluador" required>
                            <option value="">Seleccione…</option>
                            <c:forEach var="d" items="${docentesDisponibles.rows}">
                                <option value="${d.id_usuario}" ${d.id_usuario eq idEvaluadorActual ? 'selected' : ''}><c:out value="${d.nombre}"/></option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="btn btn-success w-100">Guardar asignación</button>
                        <div class="form-text">El director y el evaluador deben ser docentes distintos.</div>
                    </form>
                </div>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
