<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: panel del comité. Recibe pendientes (inscripciones), ideasPendientes, conteoFase1 y conteoComite. --%>
<c:set var="tituloPagina" value="Panel del comité"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Panel del comité</h1>
<p class="text-muted">Bienvenido, <c:out value="${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}"/>.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<h2 class="h5 mt-4">Pendientes</h2>
<div class="row g-3">
    <div class="col-sm-6 col-lg-4">
        <a class="card shadow-sm h-100 text-decoration-none" href="<c:url value='/controlador/comite/inscripciones.jsp'/>">
            <div class="card-body">
                <div class="text-muted small">Inscripciones pendientes</div>
                <div class="display-6 fw-bold text-success"><c:out value="${pendientes.rows[0].total}"/></div>
                <div class="small">Revisar inscripciones de estudiantes &raquo;</div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-lg-4">
        <a class="card shadow-sm h-100 text-decoration-none" href="<c:url value='/controlador/comite/ideas.jsp'/>">
            <div class="card-body">
                <div class="text-muted small">Ideas pendientes</div>
                <div class="display-6 fw-bold text-success"><c:out value="${ideasPendientes.rows[0].total}"/></div>
                <div class="small">Revisar ideas propuestas &raquo;</div>
            </div>
        </a>
    </div>
    <c:url var="urlFase1" value="/controlador/comite/proyectos.jsp">
        <c:param name="fase" value="1"/><c:param name="estado" value="EN_CURSO"/>
    </c:url>
    <div class="col-sm-6 col-lg-4">
        <a class="card shadow-sm h-100 text-decoration-none" href="${urlFase1}">
            <div class="card-body">
                <div class="text-muted small">Soportes de pago pendientes</div>
                <div class="display-6 fw-bold text-success"><c:out value="${conteoFase1.rows[0].pagos_pendientes}"/></div>
                <div class="small">Revisar pagos de la fase 1 &raquo;</div>
            </div>
        </a>
    </div>
    <div class="col-sm-6 col-lg-4">
        <a class="card shadow-sm h-100 text-decoration-none" href="${urlFase1}">
            <div class="card-body">
                <div class="text-muted small">Proyectos sin director o evaluador</div>
                <div class="display-6 fw-bold text-success"><c:out value="${conteoFase1.rows[0].sin_docentes}"/></div>
                <div class="small">Asignar docentes &raquo;</div>
            </div>
        </a>
    </div>
    <c:url var="urlTurnoComite" value="/controlador/comite/proyectos.jsp">
        <c:param name="fase" value="3"/><c:param name="responsable" value="COMITE"/>
    </c:url>
    <div class="col-sm-6 col-lg-4">
        <a class="card shadow-sm h-100 text-decoration-none" href="${urlTurnoComite}">
            <div class="card-body">
                <div class="text-muted small">Anteproyectos por aprobar</div>
                <div class="display-6 fw-bold text-success"><c:out value="${conteoComite.rows[0].anteproyectos}"/></div>
                <div class="small">Decidir después del evaluador &raquo;</div>
            </div>
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
