<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: el evaluador asignado registra la URL de la rejilla F-DC-129 (T14).
     La rejilla queda vinculada a la última versión del informe final (F-DC-125) y el turno no cambia. --%>
<c:set var="rolesPermitidos" value="DOCENTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/docente/evaluador.jsp"/>
</c:if>

<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<c:set var="urlDocumento" value="${fn:trim(param.url)}"/>
<c:catch>
    <fmt:parseNumber var="idProyecto" value="${param.id_proyecto}" integerOnly="true"/>
</c:catch>

<c:catch var="errorGuardar">
    <sql:transaction>
        <c:if test="${not empty idProyecto}">
            <c:set var="operacion" value="bloquear"/>
            <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
            <c:set var="operacion" value="deProyecto"/>
            <%@ include file="/WEB-INF/modelo/asignacion.jspf" %>
        </c:if>
        <c:set var="pb" value="${not empty idProyecto and proyectoBloqueado.rowCount gt 0 ? proyectoBloqueado.rows[0] : null}"/>
        <c:set var="soyEvaluador" value="${false}"/>
        <c:forEach var="d" items="${docentesProyecto.rows}">
            <c:if test="${d.funcion eq 'EVALUADOR' and d.id_usuario eq idUsuario}"><c:set var="soyEvaluador" value="${true}"/></c:if>
        </c:forEach>
        <c:choose>
            <c:when test="${empty pb or not soyEvaluador}">
                <c:set var="error" value="Solo el evaluador asignado registra la rejilla."/>
            </c:when>
            <c:when test="${pb.estado ne 'EN_CURSO' or pb.id_fase ne 5 or pb.responsable_actual ne 'EVALUADOR'}">
                <c:set var="error" value="No es su turno de registrar la rejilla."/>
            </c:when>
            <c:when test="${not (fn:startsWith(urlDocumento, 'http://') or fn:startsWith(urlDocumento, 'https://'))}">
                <c:set var="error" value="La URL debe empezar por http:// o https://."/>
            </c:when>
            <c:otherwise>
                <c:set var="operacion" value="ultimaDeTipo"/>
                <c:set var="tipoDocumento" value="F-DC-125"/>
                <%@ include file="/WEB-INF/modelo/version.jspf" %>
                <c:set var="idVersionRelacionada" value="${ultimaVersion.rows[0].id_version}"/>
                <c:set var="operacion" value="siguienteVersion"/>
                <c:set var="tipoDocumento" value="F-DC-129"/>
                <%@ include file="/WEB-INF/modelo/version.jspf" %>
                <c:set var="numeroVersion" value="${siguiente.rows[0].numero}"/>
                <c:set var="operacion" value="crear"/>
                <%@ include file="/WEB-INF/modelo/version.jspf" %>
            </c:otherwise>
        </c:choose>
    </sql:transaction>
</c:catch>
<c:if test="${not empty errorGuardar}">
    <c:set var="error" value="No fue posible registrar la rejilla."/>
</c:if>

<c:choose>
    <c:when test="${not empty param.id_revision and soyEvaluador}">
        <c:redirect url="/controlador/docente/revisar.jsp">
            <c:param name="id_revision" value="${param.id_revision}"/>
            <c:param name="${empty error ? 'msg' : 'err'}" value="${empty error ? 'Rejilla registrada.' : error}"/>
        </c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/docente/evaluador.jsp">
            <c:param name="${empty error ? 'msg' : 'err'}" value="${empty error ? 'Rejilla registrada.' : error}"/>
        </c:redirect>
    </c:otherwise>
</c:choose>
