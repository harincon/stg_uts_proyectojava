<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: gestión del proyecto por el comité. Recibe los datos de la ficha, revisionComite, rejilla y,
     en la fase 1, docentesDisponibles. Las acciones salen dentro de la carta de la fase actual. --%>
<c:set var="tituloPagina" value="Gestionar proyecto"/>
<c:set var="volverA" value="/controlador/comite/proyectos.jsp"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<c:set var="accionesFicha" value="COMITE"/>
<%@ include file="/WEB-INF/vista/comun/ficha_proyecto.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
