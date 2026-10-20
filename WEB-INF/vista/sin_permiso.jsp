<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: acceso no autorizado. Recibe rutaPanel. --%>
<c:set var="tituloPagina" value="Acceso no autorizado"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<div class="text-center py-5">
    <i class="bi bi-shield-lock display-1 text-danger"></i>
    <h1 class="h3 mt-3">Acceso no autorizado</h1>
    <p class="text-muted">No tiene permiso para ver esta página.</p>
    <c:choose>
        <c:when test="${not empty sessionScope.usuario}">
            <a class="btn btn-success" href="<c:url value='${rutaPanel}'/>">Volver a mi panel</a>
        </c:when>
        <c:otherwise>
            <a class="btn btn-success" href="<c:url value='/index.jsp'/>">Ir al inicio</a>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
