<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: proyectos para el comité. Recibe listaProyectos, filtroBusqueda, filtroFase, filtroEstado y filtroResponsable. --%>
<c:set var="tituloPagina" value="Proyectos"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Proyectos</h1>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<form class="row g-2 mb-3" method="get" action="<c:url value='/controlador/comite/proyectos.jsp'/>">
    <div class="col-12">
        <input type="search" class="form-control" name="q" value="<c:out value='${filtroBusqueda}'/>" maxlength="100"
               placeholder="Buscar por estudiante (nombre o identificación), título o docente" aria-label="Buscar proyectos">
    </div>
    <div class="col-6 col-md-3">
        <select class="form-select" name="fase" aria-label="Fase">
            <option value="">Todas las fases</option>
            <c:forEach var="n" begin="1" end="6">
                <option value="${n}" ${filtroFase eq n ? 'selected' : ''}>Fase <c:out value="${n}"/></option>
            </c:forEach>
        </select>
    </div>
    <div class="col-6 col-md-3">
        <select class="form-select" name="estado" aria-label="Estado">
            <option value="">Todos los estados</option>
            <option value="EN_CURSO" ${filtroEstado eq 'EN_CURSO' ? 'selected' : ''}>En curso</option>
            <option value="FINALIZADO" ${filtroEstado eq 'FINALIZADO' ? 'selected' : ''}>Finalizados</option>
            <option value="RECHAZADO" ${filtroEstado eq 'RECHAZADO' ? 'selected' : ''}>Rechazados</option>
        </select>
    </div>
    <div class="col-6 col-md-3">
        <select class="form-select" name="responsable" aria-label="A quién le toca">
            <option value="">Cualquier turno</option>
            <c:forEach var="t" items="${['ESTUDIANTE','DIRECTOR','EVALUADOR','COMITE']}">
                <option value="${t}" ${filtroResponsable eq t ? 'selected' : ''}>Turno: <c:out value="${t}"/></option>
            </c:forEach>
        </select>
    </div>
    <div class="col-6 col-md-3">
        <button type="submit" class="btn btn-outline-success w-100"><i class="bi bi-funnel"></i> Filtrar</button>
    </div>
</form>

<div class="table-responsive">
    <table class="table table-hover align-middle bg-white">
        <thead class="table-light">
            <tr><th>Título</th><th>Estudiantes</th><th>Director</th><th>Evaluador</th><th>Situación</th><th></th></tr>
        </thead>
        <tbody>
            <c:if test="${listaProyectos.rowCount eq 0}">
                <tr><td colspan="6" class="text-center text-muted">No hay proyectos con esos filtros.</td></tr>
            </c:if>
            <c:forEach var="p" items="${listaProyectos.rows}">
                <c:set var="efFase" value="${p.id_fase}"/>
                <c:set var="efResponsable" value="${p.responsable_actual}"/>
                <c:set var="efEstado" value="${p.estado}"/>
                <tr>
                    <td><c:out value="${p.titulo}"/></td>
                    <td><c:out value="${p.estudiantes}"/></td>
                    <td><c:out value="${empty p.director ? 'Pendiente' : p.director}"/></td>
                    <td><c:out value="${empty p.evaluador ? 'Pendiente' : p.evaluador}"/></td>
                    <td><%@ include file="/WEB-INF/vista/plantilla/etiqueta_fase.jspf" %></td>
                    <td class="text-end">
                        <c:url var="urlGestionar" value="/controlador/comite/proyecto_gestionar.jsp">
                            <c:param name="id_proyecto" value="${p.id_proyecto}"/>
                        </c:url>
                        <a class="btn btn-sm btn-success" href="${urlGestionar}">Gestionar</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
