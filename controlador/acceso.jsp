<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: inicio de sesión. Valida el correo y la contraseña y envía a cada rol a su panel. --%>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/index.jsp"/>
</c:if>

<c:set var="correoBuscado" value="${fn:toLowerCase(fn:trim(param.correo))}"/>
<c:set var="claveIngresada" value="${param.clave}"/>
<c:if test="${empty correoBuscado or empty claveIngresada}">
    <c:redirect url="/index.jsp"><c:param name="err" value="Escriba el correo y la contraseña."/></c:redirect>
</c:if>

<c:set var="operacion" value="autenticar"/>
<%@ include file="/WEB-INF/modelo/usuario.jspf" %>

<c:if test="${usuarioEncontrado.rowCount eq 0}">
    <c:redirect url="/index.jsp"><c:param name="err" value="Correo o contraseña incorrectos."/></c:redirect>
</c:if>
<c:if test="${not usuarioEncontrado.rows[0].activo}">
    <c:redirect url="/index.jsp"><c:param name="err" value="Su cuenta está desactivada."/></c:redirect>
</c:if>

<c:set var="nuevoIdSesion" value="${pageContext.request.changeSessionId()}"/>
<c:set var="usuario" value="${usuarioEncontrado.rows[0]}" scope="session"/>
<%@ include file="/WEB-INF/jspf/ruta_panel.jspf" %>
<c:redirect url="${rutaPanel}"/>
