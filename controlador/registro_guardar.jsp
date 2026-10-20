<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: registra la cuenta del estudiante con la inscripción PENDIENTE del comité.
     El rol siempre es ESTUDIANTE: nunca se toma del formulario. --%>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/registro.jsp"/>
</c:if>

<c:set var="nombresNuevo" value="${fn:trim(param.nombres)}"/>
<c:set var="apellidosNuevo" value="${fn:trim(param.apellidos)}"/>
<c:set var="identificacionNueva" value="${fn:trim(param.identificacion)}"/>
<c:set var="correoNuevo" value="${fn:toLowerCase(fn:trim(param.correo))}"/>
<c:set var="claveNueva" value="${param.clave}"/>
<c:set var="confirmacionClave" value="${param.confirmacion}"/>
<c:set var="pedirClave" value="${true}"/>
<c:set var="idObjetivo" value="${0}"/>
<%@ include file="/WEB-INF/jspf/validar_estudiante.jspf" %>

<c:if test="${empty error}">
    <c:set var="operacion" value="obtenerPorNombre"/>
    <c:set var="nombreRol" value="ESTUDIANTE"/>
    <%@ include file="/WEB-INF/modelo/rol.jspf" %>
    <c:set var="idRolNuevo" value="${rolBuscado.rows[0].id_rol}"/>
    <c:catch var="errorGuardar">
        <sql:transaction>
            <c:set var="operacion" value="crear"/>
            <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
            <c:set var="idObjetivo" value="${usuarioCreado.rows[0].id_usuario}"/>
            <c:set var="operacion" value="crearPendiente"/>
            <%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
        </sql:transaction>
    </c:catch>
    <c:if test="${not empty errorGuardar}">
        <c:set var="error" value="No fue posible completar el registro. Revise el programa elegido."/>
    </c:if>
</c:if>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/registro.jsp">
            <c:param name="err" value="${error}"/>
            <c:param name="nombres" value="${nombresNuevo}"/>
            <c:param name="apellidos" value="${apellidosNuevo}"/>
            <c:param name="identificacion" value="${identificacionNueva}"/>
            <c:param name="correo" value="${correoNuevo}"/>
            <c:param name="id_programa" value="${param.id_programa}"/>
            <c:param name="semestre" value="${param.semestre}"/>
        </c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/index.jsp">
            <c:param name="msg" value="Registro exitoso. Su inscripción está pendiente de aprobación del comité."/>
        </c:redirect>
    </c:otherwise>
</c:choose>
