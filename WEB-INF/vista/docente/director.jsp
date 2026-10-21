<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: apartado "Como director". Recibe proyectosDocente y filtro. --%>
<c:set var="tituloPagina" value="Como director"/>
<c:set var="rutaApartado" value="/controlador/docente/director.jsp"/>
<c:set var="otroDocente" value="Evaluador"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3 encabezado-director"><i class="bi bi-person-badge"></i> Como director</h1>
<p class="text-muted">Proyectos en los que el comité lo asignó como director. El botón <strong>Gestionar</strong> aparece cuando es su turno.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<%@ include file="/WEB-INF/vista/docente/lista_proyectos.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
