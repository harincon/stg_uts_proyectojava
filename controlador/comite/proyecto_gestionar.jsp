<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: ficha del proyecto con las acciones del comité (revisión en turno y asignación de docentes) --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:catch>
    <fmt:parseNumber var="idProyecto" value="${param.id_proyecto}" integerOnly="true"/>
</c:catch>
<c:if test="${not empty idProyecto}">
    <%@ include file="/WEB-INF/jspf/cargar_ficha.jspf" %>
</c:if>
<c:if test="${empty idProyecto or ficha.rowCount eq 0}">
    <c:redirect url="/controlador/comite/proyectos.jsp"><c:param name="err" value="El proyecto no existe."/></c:redirect>
</c:if>

<c:set var="operacion" value="pendienteComite"/>
<%@ include file="/WEB-INF/modelo/revision.jspf" %>
<c:if test="${revisionComite.rowCount gt 0 and revisionComite.rows[0].tipo_documento eq 'F-DC-125'}">
    <c:set var="operacion" value="rejillaDe"/>
    <c:set var="idVersionObjetivo" value="${revisionComite.rows[0].id_version}"/>
    <%@ include file="/WEB-INF/modelo/version.jspf" %>
</c:if>
<c:if test="${ficha.rows[0].id_fase eq 1 and ficha.rows[0].estado eq 'EN_CURSO'}">
    <c:set var="operacion" value="docentesActivos"/>
    <%@ include file="/WEB-INF/modelo/asignacion.jspf" %>
</c:if>

<jsp:forward page="/WEB-INF/vista/comite/proyecto_gestionar.jsp"/>
