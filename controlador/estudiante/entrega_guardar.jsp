<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: el estudiante responsable registra la URL de un documento (T2, T5, T11).
     El tipo depende de la fase: 1 soporte de pago, 2 anteproyecto F-DC-124, 4 informe final F-DC-125.
     Cada entrega es una versión nueva en el historial y crea la revisión del siguiente responsable. --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/estudiante/panel.jsp"/>
</c:if>

<c:catch>
    <fmt:parseNumber var="idProyecto" value="${param.id_proyecto}" integerOnly="true"/>
</c:catch>
<c:if test="${empty idProyecto}">
    <c:redirect url="/controlador/estudiante/panel.jsp"/>
</c:if>
<c:set var="urlDocumento" value="${fn:trim(param.url)}"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>

<c:catch var="errorGuardar">
    <sql:transaction>
        <c:set var="operacion" value="bloquear"/>
        <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
        <c:set var="operacion" value="integranteActual"/>
        <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
        <c:set var="pb" value="${proyectoBloqueado.rowCount gt 0 ? proyectoBloqueado.rows[0] : null}"/>

        <c:choose>
            <c:when test="${empty pb or integranteActual.rowCount eq 0 or not integranteActual.rows[0].es_responsable}">
                <c:set var="error" value="Solo el estudiante responsable puede entregar documentos."/>
            </c:when>
            <c:when test="${pb.estado ne 'EN_CURSO' or pb.responsable_actual ne 'ESTUDIANTE'
                            or (pb.id_fase ne 1 and pb.id_fase ne 2 and pb.id_fase ne 4)}">
                <c:set var="error" value="No es su turno de entregar."/>
            </c:when>
            <c:when test="${not (fn:startsWith(urlDocumento, 'http://') or fn:startsWith(urlDocumento, 'https://'))}">
                <c:set var="error" value="La URL debe empezar por http:// o https://."/>
            </c:when>
            <c:otherwise>
                <c:set var="tipoDocumento" value="${pb.id_fase eq 1 ? 'SOPORTE_PAGO' : (pb.id_fase eq 2 ? 'F-DC-124' : 'F-DC-125')}"/>
                <c:set var="operacion" value="siguienteVersion"/>
                <%@ include file="/WEB-INF/modelo/version.jspf" %>
                <c:set var="numeroVersion" value="${siguiente.rows[0].numero}"/>
                <c:set var="operacion" value="crear"/>
                <%@ include file="/WEB-INF/modelo/version.jspf" %>

                <c:set var="idVersionObjetivo" value="${versionCreada.rows[0].id_version}"/>
                <c:choose>
                    <c:when test="${pb.id_fase eq 1}">
                        <c:set var="funcionRevisor" value="COMITE"/>
                        <c:remove var="idRevisorAsignado"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="operacion" value="deProyecto"/>
                        <%@ include file="/WEB-INF/modelo/asignacion.jspf" %>
                        <c:forEach var="d" items="${docentesProyecto.rows}">
                            <c:if test="${d.funcion eq 'DIRECTOR'}"><c:set var="idRevisorAsignado" value="${d.id_usuario}"/></c:if>
                        </c:forEach>
                        <c:set var="funcionRevisor" value="DIRECTOR"/>
                    </c:otherwise>
                </c:choose>
                <c:set var="operacion" value="crear"/>
                <%@ include file="/WEB-INF/modelo/revision.jspf" %>

                <c:set var="operacion" value="actualizarTurno"/>
                <c:set var="faseNueva" value="${pb.id_fase}"/>
                <c:set var="responsableNuevo" value="${funcionRevisor}"/>
                <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
                <c:set var="mensaje" value="Documento registrado (versión ${numeroVersion})."/>
            </c:otherwise>
        </c:choose>
    </sql:transaction>
</c:catch>
<c:if test="${not empty errorGuardar}">
    <c:set var="error" value="No fue posible registrar el documento."/>
</c:if>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/comun/proyecto.jsp">
            <c:param name="id_proyecto" value="${idProyecto}"/><c:param name="err" value="${error}"/>
        </c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/comun/proyecto.jsp">
            <c:param name="id_proyecto" value="${idProyecto}"/><c:param name="msg" value="${mensaje}"/>
        </c:redirect>
    </c:otherwise>
</c:choose>
