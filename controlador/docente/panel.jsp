<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel docente (proyectos que dirige y evalúa, y estado de sus ideas) --%>
<c:set var="rolesPermitidos" value="DOCENTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<c:set var="operacion" value="resumenDocente"/>
<%@ include file="/WEB-INF/modelo/asignacion.jspf" %>
<c:set var="operacion" value="resumenDeAutor"/>
<%@ include file="/WEB-INF/modelo/idea.jspf" %>

<jsp:forward page="/WEB-INF/vista/docente/panel.jsp"/>
