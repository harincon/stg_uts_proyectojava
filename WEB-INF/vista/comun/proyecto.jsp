<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: ficha de seguimiento del proyecto. Recibe los datos de cargar_ficha.jspf (incluido esResponsable).
     El formulario de entrega del estudiante sale dentro de la carta de la fase actual. --%>
<c:set var="tituloPagina" value="Seguimiento del proyecto"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
<c:set var="fp" value="${ficha.rows[0]}"/>

<c:if test="${sessionScope.usuario.rol eq 'COMITE'}">
    <c:url var="urlGestionar" value="/controlador/comite/proyecto_gestionar.jsp">
        <c:param name="id_proyecto" value="${fp.id_proyecto}"/>
    </c:url>
    <div class="text-end mb-2">
        <a class="btn btn-success" href="${urlGestionar}"><i class="bi bi-gear"></i> Gestionar</a>
    </div>
</c:if>

<c:if test="${sessionScope.usuario.rol eq 'ESTUDIANTE'}">
    <c:set var="accionesFicha" value="ESTUDIANTE"/>
</c:if>
<%@ include file="/WEB-INF/vista/comun/ficha_proyecto.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
