<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: lista de proyectos para el comité, con búsqueda y filtros por fase, estado y turno --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="filtroBusqueda" value="${fn:trim(param.q)}" scope="request"/>
<c:set var="filtroFase" value="${param.fase}" scope="request"/>
<c:set var="filtroEstado" value="${param.estado}" scope="request"/>
<c:set var="filtroResponsable" value="${param.responsable}" scope="request"/>

<c:set var="operacion" value="listarParaComite"/>
<%@ include file="/WEB-INF/modelo/proyecto.jspf" %>

<jsp:forward page="/WEB-INF/vista/comite/proyectos.jsp"/>
