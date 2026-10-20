<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: banco de ideas (ideas aprobadas) con búsqueda y filtro de disponibilidad.
     El estudiante solo ve ideas de docentes y sus propias ideas aprobadas. --%>
<c:set var="rolesPermitidos" value="COMITE,DOCENTE,ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="filtroTexto" value="${fn:trim(param.q)}" scope="request"/>
<c:set var="filtroDisponibilidad" scope="request"
       value="${param.disponibilidad eq 'disponibles' or param.disponibilidad eq 'ocupadas' ? param.disponibilidad : 'todas'}"/>
<c:set var="soloParaEstudiante" value="${sessionScope.usuario.rol eq 'ESTUDIANTE' ? 'true' : 'false'}"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>

<c:set var="operacion" value="listarBanco"/>
<%@ include file="/WEB-INF/modelo/idea.jspf" %>

<jsp:forward page="/WEB-INF/vista/comun/banco_ideas.jsp"/>
