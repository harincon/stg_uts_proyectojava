<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: ficha de seguimiento de un proyecto con su historial de versiones.
     La ven el comité, los docentes asignados y los estudiantes del proyecto. --%>
<c:set var="rolesPermitidos" value="COMITE,DOCENTE,ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:catch>
    <fmt:parseNumber var="idProyecto" value="${param.id_proyecto}" integerOnly="true"/>
</c:catch>
<c:if test="${empty idProyecto}">
    <c:redirect url="/controlador/sin_permiso.jsp"/>
</c:if>

<c:set var="operacion" value="permisoVer"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<c:set var="rolUsuario" value="${sessionScope.usuario.rol}"/>
<%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
<c:if test="${permisoFicha.rows[0].total eq 0}">
    <c:redirect url="/controlador/sin_permiso.jsp"/>
</c:if>

<%@ include file="/WEB-INF/jspf/cargar_ficha.jspf" %>

<jsp:forward page="/WEB-INF/vista/comun/proyecto.jsp"/>
