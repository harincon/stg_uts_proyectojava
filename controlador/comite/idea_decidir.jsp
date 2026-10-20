<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: el comité aprueba una idea (pasa al banco) o la rechaza con motivo --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/comite/ideas.jsp"/>
</c:if>

<c:set var="decision" value="${param.decision}"/>
<c:set var="observacion" value="${fn:trim(param.observacion)}"/>
<c:catch>
    <fmt:parseNumber var="idIdeaObjetivo" value="${param.id_idea}" integerOnly="true"/>
</c:catch>

<c:choose>
    <c:when test="${empty idIdeaObjetivo or (decision ne 'APROBADO' and decision ne 'RECHAZADO')}">
        <c:set var="error" value="Decisión no válida."/>
    </c:when>
    <c:when test="${decision eq 'RECHAZADO' and empty observacion}">
        <c:set var="error" value="Escriba el motivo del rechazo."/>
    </c:when>
    <c:otherwise>
        <c:if test="${decision eq 'APROBADO'}">
            <c:set var="observacion" value=""/>
        </c:if>
        <c:set var="operacion" value="decidir"/>
        <%@ include file="/WEB-INF/modelo/idea.jspf" %>
        <c:choose>
            <c:when test="${filasActualizadas eq 0}">
                <c:set var="error" value="La idea ya fue decidida."/>
            </c:when>
            <c:otherwise>
                <c:set var="mensaje" value="${decision eq 'APROBADO' ? 'Idea aprobada; ya está en el banco de ideas.' : 'Idea rechazada.'}"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/comite/ideas.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/comite/ideas.jsp"><c:param name="msg" value="${mensaje}"/></c:redirect>
    </c:otherwise>
</c:choose>
