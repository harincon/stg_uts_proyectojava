<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: lista de usuarios con búsqueda, filtros y páginas de 20 --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="filtroTexto" value="${fn:trim(param.q)}" scope="request"/>
<c:set var="filtroRol" value="${param.rol}" scope="request"/>
<c:set var="filtroActivo" value="${param.activo eq 'true' or param.activo eq 'false' ? param.activo : ''}" scope="request"/>
<c:catch>
    <fmt:parseNumber var="pagina" value="${param.pagina}" integerOnly="true" scope="request"/>
</c:catch>
<c:if test="${empty pagina or pagina lt 1}">
    <c:set var="pagina" value="${1}" scope="request"/>
</c:if>
<c:set var="desplazamiento" value="${(pagina - 1) * 20}"/>

<c:set var="operacion" value="listarFiltrado"/>
<%@ include file="/WEB-INF/modelo/usuario.jspf" %>

<fmt:parseNumber var="totalPaginas" value="${(totalFiltrado.rows[0].total + 19) / 20}" integerOnly="true" scope="request"/>
<c:if test="${totalPaginas lt 1}">
    <c:set var="totalPaginas" value="${1}" scope="request"/>
</c:if>

<jsp:forward page="/WEB-INF/vista/administrador/usuarios.jsp"/>
