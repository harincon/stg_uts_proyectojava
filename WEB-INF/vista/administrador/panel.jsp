<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: panel del administrador. Recibe conteoRoles y pendientes. --%>
<c:set var="tituloPagina" value="Panel del administrador"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Panel del administrador</h1>
<p class="text-muted">Bienvenido, <c:out value="${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}"/>.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<h2 class="h5 mt-4">Usuarios por rol</h2>
<div class="row g-3 mb-4">
    <c:forEach var="fila" items="${conteoRoles.rows}">
        <div class="col-6 col-lg-3">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <div class="text-muted small"><c:out value="${fila.rol}"/></div>
                    <div class="display-6 fw-bold"><c:out value="${fila.total}"/></div>
                    <div class="small">
                        <span class="text-success"><c:out value="${fila.activos}"/> activos</span> &middot;
                        <span class="text-secondary"><c:out value="${fila.inactivos}"/> inactivos</span>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<div class="card shadow-sm">
    <div class="card-body d-flex justify-content-between align-items-center flex-wrap gap-2">
        <div>
            <div class="text-muted small">Estudiantes con inscripción pendiente</div>
            <div class="h4 mb-0"><c:out value="${pendientes.rows[0].total}"/></div>
            <div class="small text-muted">La decisión le corresponde al comité.</div>
        </div>
        <a class="btn btn-success" href="<c:url value='/controlador/administrador/usuarios.jsp'/>">
            <i class="bi bi-people"></i> Gestionar usuarios
        </a>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
