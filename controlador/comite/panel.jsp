<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel del comité --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<jsp:forward page="/WEB-INF/vista/comite/panel.jsp"/>
