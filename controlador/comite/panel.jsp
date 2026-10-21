<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel del comité (contadores de pendientes) --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="contarPendientes"/>
<%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
<c:set var="operacion" value="contarPendientes"/>
<%@ include file="/WEB-INF/modelo/idea.jspf" %>
<c:set var="operacion" value="conteoFase1"/>
<%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
<c:set var="operacion" value="conteoComite"/>
<%@ include file="/WEB-INF/modelo/revision.jspf" %>

<jsp:forward page="/WEB-INF/vista/comite/panel.jsp"/>
