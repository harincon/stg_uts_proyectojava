<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: registrar el proyecto con la idea elegida. Recibe ideaElegida y urlBuscarCompanero. --%>
<c:set var="idea" value="${ideaElegida.rows[0]}"/>
<c:set var="tituloPagina" value="Registrar mi proyecto"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <h1 class="h3">Registrar mi proyecto</h1>
        <%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

        <div class="card shadow-sm mb-3">
            <div class="card-body">
                <h2 class="h5 mb-1"><c:out value="${idea.titulo}"/></h2>
                <p class="small text-muted mb-2">Idea de <c:out value="${idea.autor}"/></p>
                <p class="small mb-1"><strong>Objetivo:</strong> <c:out value="${idea.objetivo}"/></p>
                <p class="small mb-0"><strong>Problemática:</strong> <c:out value="${idea.problematica}"/></p>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <form method="post" action="<c:url value='/controlador/estudiante/proyecto_crear.jsp'/>">
                    <input type="hidden" name="id_idea" value="${idea.id_idea}">
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" role="switch" id="con_companero" name="con_companero"
                               value="SI" data-activa="#bloqueCompanero">
                        <label class="form-check-label" for="con_companero">Trabajaré con un compañero</label>
                    </div>
                    <div id="bloqueCompanero" class="mb-3 d-none">
                        <label class="form-label" for="identificacion_companero">Identificación del compañero</label>
                        <div class="position-relative">
                            <input type="text" class="form-control" id="identificacion_companero" name="identificacion_companero"
                                   inputmode="numeric" maxlength="15" autocomplete="off" disabled
                                   placeholder="Escriba la cédula de su compañero"
                                   data-buscar-companero="${urlBuscarCompanero}" data-sugerencias="#sugerenciasCompanero"
                                   data-tarjeta="#tarjetaCompanero">
                            <div id="sugerenciasCompanero" class="list-group position-absolute w-100 shadow-sm sugerencias"></div>
                        </div>
                        <div class="form-text">Escriba al menos 5 dígitos para ver sugerencias. Solo aparecen estudiantes aprobados
                            que no tienen un proyecto en curso.</div>
                        <div id="tarjetaCompanero" class="card border-success mt-2 d-none">
                            <div class="card-body py-2 small">
                                <div class="fw-semibold" data-campo="nombre"></div>
                                <div class="text-muted">Identificación <span data-campo="identificacion"></span> &middot;
                                    <span data-campo="programa"></span> &middot; semestre <span data-campo="semestre"></span></div>
                            </div>
                        </div>
                        <div class="form-text">Usted quedará como estudiante responsable: hará las entregas y su compañero podrá consultar.</div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success">Registrar proyecto</button>
                        <a class="btn btn-outline-secondary" href="<c:url value='/controlador/comun/banco_ideas.jsp'/>">Volver al banco</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
