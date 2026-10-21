<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: apartado "Como evaluador". Recibe proyectosDocente y filtro. --%>
<c:set var="tituloPagina" value="Como evaluador"/>
<c:set var="rutaApartado" value="/controlador/docente/evaluador.jsp"/>
<c:set var="otroDocente" value="Director"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3 encabezado-evaluador"><i class="bi bi-person-badge"></i> Como evaluador</h1>
<p class="text-muted">Proyectos en los que el comité lo asignó como evaluador. El botón <strong>Gestionar</strong> aparece cuando es su turno.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<%@ include file="/WEB-INF/vista/docente/lista_proyectos.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
