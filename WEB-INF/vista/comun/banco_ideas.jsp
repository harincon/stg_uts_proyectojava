<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: banco de ideas. Recibe bancoIdeas, filtroTexto y filtroDisponibilidad. --%>
<c:set var="tituloPagina" value="Banco de ideas"/>
<c:set var="esEstudiante" value="${sessionScope.usuario.rol eq 'ESTUDIANTE'}"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Banco de ideas</h1>
<p class="text-muted">
    <c:choose>
        <c:when test="${esEstudiante}">Ideas aprobadas por el comité que puede elegir para su trabajo de grado.</c:when>
        <c:otherwise>Ideas aprobadas por el comité.</c:otherwise>
    </c:choose>
</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<form class="row g-2 mb-3" method="get" action="<c:url value='/controlador/comun/banco_ideas.jsp'/>">
    <div class="col-md-7">
        <input type="search" class="form-control" name="q" value="<c:out value='${filtroTexto}'/>"
               placeholder="Buscar por título o autor">
    </div>
    <div class="col-md-3">
        <select class="form-select" name="disponibilidad" aria-label="Disponibilidad">
            <option value="todas" ${filtroDisponibilidad eq 'todas' ? 'selected' : ''}>Todas</option>
            <option value="disponibles" ${filtroDisponibilidad eq 'disponibles' ? 'selected' : ''}>Disponibles</option>
            <option value="ocupadas" ${filtroDisponibilidad eq 'ocupadas' ? 'selected' : ''}>No disponibles</option>
        </select>
    </div>
    <div class="col-md-2">
        <button type="submit" class="btn btn-outline-success w-100"><i class="bi bi-search"></i> Buscar</button>
    </div>
</form>

<c:choose>
    <c:when test="${bancoIdeas.rowCount eq 0}">
        <div class="alert alert-info">No hay ideas con esos filtros.</div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <c:forEach var="idea" items="${bancoIdeas.rows}">
                <div class="col-md-6 col-xl-4">
                    <div class="card shadow-sm h-100">
                        <div class="card-body d-flex flex-column">
                            <div class="d-flex justify-content-between gap-2 mb-1">
                                <h2 class="h6 mb-0"><c:out value="${idea.titulo}"/></h2>
                                <c:choose>
                                    <c:when test="${idea.disponible}"><span class="badge text-bg-success align-self-start">Disponible</span></c:when>
                                    <c:otherwise><span class="badge text-bg-secondary align-self-start">No disponible</span></c:otherwise>
                                </c:choose>
                            </div>
                            <p class="small text-muted mb-2"><c:out value="${idea.autor}"/> &middot;
                                <c:out value="${idea.tipo_autor eq 'DOCENTE' ? 'Docente' : 'Estudiante'}"/></p>
                            <p class="small mb-1"><strong>Objetivo:</strong> <c:out value="${idea.objetivo}"/></p>
                            <p class="small mb-3"><strong>Problemática:</strong> <c:out value="${idea.problematica}"/></p>
                            <c:if test="${esEstudiante and idea.disponible}">
                                <c:url var="urlUsar" value="/controlador/estudiante/proyecto_nuevo.jsp">
                                    <c:param name="id_idea" value="${idea.id_idea}"/>
                                </c:url>
                                <a class="btn btn-sm btn-success mt-auto align-self-start" href="${urlUsar}">
                                    <i class="bi bi-journal-plus"></i> Usar esta idea
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
