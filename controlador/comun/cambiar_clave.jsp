<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: formulario de cambio de contraseña --%>
<c:set var="rolesPermitidos" value="TODOS"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<jsp:forward page="/WEB-INF/vista/comun/cambiar_clave.jsp"/>
