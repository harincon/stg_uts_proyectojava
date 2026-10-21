<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel del estudiante (su proyecto o las opciones para empezar uno) --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="deUsuarioEstudiante"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<%@ include file="/WEB-INF/modelo/proyecto.jspf" %>

<jsp:forward page="/WEB-INF/vista/estudiante/panel.jsp"/>
