<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: el estudiante con inscripción RECHAZADA corrige sus datos y vuelve a solicitar --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/estudiante/inscripcion.jsp"/>
</c:if>

<c:choose>
    <c:when test="${usuarioActual.estado_inscripcion ne 'RECHAZADO'}">
        <c:set var="error" value="Solo puede volver a solicitar si su inscripción fue rechazada."/>
    </c:when>
    <c:otherwise>
        <c:set var="nombresNuevo" value="${fn:trim(param.nombres)}"/>
        <c:set var="apellidosNuevo" value="${fn:trim(param.apellidos)}"/>
        <c:set var="identificacionNueva" value="${fn:trim(param.identificacion)}"/>
        <c:set var="correoNuevo" value="${fn:toLowerCase(fn:trim(param.correo))}"/>
        <c:set var="idObjetivo" value="${sessionScope.usuario.id_usuario}"/>
        <%@ include file="/WEB-INF/jspf/validar_estudiante.jspf" %>

        <c:if test="${empty error}">
            <c:set var="operacion" value="obtenerPorNombre"/>
            <c:set var="nombreRol" value="ESTUDIANTE"/>
            <%@ include file="/WEB-INF/modelo/rol.jspf" %>
            <c:set var="idRolNuevo" value="${rolBuscado.rows[0].id_rol}"/>
            <c:catch var="errorGuardar">
                <sql:transaction>
                    <c:set var="operacion" value="actualizar"/>
                    <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                    <c:set var="operacion" value="reenviar"/>
                    <%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
                </sql:transaction>
            </c:catch>
            <c:choose>
                <c:when test="${not empty errorGuardar}">
                    <c:set var="error" value="No fue posible enviar la solicitud. Revise el programa elegido."/>
                </c:when>
                <c:otherwise>
                    <c:set target="${sessionScope.usuario}" property="nombres" value="${nombresNuevo}"/>
                    <c:set target="${sessionScope.usuario}" property="apellidos" value="${apellidosNuevo}"/>
                    <c:set target="${sessionScope.usuario}" property="correo" value="${correoNuevo}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/estudiante/inscripcion.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/estudiante/inscripcion.jsp"><c:param name="msg" value="Solicitud enviada nuevamente al comité."/></c:redirect>
    </c:otherwise>
</c:choose>
