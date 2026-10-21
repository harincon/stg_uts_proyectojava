<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: sugerencias de compañero mientras el estudiante escribe la identificación.
     Responde JSON. Solo busca con 5 dígitos o más y devuelve como máximo 5 estudiantes disponibles. --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="prefijoIdentificacion" value="${fn:trim(param.q)}"/>
<c:set var="soloDigitos" value="${not empty prefijoIdentificacion}"/>
<c:forEach var="posicion" begin="0" end="${fn:length(prefijoIdentificacion) - 1}">
    <c:if test="${not fn:contains('0123456789', fn:substring(prefijoIdentificacion, posicion, posicion + 1))}">
        <c:set var="soloDigitos" value="${false}"/>
    </c:if>
</c:forEach>

<c:if test="${soloDigitos and fn:length(prefijoIdentificacion) ge 5}">
    <c:set var="operacion" value="buscarCompanero"/>
    <c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
    <%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
</c:if>

<jsp:forward page="/WEB-INF/vista/estudiante/buscar_companero.jsp"/>
