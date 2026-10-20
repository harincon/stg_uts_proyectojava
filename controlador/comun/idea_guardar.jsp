<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: registra una idea nueva; queda PENDIENTE de revisión del comité --%>
<c:set var="rolesPermitidos" value="DOCENTE,ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/comun/mis_ideas.jsp"/>
</c:if>

<c:set var="tituloIdea" value="${fn:trim(param.titulo)}"/>
<c:set var="objetivoIdea" value="${fn:trim(param.objetivo)}"/>
<c:set var="problematicaIdea" value="${fn:trim(param.problematica)}"/>

<c:choose>
    <c:when test="${empty tituloIdea or empty objetivoIdea or empty problematicaIdea}">
        <c:set var="error" value="Título, objetivo y problemática son obligatorios."/>
    </c:when>
    <c:when test="${fn:length(tituloIdea) gt 250}">
        <c:set var="error" value="El título no puede superar 250 caracteres."/>
    </c:when>
    <c:otherwise>
        <c:set var="operacion" value="crear"/>
        <c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
        <%@ include file="/WEB-INF/modelo/idea.jspf" %>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/comun/mis_ideas.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/comun/mis_ideas.jsp"><c:param name="msg" value="Idea enviada al comité."/></c:redirect>
    </c:otherwise>
</c:choose>
