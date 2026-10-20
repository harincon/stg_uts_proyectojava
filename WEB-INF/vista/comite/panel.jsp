<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: panel del comité. Recibe pendientes (inscripciones). --%>
<c:set var="tituloPagina" value="Panel del comité"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Panel del comité</h1>
<p class="text-muted">Bienvenido, <c:out value="${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}"/>.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<h2 class="h5 mt-4">Pendientes</h2>
<div class="row g-3">
    <div class="col-sm-6 col-lg-4">
        <a class="card shadow-sm h-100 text-decoration-none" href="<c:url value='/controlador/comite/inscripciones.jsp'/>">
            <div class="card-body">
                <div class="text-muted small">Inscripciones pendientes</div>
                <div class="display-6 fw-bold text-success"><c:out value="${pendientes.rows[0].total}"/></div>
                <div class="small">Revisar inscripciones de estudiantes &raquo;</div>
            </div>
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
