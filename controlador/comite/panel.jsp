<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel del comité (contadores de pendientes) --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="contarPendientes"/>
<%@ include file="/WEB-INF/modelo/estudiante.jspf" %>

<jsp:forward page="/WEB-INF/vista/comite/panel.jsp"/>
