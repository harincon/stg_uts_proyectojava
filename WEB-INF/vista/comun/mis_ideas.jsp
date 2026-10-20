<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: ideas propias y formulario para proponer una nueva. Recibe misIdeas. --%>
<c:set var="tituloPagina" value="Mis ideas"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Mis ideas</h1>
<p class="text-muted">Las ideas que propone pasan al banco de ideas cuando el comité las aprueba.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<div class="card shadow-sm mb-4">
    <div class="card-body">
        <h2 class="h5">Proponer una idea</h2>
        <form method="post" action="<c:url value='/controlador/comun/idea_guardar.jsp'/>">
            <div class="mb-3">
                <label class="form-label" for="titulo">Título</label>
                <input type="text" class="form-control" id="titulo" name="titulo" required maxlength="250">
            </div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label" for="objetivo">Objetivo</label>
                    <textarea class="form-control" id="objetivo" name="objetivo" rows="3" required></textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="problematica">Problemática</label>
                    <textarea class="form-control" id="problematica" name="problematica" rows="3" required></textarea>
                </div>
            </div>
            <button type="submit" class="btn btn-success mt-3"><i class="bi bi-send"></i> Enviar al comité</button>
        </form>
    </div>
</div>

<h2 class="h5">Ideas propuestas</h2>
<c:choose>
    <c:when test="${misIdeas.rowCount eq 0}">
        <div class="alert alert-info">Todavía no ha propuesto ideas.</div>
    </c:when>
    <c:otherwise>
        <div class="list-group">
            <c:forEach var="idea" items="${misIdeas.rows}">
                <div class="list-group-item">
                    <div class="d-flex justify-content-between align-items-start gap-2 flex-wrap">
                        <h3 class="h6 mb-1"><c:out value="${idea.titulo}"/></h3>
                        <c:choose>
                            <c:when test="${idea.estado eq 'APROBADO'}"><span class="badge text-bg-success">Aprobada</span></c:when>
                            <c:when test="${idea.estado eq 'RECHAZADO'}"><span class="badge text-bg-danger">Rechazada</span></c:when>
                            <c:otherwise><span class="badge text-bg-warning">Pendiente</span></c:otherwise>
                        </c:choose>
                    </div>
                    <p class="small mb-1"><strong>Objetivo:</strong> <c:out value="${idea.objetivo}"/></p>
                    <p class="small mb-1"><strong>Problemática:</strong> <c:out value="${idea.problematica}"/></p>
                    <c:if test="${idea.estado eq 'RECHAZADO'}">
                        <p class="small text-danger mb-1"><strong>Motivo del rechazo:</strong> <c:out value="${idea.observacion}"/></p>
                    </c:if>
                    <c:if test="${idea.estado eq 'APROBADO'}">
                        <p class="small mb-0 text-muted">
                            <c:out value="${idea.en_uso ? 'En uso por un proyecto.' : 'Disponible en el banco de ideas.'}"/>
                        </p>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
