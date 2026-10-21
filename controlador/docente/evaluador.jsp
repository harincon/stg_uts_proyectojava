<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: apartado "Como evaluador" (proyectos donde el comité asignó al docente como evaluador).
     filtro = pendientes (solo los que esperan su revisión) | todos --%>
<c:set var="rolesPermitidos" value="DOCENTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="filtro" value="${param.filtro eq 'pendientes' ? 'pendientes' : 'todos'}" scope="request"/>
<c:set var="operacion" value="proyectosDeDocente"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<c:set var="funcionAsignada" value="EVALUADOR"/>
<c:set var="soloPendientes" value="${filtro eq 'pendientes' ? 'true' : 'false'}"/>
<%@ include file="/WEB-INF/modelo/asignacion.jspf" %>

<jsp:forward page="/WEB-INF/vista/docente/evaluador.jsp"/>
