<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: revisión del director o del evaluador. Recibe revisionDocente, los datos de la ficha y,
     para el evaluador del informe final, rejilla. La decisión sale dentro de la carta de la fase actual. --%>
<c:set var="rv" value="${revisionDocente.rows[0]}"/>
<c:set var="tituloPagina" value="Revisar documento"/>
<c:set var="volverA" value="${rv.funcion eq 'DIRECTOR' ? '/controlador/docente/director.jsp' : '/controlador/docente/evaluador.jsp'}"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
<c:set var="nombreDocumento" value="${rv.tipo_documento eq 'F-DC-124' ? 'Anteproyecto (F-DC-124)' : 'Informe final (F-DC-125)'}"/>
<c:set var="enTurno" value="${rv.estado eq 'PENDIENTE_REVISION' and ficha.rows[0].estado eq 'EN_CURSO'
                             and ficha.rows[0].responsable_actual eq rv.funcion}"/>

<div class="card shadow-sm border-success mb-3">
    <div class="card-body">
        <div class="small text-muted">Revisión como <c:out value="${rv.funcion eq 'DIRECTOR' ? 'director' : 'evaluador'}"/></div>
        <h1 class="h4"><c:out value="${nombreDocumento}"/> &middot; versión <c:out value="${rv.version}"/></h1>
        <a class="btn btn-outline-success" href="<c:out value='${rv.url}'/>" target="_blank" rel="noopener">
            <i class="bi bi-box-arrow-up-right"></i> Abrir el documento: <c:out value="${rv.url}"/>
        </a>
        <c:if test="${enTurno}">
            <p class="small text-muted mt-2 mb-0"><i class="bi bi-arrow-down"></i> Registre su decisión en la carta de la fase actual.</p>
        </c:if>
    </div>
</div>

<c:if test="${not enTurno}">
    <div class="alert alert-info">Esta revisión ya fue resuelta o no es su turno de revisar.</div>
</c:if>

<c:set var="accionesFicha" value="DOCENTE"/>
<%@ include file="/WEB-INF/vista/comun/ficha_proyecto.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
