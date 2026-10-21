<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: panel del estudiante. Recibe miProyecto. --%>
<c:set var="tituloPagina" value="Panel del estudiante"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Panel del estudiante</h1>
<p class="text-muted">Bienvenido, <c:out value="${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}"/>.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<c:choose>
    <c:when test="${miProyecto.rowCount gt 0}">
        <c:set var="p" value="${miProyecto.rows[0]}"/>
        <c:set var="efFase" value="${p.id_fase}"/>
        <c:set var="efResponsable" value="${p.responsable_actual}"/>
        <c:set var="efEstado" value="${p.estado}"/>
        <div class="card shadow-sm">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-start gap-2 flex-wrap mb-2">
                    <div>
                        <div class="text-muted small">Mi trabajo de grado</div>
                        <h2 class="h5 mb-0"><c:out value="${p.titulo}"/></h2>
                    </div>
                    <%@ include file="/WEB-INF/vista/plantilla/etiqueta_fase.jspf" %>
                </div>
                <p class="small mb-2"><strong>Fase actual:</strong> <c:out value="${p.fase}"/> &middot;
                    <strong>Estudiante responsable:</strong> <c:out value="${p.responsable}"/> (responsable)</p>

                <div class="alert alert-light border mb-3">
                    <strong>Próxima acción:</strong>
                    <c:choose>
                        <c:when test="${p.estado eq 'FINALIZADO'}">El proyecto terminó satisfactoriamente.</c:when>
                        <c:when test="${p.estado eq 'RECHAZADO'}">El proyecto fue rechazado: <c:out value="${p.observacion_cierre}"/></c:when>
                        <c:when test="${p.responsable_actual eq 'ESTUDIANTE'}">
                            <c:if test="${not p.es_responsable}">le corresponde a <c:out value="${p.responsable}"/>:</c:if>
                            <c:choose>
                                <c:when test="${p.id_fase eq 1}">Registre el soporte de pago.</c:when>
                                <c:when test="${p.id_fase eq 2}">Entregue el anteproyecto (F-DC-124).</c:when>
                                <c:when test="${p.id_fase eq 4}">Entregue el informe final (F-DC-125).</c:when>
                            </c:choose>
                        </c:when>
                        <c:when test="${p.responsable_actual eq 'DIRECTOR'}">El documento está en revisión del director.</c:when>
                        <c:when test="${p.responsable_actual eq 'EVALUADOR'}">El documento está en revisión del evaluador.</c:when>
                        <c:when test="${p.id_fase eq 1}">El comité está revisando el soporte de pago y asignando director y evaluador.</c:when>
                        <c:when test="${p.id_fase eq 6}">El comité está verificando los requisitos para cerrar el proyecto.</c:when>
                        <c:otherwise>El documento está en revisión del comité.</c:otherwise>
                    </c:choose>
                </div>

                <c:url var="urlFicha" value="/controlador/comun/proyecto.jsp">
                    <c:param name="id_proyecto" value="${p.id_proyecto}"/>
                </c:url>
                <a class="btn btn-success" href="${urlFicha}"><i class="bi bi-clipboard-data"></i> Ver seguimiento</a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <div class="col-md-6">
                <a class="card shadow-sm h-100 text-decoration-none" href="<c:url value='/controlador/comun/banco_ideas.jsp'/>">
                    <div class="card-body">
                        <h2 class="h5"><i class="bi bi-lightbulb"></i> Elegir idea del banco</h2>
                        <p class="small text-muted mb-0">Busque una idea aprobada y registre su proyecto, solo o con un compañero.</p>
                    </div>
                </a>
            </div>
            <div class="col-md-6">
                <a class="card shadow-sm h-100 text-decoration-none" href="<c:url value='/controlador/comun/mis_ideas.jsp'/>">
                    <div class="card-body">
                        <h2 class="h5"><i class="bi bi-pencil-square"></i> Proponer idea propia</h2>
                        <p class="small text-muted mb-0">Si el comité la aprueba, solo usted podrá usarla para su proyecto.</p>
                    </div>
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
