<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: panel docente. Recibe resumenDocente y resumenIdeas. --%>
<c:set var="tituloPagina" value="Panel docente"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<c:set var="rd" value="${resumenDocente.rows[0]}"/>
<c:set var="ri" value="${resumenIdeas.rows[0]}"/>

<h1 class="h3">Panel docente</h1>
<p class="text-muted">Bienvenido, <c:out value="${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}"/>.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<div class="row g-3">
    <div class="col-md-4">
        <a class="card shadow-sm h-100 text-decoration-none apartado-director" href="<c:url value='/controlador/docente/director.jsp'/>">
            <div class="card-body">
                <div class="small text-muted">Como director</div>
                <div class="display-6 fw-bold"><c:out value="${rd.dirige}"/></div>
                <div class="small">proyectos &middot; <strong><c:out value="${rd.director_pendientes}"/></strong> esperan su revisión</div>
            </div>
        </a>
    </div>
    <div class="col-md-4">
        <a class="card shadow-sm h-100 text-decoration-none apartado-evaluador" href="<c:url value='/controlador/docente/evaluador.jsp'/>">
            <div class="card-body">
                <div class="small text-muted">Como evaluador</div>
                <div class="display-6 fw-bold"><c:out value="${rd.evalua}"/></div>
                <div class="small">proyectos &middot; <strong><c:out value="${rd.evaluador_pendientes}"/></strong> esperan su revisión</div>
            </div>
        </a>
    </div>
    <div class="col-md-4">
        <a class="card shadow-sm h-100 text-decoration-none" href="<c:url value='/controlador/comun/mis_ideas.jsp'/>">
            <div class="card-body">
                <div class="small text-muted">Mis ideas</div>
                <div class="small mt-2">
                    <span class="badge text-bg-warning"><c:out value="${ri.pendientes}"/> pendientes</span>
                    <span class="badge text-bg-success"><c:out value="${ri.aprobadas}"/> aprobadas</span>
                    <span class="badge text-bg-danger"><c:out value="${ri.rechazadas}"/> rechazadas</span>
                </div>
            </div>
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
