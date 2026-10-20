<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: estado de la inscripción del estudiante (y formulario para volver a solicitar si fue rechazada) --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="inscripcionDeUsuario"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<%@ include file="/WEB-INF/modelo/estudiante.jspf" %>

<c:if test="${inscripcion.rows[0].estado_inscripcion eq 'RECHAZADO'}">
    <c:set var="operacion" value="listar"/>
    <%@ include file="/WEB-INF/modelo/programa.jspf" %>
</c:if>

<jsp:forward page="/WEB-INF/vista/estudiante/inscripcion.jsp"/>
