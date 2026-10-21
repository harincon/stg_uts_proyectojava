<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: acciones del comité sobre un proyecto.
     accion = decidir_revision (revisión del comité en turno) | asignar_docentes (solo fase 1) --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/comite/proyectos.jsp"/>
</c:if>

<c:set var="accion" value="${param.accion}"/>
<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<c:catch>
    <fmt:parseNumber var="idProyecto" value="${param.id_proyecto}" integerOnly="true"/>
</c:catch>
<c:if test="${empty idProyecto}">
    <c:redirect url="/controlador/comite/proyectos.jsp"><c:param name="err" value="Proyecto no válido."/></c:redirect>
</c:if>

<c:catch var="errorGuardar">
    <sql:transaction>
        <c:choose>
            <%-- ===== Decidir la revisión del comité ===== --%>
            <c:when test="${accion eq 'decidir_revision'}">
                <c:catch>
                    <fmt:parseNumber var="idRevisionObjetivo" value="${param.id_revision}" integerOnly="true"/>
                </c:catch>
                <c:set var="estadoNuevo" value="${param.decision}"/>
                <c:set var="observaciones" value="${fn:trim(param.observaciones)}"/>
                <c:if test="${not empty idRevisionObjetivo}">
                    <c:set var="operacion" value="bloquear"/>
                    <%@ include file="/WEB-INF/modelo/revision.jspf" %>
                </c:if>
                <c:set var="rb" value="${not empty idRevisionObjetivo and revisionBloqueada.rowCount gt 0 ? revisionBloqueada.rows[0] : null}"/>
                <c:choose>
                    <c:when test="${empty rb or rb.id_proyecto ne idProyecto or rb.funcion ne 'COMITE'}">
                        <c:set var="error" value="Revisión no válida."/>
                    </c:when>
                    <c:when test="${rb.estado ne 'PENDIENTE_REVISION'}">
                        <c:set var="error" value="Esta revisión ya fue resuelta."/>
                    </c:when>
                    <c:when test="${rb.estado_proyecto ne 'EN_CURSO' or rb.responsable_actual ne 'COMITE'}">
                        <c:set var="error" value="No es el turno del comité."/>
                    </c:when>
                    <c:when test="${estadoNuevo ne 'APROBADO' and estadoNuevo ne 'EN_CORRECCIONES' and estadoNuevo ne 'RECHAZADO'}">
                        <c:set var="error" value="Decisión no válida."/>
                    </c:when>
                    <c:when test="${estadoNuevo ne 'APROBADO' and empty observaciones}">
                        <c:set var="error" value="Escriba las observaciones."/>
                    </c:when>
                    <c:when test="${rb.tipo_documento eq 'SOPORTE_PAGO' and estadoNuevo eq 'RECHAZADO'}">
                        <c:set var="error" value="El soporte de pago no se puede rechazar; solicite correcciones."/>
                    </c:when>
                    <c:when test="${rb.tipo_documento ne 'SOPORTE_PAGO'}">
                        <c:set var="error" value="Esta revisión se gestiona en una etapa posterior."/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="operacion" value="decidir"/>
                        <%@ include file="/WEB-INF/modelo/revision.jspf" %>
                        <c:choose>
                            <c:when test="${estadoNuevo eq 'EN_CORRECCIONES'}">
                                <c:set var="operacion" value="actualizarTurno"/>
                                <c:set var="faseNueva" value="${1}"/>
                                <c:set var="responsableNuevo" value="ESTUDIANTE"/>
                                <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
                                <c:set var="mensaje" value="Se solicitaron correcciones al estudiante."/>
                            </c:when>
                            <c:otherwise>
                                <%@ include file="/WEB-INF/jspf/avanzar_fase1.jspf" %>
                                <c:set var="mensaje" value="Soporte de pago aprobado.${avanzoFase ? ' El proyecto pasó a la fase 2.' : ''}"/>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </c:when>

            <%-- ===== Asignar director y evaluador ===== --%>
            <c:when test="${accion eq 'asignar_docentes'}">
                <c:catch>
                    <fmt:parseNumber var="idDirectorNuevo" value="${param.id_director}" integerOnly="true"/>
                    <fmt:parseNumber var="idEvaluadorNuevo" value="${param.id_evaluador}" integerOnly="true"/>
                </c:catch>
                <c:set var="operacion" value="bloquear"/>
                <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
                <c:set var="pb" value="${proyectoBloqueado.rowCount gt 0 ? proyectoBloqueado.rows[0] : null}"/>
                <c:if test="${not empty idDirectorNuevo and not empty idEvaluadorNuevo}">
                    <c:set var="operacion" value="contarDocentes"/>
                    <%@ include file="/WEB-INF/modelo/asignacion.jspf" %>
                </c:if>
                <c:choose>
                    <c:when test="${empty pb or pb.id_fase ne 1 or pb.estado ne 'EN_CURSO'}">
                        <c:set var="error" value="Los docentes solo se asignan en la fase 1."/>
                    </c:when>
                    <c:when test="${empty idDirectorNuevo or empty idEvaluadorNuevo}">
                        <c:set var="error" value="Seleccione el director y el evaluador."/>
                    </c:when>
                    <c:when test="${idDirectorNuevo eq idEvaluadorNuevo}">
                        <c:set var="error" value="El director y el evaluador deben ser docentes distintos."/>
                    </c:when>
                    <c:when test="${docentesValidos.rows[0].total ne 2}">
                        <c:set var="error" value="Seleccione docentes activos."/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="operacion" value="guardar"/>
                        <c:set var="funcionAsignada" value="DIRECTOR"/>
                        <c:set var="idDocenteAsignado" value="${idDirectorNuevo}"/>
                        <%@ include file="/WEB-INF/modelo/asignacion.jspf" %>
                        <c:set var="funcionAsignada" value="EVALUADOR"/>
                        <c:set var="idDocenteAsignado" value="${idEvaluadorNuevo}"/>
                        <%@ include file="/WEB-INF/modelo/asignacion.jspf" %>
                        <%@ include file="/WEB-INF/jspf/avanzar_fase1.jspf" %>
                        <c:set var="mensaje" value="Docentes asignados.${avanzoFase ? ' El proyecto pasó a la fase 2.' : ''}"/>
                    </c:otherwise>
                </c:choose>
            </c:when>

            <c:otherwise>
                <c:set var="error" value="Acción no válida."/>
            </c:otherwise>
        </c:choose>
    </sql:transaction>
</c:catch>
<c:if test="${not empty errorGuardar}">
    <c:set var="error" value="No fue posible guardar la decisión."/>
</c:if>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/comite/proyecto_gestionar.jsp">
            <c:param name="id_proyecto" value="${idProyecto}"/><c:param name="err" value="${error}"/>
        </c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/comite/proyecto_gestionar.jsp">
            <c:param name="id_proyecto" value="${idProyecto}"/><c:param name="msg" value="${mensaje}"/>
        </c:redirect>
    </c:otherwise>
</c:choose>
