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
        <c:if test="${p.estado eq 'RECHAZADO'}">
            <h2 class="h5 mt-4">Empezar un nuevo proyecto</h2>
            <%@ include file="/WEB-INF/vista/estudiante/opciones_inicio.jspf" %>
        </c:if>
    </c:when>
    <c:otherwise>
        <%@ include file="/WEB-INF/vista/estudiante/opciones_inicio.jspf" %>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
