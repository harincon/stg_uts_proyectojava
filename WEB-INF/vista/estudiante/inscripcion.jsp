<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: estado de la inscripción del estudiante. Recibe inscripcion. --%>
<c:set var="datos" value="${inscripcion.rows[0]}"/>
<c:set var="tituloPagina" value="Estado de mi inscripción"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Estado de mi inscripción</h1>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<div class="card shadow-sm">
    <div class="card-body">
        <p class="mb-1"><strong>Estudiante:</strong>
            <c:out value="${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}"/></p>
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

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
