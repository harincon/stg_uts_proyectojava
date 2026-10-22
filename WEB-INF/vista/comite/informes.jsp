<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: informes de estado del comité. Recibe informeEstudiantes, informeDirectores, informeEvaluadores,
     resumenFases y resumenGeneral. --%>
<c:set var="tituloPagina" value="Informes de estado"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<jsp:useBean id="ahora" class="java.util.Date"/>

<div class="d-flex flex-wrap justify-content-between align-items-start gap-2 mb-3">
    <div>
        <h1 class="h3 mb-0">Informes de estado</h1>
        <p class="text-muted small mb-0">Generado el <fmt:formatDate value="${ahora}" pattern="dd/MM/yyyy 'a las' HH:mm"/></p>
    </div>
    <button type="button" class="btn btn-outline-success no-imprimir" data-imprimir><i class="bi bi-printer"></i> Imprimir</button>
</div>

<nav class="nav nav-pills small mb-4 no-imprimir">
    <a class="nav-link" href="#informe-estudiantes">Por estudiante</a>
    <a class="nav-link" href="#informe-directores">Por director</a>
    <a class="nav-link" href="#informe-evaluadores">Por evaluador</a>
    <a class="nav-link" href="#informe-resumen">Resumen</a>
</nav>

<section id="informe-estudiantes" class="informe-seccion mb-5">
    <h2 class="h5">Por estudiante</h2>
    <div class="table-responsive">
        <table class="table table-sm table-bordered bg-white">
            <thead class="table-light">
                <tr><th>Estudiante</th><th>Identificación</th><th>Programa</th><th>Proyecto</th><th class="col-situacion">Situación</th></tr>
            </thead>
            <tbody>
                <c:if test="${informeEstudiantes.rowCount eq 0}">
                    <tr><td colspan="5" class="text-center text-muted">No hay estudiantes con inscripción aprobada.</td></tr>
                </c:if>
                <c:forEach var="r" items="${informeEstudiantes.rows}">
                    <tr>
                        <td><c:out value="${r.nombre}"/></td>
                        <td><c:out value="${r.identificacion}"/></td>
                        <td><c:out value="${r.programa}"/> &middot; semestre <c:out value="${r.semestre}"/></td>
                        <c:choose>
                            <c:when test="${empty r.id_proyecto}">
                                <td colspan="2" class="text-muted">Sin proyecto</td>
                            </c:when>
                            <c:otherwise>
                                <c:set var="efFase" value="${r.id_fase}"/>
                                <c:set var="efResponsable" value="${r.responsable_actual}"/>
                                <c:set var="efEstado" value="${r.estado}"/>
                                <td><c:out value="${r.titulo}"/></td>
                                <td><%@ include file="/WEB-INF/vista/plantilla/etiqueta_fase.jspf" %></td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<section id="informe-directores" class="informe-seccion mb-5">
    <h2 class="h5">Por director</h2>
    <c:set var="filasDocentes" value="${informeDirectores}"/>
    <c:set var="textoSinProyectos" value="No dirige proyectos."/>
    <%@ include file="/WEB-INF/vista/comite/informe_docentes.jspf" %>
</section>

<section id="informe-evaluadores" class="informe-seccion mb-5">
    <h2 class="h5">Por evaluador</h2>
    <c:set var="filasDocentes" value="${informeEvaluadores}"/>
    <c:set var="textoSinProyectos" value="No evalúa proyectos."/>
    <%@ include file="/WEB-INF/vista/comite/informe_docentes.jspf" %>
</section>

<section id="informe-resumen" class="informe-seccion">
    <h2 class="h5">Resumen general</h2>
    <c:set var="rg" value="${resumenGeneral.rows[0]}"/>
    <div class="row g-3">
        <div class="col-md-6">
            <table class="table table-sm table-bordered bg-white">
                <thead class="table-light"><tr><th>Proyectos en curso por fase</th><th class="text-end">Cantidad</th></tr></thead>
                <tbody>
                    <c:forEach var="f" items="${resumenFases.rows}">
                        <tr><td>Fase <c:out value="${f.id_fase}"/>: <c:out value="${f.nombre}"/></td><td class="text-end" id="total-fase-${f.id_fase}">${f.total}</td></tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="col-md-6">
            <table class="table table-sm table-bordered bg-white">
                <thead class="table-light"><tr><th>Proyectos por estado</th><th class="text-end">Cantidad</th></tr></thead>
                <tbody>
                    <tr><td>En curso</td><td class="text-end" id="total-EN_CURSO">${rg.en_curso}</td></tr>
                    <tr><td>Finalizados</td><td class="text-end" id="total-FINALIZADO">${rg.finalizados}</td></tr>
                    <tr><td>Rechazados</td><td class="text-end" id="total-RECHAZADO">${rg.rechazados}</td></tr>
                    <tr class="table-light"><th>Estudiantes vinculados a proyectos en curso</th><th class="text-end" id="total-vinculados">${rg.vinculados}</th></tr>
                </tbody>
            </table>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
