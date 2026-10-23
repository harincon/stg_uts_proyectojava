<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: página de inicio. Con la sesión abierta lleva al panel del rol.
     La lista de usuarios de prueba solo se muestra en modo demostración (variable de entorno MODO_DEMO=true). --%>
<c:if test="${not empty sessionScope.usuario}">
    <%@ include file="/WEB-INF/jspf/ruta_panel.jspf" %>
    <c:redirect url="${rutaPanel}"/>
</c:if>
<c:set var="modoDemo" value="${System.getenv('MODO_DEMO') eq 'true'}" scope="request"/>
<c:catch var="errorBD">
    <c:set var="operacion" value="listar"/>
    <%@ include file="/WEB-INF/modelo/fase.jspf" %>
    <c:if test="${modoDemo}">
        <c:set var="operacion" value="listarDePrueba"/>
        <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
    </c:if>
</c:catch>
<c:set var="errorBD" value="${errorBD}" scope="request"/>
<jsp:forward page="/WEB-INF/vista/inicio.jsp"/>
