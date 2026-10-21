<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: pantalla para que el director o el evaluador revisen la versión que les corresponde --%>
<c:set var="rolesPermitidos" value="DOCENTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:catch>
    <fmt:parseNumber var="idRevisionObjetivo" value="${param.id_revision}" integerOnly="true"/>
</c:catch>
<c:if test="${not empty idRevisionObjetivo}">
    <c:set var="operacion" value="obtener"/>
    <%@ include file="/WEB-INF/modelo/revision.jspf" %>
</c:if>
<c:if test="${empty idRevisionObjetivo or revisionDocente.rowCount eq 0
              or revisionDocente.rows[0].id_usuario ne sessionScope.usuario.id_usuario}">
    <c:redirect url="/controlador/sin_permiso.jsp"/>
</c:if>

<c:set var="idProyecto" value="${revisionDocente.rows[0].id_proyecto}"/>
<%@ include file="/WEB-INF/jspf/cargar_ficha.jspf" %>
<c:if test="${revisionDocente.rows[0].tipo_documento eq 'F-DC-125' and revisionDocente.rows[0].funcion eq 'EVALUADOR'}">
    <c:set var="operacion" value="rejillaDe"/>
    <c:set var="idVersionObjetivo" value="${revisionDocente.rows[0].id_version}"/>
    <%@ include file="/WEB-INF/modelo/version.jspf" %>
</c:if>

<jsp:forward page="/WEB-INF/vista/docente/revisar.jsp"/>
