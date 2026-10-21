<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: registra el proyecto (T1). Quien lo registra queda como estudiante responsable;
     el compañero (opcional, buscado por su identificación) solo consulta. Todo se valida dentro de una
     transacción que bloquea la idea. --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/comun/banco_ideas.jsp"/>
</c:if>

<c:catch>
    <fmt:parseNumber var="idIdeaObjetivo" value="${param.id_idea}" integerOnly="true"/>
</c:catch>
<%-- El compañero se identifica por su número de identificación --%>
<c:if test="${param.con_companero eq 'SI'}">
    <c:set var="identificacionBuscada" value="${fn:trim(param.identificacion_companero)}"/>
    <c:choose>
        <c:when test="${empty identificacionBuscada}">
            <c:set var="error" value="Escriba la identificación del compañero o desmarque la casilla."/>
        </c:when>
        <c:otherwise>
            <c:set var="operacion" value="obtenerPorIdentificacion"/>
            <%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
            <c:choose>
                <c:when test="${companero.rowCount eq 0}">
                    <c:set var="error" value="No hay un estudiante con esa identificación."/>
                </c:when>
                <c:otherwise>
                    <c:set var="idCompanero" value="${companero.rows[0].id_estudiante}"/>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</c:if>
<c:if test="${empty idIdeaObjetivo}">
    <c:set var="error" value="La idea ya no está disponible."/>
</c:if>

<c:if test="${empty error}">
    <c:catch var="errorGuardar">
        <sql:transaction>
            <c:set var="operacion" value="bloquearIdea"/>
            <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
            <c:set var="idea" value="${ideaElegida.rowCount gt 0 ? ideaElegida.rows[0] : null}"/>

            <c:set var="operacion" value="enCursoDeEstudiante"/>
            <c:set var="idEstudianteBuscado" value="${sessionScope.usuario.id_estudiante}"/>
            <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
            <c:set var="yoTengoProyecto" value="${enCurso.rows[0].total gt 0}"/>

            <c:if test="${not empty idCompanero}">
                <c:set var="operacion" value="enCursoDeEstudiante"/>
                <c:set var="idEstudianteBuscado" value="${idCompanero}"/>
                <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
                <c:set var="comp" value="${companero.rows[0]}"/>
                <c:set var="companeroValido" value="${not empty comp and comp.estado_inscripcion eq 'APROBADO' and comp.activo
                       and comp.id_usuario ne sessionScope.usuario.id_usuario and enCurso.rows[0].total eq 0}"/>
            </c:if>

            <c:choose>
                <c:when test="${empty idea or idea.estado ne 'APROBADO' or not idea.disponible
                                or (idea.tipo_autor ne 'DOCENTE' and idea.id_autor ne sessionScope.usuario.id_usuario)}">
                    <c:set var="error" value="La idea ya no está disponible."/>
                </c:when>
                <c:when test="${yoTengoProyecto}">
                    <c:set var="error" value="Ya tiene un proyecto en curso."/>
                </c:when>
                <c:when test="${not empty idCompanero and not companeroValido}">
                    <c:set var="error" value="El compañero no está disponible."/>
                </c:when>
                <c:otherwise>
                    <c:set var="operacion" value="crear"/>
                    <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
                    <c:set var="idProyecto" value="${proyectoCreado.rows[0].id_proyecto}"/>
                    <c:set var="operacion" value="agregarIntegrante"/>
                    <c:set var="idEstudianteIntegrante" value="${sessionScope.usuario.id_estudiante}"/>
                    <c:set var="esResponsable" value="true"/>
                    <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
                    <c:if test="${not empty idCompanero}">
                        <c:set var="idEstudianteIntegrante" value="${idCompanero}"/>
                        <c:set var="esResponsable" value="false"/>
                        <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </sql:transaction>
    </c:catch>
    <c:if test="${not empty errorGuardar}">
        <c:set var="error" value="No fue posible registrar el proyecto."/>
    </c:if>
</c:if>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/estudiante/panel.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/estudiante/panel.jsp">
            <c:param name="msg" value="Proyecto registrado. Registre el soporte de pago."/>
        </c:redirect>
    </c:otherwise>
</c:choose>
