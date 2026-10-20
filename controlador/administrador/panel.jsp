<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel del administrador --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<jsp:forward page="/WEB-INF/vista/administrador/panel.jsp"/>
