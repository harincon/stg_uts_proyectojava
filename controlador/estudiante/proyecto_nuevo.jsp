<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: formulario para registrar el proyecto con la idea elegida del banco --%>
<c:set var="rolesPermitidos" value="ESTUDIANTE"/>
<c:set var="requiereAprobado" value="true"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:catch>
    <fmt:parseNumber var="idIdeaObjetivo" value="${param.id_idea}" integerOnly="true"/>
</c:catch>
<c:if test="${not empty idIdeaObjetivo}">
    <c:set var="operacion" value="consultarIdea"/>
    <%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
</c:if>
<c:set var="idea" value="${ideaElegida.rowCount gt 0 ? ideaElegida.rows[0] : null}"/>
<c:if test="${empty idea or idea.estado ne 'APROBADO' or not idea.disponible
              or (idea.tipo_autor ne 'DOCENTE' and idea.id_autor ne sessionScope.usuario.id_usuario)}">
    <c:redirect url="/controlador/comun/banco_ideas.jsp"><c:param name="err" value="La idea ya no está disponible."/></c:redirect>
</c:if>

<c:set var="operacion" value="enCursoDeEstudiante"/>
<c:set var="idEstudianteBuscado" value="${sessionScope.usuario.id_estudiante}"/>
<%@ include file="/WEB-INF/modelo/proyecto.jspf" %>
<c:if test="${enCurso.rows[0].total gt 0}">
    <c:redirect url="/controlador/estudiante/panel.jsp"><c:param name="err" value="Ya tiene un proyecto en curso."/></c:redirect>
</c:if>


<c:url var="urlBuscarCompanero" value="/controlador/estudiante/buscar_companero.jsp" scope="request"/>
<jsp:forward page="/WEB-INF/vista/estudiante/proyecto_nuevo.jsp"/>
