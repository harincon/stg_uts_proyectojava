<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: el director o el evaluador registran su decisión sobre la versión que les corresponde.
     decision = APROBADO | EN_CORRECCIONES (con observaciones) | RECHAZADO (con motivo y confirmar=SI) --%>
<c:set var="rolesPermitidos" value="DOCENTE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/docente/panel.jsp"/>
</c:if>

<c:set var="idUsuario" value="${sessionScope.usuario.id_usuario}"/>
<c:set var="estadoNuevo" value="${param.decision}"/>
<c:set var="observaciones" value="${fn:trim(param.observaciones)}"/>
<c:catch>
    <fmt:parseNumber var="idRevisionObjetivo" value="${param.id_revision}" integerOnly="true"/>
</c:catch>

<c:catch var="errorGuardar">
    <sql:transaction>
        <c:if test="${not empty idRevisionObjetivo}">
            <c:set var="operacion" value="bloquear"/>
            <%@ include file="/WEB-INF/modelo/revision.jspf" %>
        </c:if>
        <c:set var="rb" value="${not empty idRevisionObjetivo and revisionBloqueada.rowCount gt 0 ? revisionBloqueada.rows[0] : null}"/>
        <c:if test="${not empty rb and rb.funcion eq 'EVALUADOR' and rb.tipo_documento eq 'F-DC-125' and estadoNuevo eq 'APROBADO'}">
            <c:set var="operacion" value="rejillaDe"/>
            <c:set var="idVersionObjetivo" value="${rb.id_version}"/>
            <%@ include file="/WEB-INF/modelo/version.jspf" %>
        </c:if>
        <c:choose>
            <c:when test="${empty rb or rb.id_usuario ne idUsuario or (rb.funcion ne 'DIRECTOR' and rb.funcion ne 'EVALUADOR')}">
                <c:set var="error" value="Esta revisión no le corresponde."/>
            </c:when>
            <c:when test="${rb.estado ne 'PENDIENTE_REVISION'}">
                <c:set var="error" value="Esta revisión ya fue resuelta."/>
            </c:when>
            <c:when test="${rb.estado_proyecto ne 'EN_CURSO' or rb.responsable_actual ne rb.funcion}">
                <c:set var="error" value="No es su turno de revisar."/>
            </c:when>
            <c:when test="${estadoNuevo ne 'APROBADO' and estadoNuevo ne 'EN_CORRECCIONES' and estadoNuevo ne 'RECHAZADO'}">
                <c:set var="error" value="Decisión no válida."/>
            </c:when>
            <c:when test="${estadoNuevo eq 'RECHAZADO' and param.confirmar ne 'SI'}">
                <c:set var="error" value="Confirme el rechazo definitivo."/>
            </c:when>
            <c:when test="${estadoNuevo ne 'APROBADO' and empty observaciones}">
                <c:set var="error" value="Escriba las observaciones."/>
            </c:when>
            <c:when test="${not empty rejilla and rejilla.rowCount eq 0}">
                <c:set var="error" value="Registre primero la rejilla F-DC-129."/>
            </c:when>
            <c:otherwise>
                <c:set var="operacion" value="decidir"/>
                <%@ include file="/WEB-INF/modelo/revision.jspf" %>
                <%@ include file="/WEB-INF/jspf/aplicar_decision.jspf" %>
                <c:set var="mensaje" value="Decisión registrada. ${mensajeTransicion}"/>
            </c:otherwise>
        </c:choose>
    </sql:transaction>
</c:catch>
<c:if test="${not empty errorGuardar}">
    <c:set var="error" value="No fue posible guardar la decisión."/>
</c:if>

<c:set var="destino" value="${rb.funcion eq 'EVALUADOR' ? '/controlador/docente/evaluador.jsp'
                              : (rb.funcion eq 'DIRECTOR' ? '/controlador/docente/director.jsp' : '/controlador/docente/panel.jsp')}"/>
<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="${destino}"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="${destino}"><c:param name="msg" value="${mensaje}"/></c:redirect>
    </c:otherwise>
</c:choose>
