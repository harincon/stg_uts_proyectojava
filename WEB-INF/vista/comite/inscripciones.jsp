<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: inscripciones pendientes. Recibe inscripcionesPendientes. --%>
<c:set var="tituloPagina" value="Inscripciones pendientes"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Inscripciones pendientes</h1>
<p class="text-muted">Estudiantes que se registraron y esperan la decisión del comité.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<c:choose>
    <c:when test="${inscripcionesPendientes.rowCount eq 0}">
        <div class="alert alert-info">No hay inscripciones pendientes.</div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <c:forEach var="i" items="${inscripcionesPendientes.rows}">
                <div class="col-lg-6">
                    <div class="card shadow-sm h-100">
                        <div class="card-body">
                            <h2 class="h5 mb-1"><c:out value="${i.nombres} ${i.apellidos}"/></h2>
                            <p class="small text-muted mb-2">
                                Identificación <c:out value="${i.identificacion}"/> &middot; <c:out value="${i.correo}"/><br>
                                <c:out value="${i.programa}"/> &middot; semestre <c:out value="${i.semestre}"/> &middot;
                                registrado el <fmt:formatDate value="${i.fecha_registro}" pattern="dd/MM/yyyy"/>
                            </p>
                            <c:if test="${not empty i.observacion_inscripcion}">
                                <div class="alert alert-warning py-2 small">
                                    <strong>Nueva solicitud.</strong> Motivo del rechazo anterior:
                                    <c:out value="${i.observacion_inscripcion}"/>
                                </div>
                            </c:if>
                            <div class="d-flex flex-wrap gap-2 align-items-start">
                                <form method="post" action="<c:url value='/controlador/comite/inscripcion_decidir.jsp'/>">
                                    <input type="hidden" name="id_estudiante" value="${i.id_estudiante}">
                                    <input type="hidden" name="decision" value="APROBADO">
                                    <button type="submit" class="btn btn-success btn-sm"><i class="bi bi-check-lg"></i> Aprobar</button>
                                </form>
                                <form class="flex-grow-1" method="post" action="<c:url value='/controlador/comite/inscripcion_decidir.jsp'/>">
                                    <input type="hidden" name="id_estudiante" value="${i.id_estudiante}">
                                    <input type="hidden" name="decision" value="RECHAZADO">
                                    <div class="input-group input-group-sm">
                                        <input type="text" class="form-control" name="observacion" required maxlength="500"
                                               placeholder="Motivo del rechazo" aria-label="Motivo del rechazo">
                                        <button type="submit" class="btn btn-outline-danger"><i class="bi bi-x-lg"></i> Rechazar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
