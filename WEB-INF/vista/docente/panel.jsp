<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: Panel docente --%>
<c:set var="tituloPagina" value="Panel docente"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Panel docente</h1>
<p class="text-muted">Bienvenido, <c:out value="${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}"/>.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
