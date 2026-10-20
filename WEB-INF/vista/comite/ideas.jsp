<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: ideas pendientes de decisión. Recibe listaIdeasPendientes. --%>
<c:set var="tituloPagina" value="Ideas pendientes"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Ideas pendientes</h1>
<p class="text-muted">Ideas propuestas por docentes y estudiantes. Las aprobadas pasan al banco de ideas.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<c:choose>
    <c:when test="${listaIdeasPendientes.rowCount eq 0}">
        <div class="alert alert-info">No hay ideas pendientes.</div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <c:forEach var="idea" items="${listaIdeasPendientes.rows}">
                <div class="col-lg-6">
                    <div class="card shadow-sm h-100">
                        <div class="card-body d-flex flex-column">
                            <div class="d-flex justify-content-between gap-2">
                                <h2 class="h5 mb-1"><c:out value="${idea.titulo}"/></h2>
                                <span class="badge text-bg-light align-self-start"><c:out value="${idea.tipo_autor}"/></span>
                            </div>
                            <p class="small text-muted mb-2">Propuesta por <c:out value="${idea.autor}"/> el
                                <fmt:formatDate value="${idea.fecha_registro}" pattern="dd/MM/yyyy"/></p>
                            <p class="small mb-1"><strong>Objetivo:</strong> <c:out value="${idea.objetivo}"/></p>
                            <p class="small mb-3"><strong>Problemática:</strong> <c:out value="${idea.problematica}"/></p>
                            <div class="d-flex flex-wrap gap-2 align-items-start mt-auto">
                                <form method="post" action="<c:url value='/controlador/comite/idea_decidir.jsp'/>">
                                    <input type="hidden" name="id_idea" value="${idea.id_idea}">
                                    <input type="hidden" name="decision" value="APROBADO">
                                    <button type="submit" class="btn btn-success btn-sm"><i class="bi bi-check-lg"></i> Aprobar</button>
                                </form>
                                <form class="flex-grow-1" method="post" action="<c:url value='/controlador/comite/idea_decidir.jsp'/>">
                                    <input type="hidden" name="id_idea" value="${idea.id_idea}">
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
