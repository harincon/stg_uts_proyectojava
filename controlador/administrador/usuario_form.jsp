<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: formulario para crear (sin id) o editar (con id) un usuario --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:catch>
    <fmt:parseNumber var="idObjetivo" value="${param.id}" integerOnly="true"/>
</c:catch>
<c:if test="${not empty idObjetivo}">
    <c:set var="operacion" value="obtener"/>
    <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
    <c:if test="${usuarioObjetivo.rowCount eq 0}">
        <c:redirect url="/controlador/administrador/usuarios.jsp"><c:param name="err" value="El usuario no existe."/></c:redirect>
    </c:if>
</c:if>

<c:set var="operacion" value="listarAsignables"/>
<%@ include file="/WEB-INF/modelo/rol.jspf" %>
<c:set var="operacion" value="listar"/>
<%@ include file="/WEB-INF/modelo/programa.jspf" %>

<jsp:forward page="/WEB-INF/vista/administrador/usuario_form.jsp"/>
