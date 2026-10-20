<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: el comité aprueba o rechaza (con motivo) la inscripción de un estudiante --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/comite/inscripciones.jsp"/>
</c:if>

<c:set var="decision" value="${param.decision}"/>
<c:set var="observacion" value="${fn:trim(param.observacion)}"/>
<c:catch>
    <fmt:parseNumber var="idEstudianteObjetivo" value="${param.id_estudiante}" integerOnly="true"/>
</c:catch>

<c:choose>
    <c:when test="${empty idEstudianteObjetivo or (decision ne 'APROBADO' and decision ne 'RECHAZADO')}">
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
        <%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
        <c:choose>
            <c:when test="${filasActualizadas eq 0}">
                <c:set var="error" value="La inscripción ya fue decidida."/>
            </c:when>
            <c:otherwise>
                <c:set var="mensaje" value="${decision eq 'APROBADO' ? 'Inscripción aprobada.' : 'Inscripción rechazada.'}"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/comite/inscripciones.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/comite/inscripciones.jsp"><c:param name="msg" value="${mensaje}"/></c:redirect>
    </c:otherwise>
</c:choose>
