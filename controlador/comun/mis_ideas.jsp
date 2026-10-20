<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: ideas propuestas por el usuario (docente o estudiante aprobado) --%>
<c:set var="rolesPermitidos" value="DOCENTE,ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="listarDeAutor"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<%@ include file="/WEB-INF/modelo/idea.jspf" %>

<jsp:forward page="/WEB-INF/vista/comun/mis_ideas.jsp"/>
