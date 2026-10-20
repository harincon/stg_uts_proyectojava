<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: estado de la inscripción del estudiante --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="inscripcionDeUsuario"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<%@ include file="/WEB-INF/modelo/estudiante.jspf" %>

<jsp:forward page="/WEB-INF/vista/estudiante/inscripcion.jsp"/>
