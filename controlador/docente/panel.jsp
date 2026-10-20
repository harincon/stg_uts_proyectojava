<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel docente --%>
<c:set var="rolesPermitidos" value="DOCENTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<jsp:forward page="/WEB-INF/vista/docente/panel.jsp"/>
