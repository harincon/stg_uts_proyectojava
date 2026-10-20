<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel del estudiante --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<jsp:forward page="/WEB-INF/vista/estudiante/panel.jsp"/>
