<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: ideas pendientes de decisión del comité --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="listarPendientes"/>
<%@ include file="/WEB-INF/modelo/idea.jspf" %>

<jsp:forward page="/WEB-INF/vista/comite/ideas.jsp"/>
