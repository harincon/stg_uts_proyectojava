<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: guarda la nueva contraseña del usuario de la sesión --%>
<c:set var="rolesPermitidos" value="TODOS"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/comun/cambiar_clave.jsp"/>
</c:if>

<c:choose>
    <c:when test="${empty param.actual or empty param.nueva or empty param.confirmacion}">
        <c:set var="error" value="Complete todos los campos."/>
    </c:when>
    <c:when test="${fn:length(param.nueva) lt 8}">
        <c:set var="error" value="La nueva contraseña debe tener al menos 8 caracteres."/>
    </c:when>
    <c:when test="${param.nueva ne param.confirmacion}">
        <c:set var="error" value="La confirmación no coincide."/>
    </c:when>
    <c:otherwise>
        <c:set var="operacion" value="cambiarClave"/>
        <c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
        <c:set var="claveActual" value="${param.actual}"/>
        <c:set var="claveNueva" value="${param.nueva}"/>
        <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
        <c:if test="${filasActualizadas eq 0}">
            <c:set var="error" value="La contraseña actual no es correcta."/>
        </c:if>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/comun/cambiar_clave.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/comun/cambiar_clave.jsp"><c:param name="msg" value="Contraseña actualizada."/></c:redirect>
    </c:otherwise>
</c:choose>
