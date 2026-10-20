<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: crear, renombrar o eliminar un programa académico. accion = crear | editar | eliminar --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/administrador/programas.jsp"/>
</c:if>

<c:set var="accion" value="${param.accion}"/>
<c:set var="nombrePrograma" value="${fn:trim(param.nombre)}"/>
<c:catch var="errorNumero">
    <fmt:parseNumber var="idProgramaObjetivo" value="${param.id_programa}" integerOnly="true"/>
</c:catch>
<c:if test="${empty idProgramaObjetivo}">
    <c:set var="idProgramaObjetivo" value="${0}"/>
</c:if>

<c:choose>
    <c:when test="${accion eq 'crear' or accion eq 'editar'}">
        <c:choose>
            <c:when test="${empty nombrePrograma}">
                <c:set var="error" value="Escriba el nombre del programa."/>
            </c:when>
            <c:otherwise>
                <c:set var="operacion" value="contarNombre"/>
                <%@ include file="/WEB-INF/modelo/programa.jspf" %>
                <c:choose>
                    <c:when test="${nombreRepetido.rows[0].total gt 0}">
                        <c:set var="error" value="Ya existe un programa con ese nombre."/>
                    </c:when>
                    <c:when test="${accion eq 'crear'}">
                        <c:set var="operacion" value="crear"/>
                        <%@ include file="/WEB-INF/modelo/programa.jspf" %>
                        <c:set var="mensaje" value="Programa creado."/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="operacion" value="renombrar"/>
                        <%@ include file="/WEB-INF/modelo/programa.jspf" %>
                        <c:set var="mensaje" value="${filasActualizadas gt 0 ? 'Programa actualizado.' : ''}"/>
                        <c:if test="${filasActualizadas eq 0}">
                            <c:set var="error" value="El programa no existe."/>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${accion eq 'eliminar'}">
        <c:set var="operacion" value="eliminar"/>
        <%@ include file="/WEB-INF/modelo/programa.jspf" %>
        <c:choose>
            <c:when test="${filasEliminadas gt 0}">
                <c:set var="mensaje" value="Programa eliminado."/>
            </c:when>
            <c:otherwise>
                <c:set var="error" value="El programa tiene estudiantes asignados."/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <c:set var="error" value="Acción no válida."/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/administrador/programas.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/administrador/programas.jsp"><c:param name="msg" value="${mensaje}"/></c:redirect>
    </c:otherwise>
</c:choose>
