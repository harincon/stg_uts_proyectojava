<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: página de inicio. Con la sesión abierta lleva al panel del rol. --%>
<c:if test="${not empty sessionScope.usuario}">
    <%@ include file="/WEB-INF/jspf/ruta_panel.jspf" %>
    <c:redirect url="${rutaPanel}"/>
</c:if>
<c:catch var="errorBD">
    <c:set var="operacion" value="listar"/>
    <%@ include file="/WEB-INF/modelo/fase.jspf" %>
    <c:set var="operacion" value="listarDePrueba"/>
    <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
</c:catch>
<c:set var="errorBD" value="${errorBD}" scope="request"/>
<jsp:forward page="/WEB-INF/vista/inicio.jsp"/>
