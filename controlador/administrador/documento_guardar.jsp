<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: crear, editar, activar o desactivar un enlace de la base documental.
     accion = crear | editar | activar | desactivar --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/administrador/documentos.jsp"/>
</c:if>

<c:set var="accion" value="${param.accion}"/>
<c:set var="nombreDocumento" value="${fn:trim(param.nombre)}"/>
<c:set var="urlDocumento" value="${fn:trim(param.url)}"/>
<c:catch>
    <fmt:parseNumber var="idDocumento" value="${param.id_documento}" integerOnly="true"/>
</c:catch>
<c:if test="${empty idDocumento}">
    <c:set var="idDocumento" value="${0}"/>
</c:if>

<c:choose>
    <c:when test="${accion eq 'crear' or accion eq 'editar'}">
        <c:choose>
            <c:when test="${empty nombreDocumento or empty urlDocumento}">
                <c:set var="error" value="Nombre y URL son obligatorios."/>
            </c:when>
            <c:when test="${not (fn:startsWith(urlDocumento, 'http://') or fn:startsWith(urlDocumento, 'https://'))}">
                <c:set var="error" value="La URL debe empezar por http:// o https://."/>
            </c:when>
            <c:otherwise>
                <c:set var="operacion" value="${accion}"/>
                <%@ include file="/WEB-INF/modelo/documento.jspf" %>
                <c:set var="mensaje" value="Documento guardado."/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${accion eq 'activar' or accion eq 'desactivar'}">
        <c:set var="operacion" value="cambiarActivo"/>
        <c:set var="activoNuevo" value="${accion eq 'activar' ? 'true' : 'false'}"/>
        <%@ include file="/WEB-INF/modelo/documento.jspf" %>
        <c:set var="mensaje" value="${accion eq 'activar' ? 'Documento activado.' : 'Documento desactivado.'}"/>
    </c:when>
    <c:otherwise>
        <c:set var="error" value="Acción no válida."/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/administrador/documentos.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/administrador/documentos.jsp"><c:param name="msg" value="${mensaje}"/></c:redirect>
    </c:otherwise>
</c:choose>
