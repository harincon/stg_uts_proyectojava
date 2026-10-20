<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: formulario público de registro del estudiante --%>
<c:if test="${not empty sessionScope.usuario}">
    <c:redirect url="/index.jsp"/>
</c:if>

<c:set var="operacion" value="listar"/>
<%@ include file="/WEB-INF/modelo/programa.jspf" %>

<jsp:forward page="/WEB-INF/vista/registro.jsp"/>
