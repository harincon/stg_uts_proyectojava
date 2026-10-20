<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: programas académicos. Recibe programas. --%>
<c:set var="tituloPagina" value="Programas académicos"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Programas académicos</h1>
<p class="text-muted">Programas que el estudiante elige al registrarse.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<form class="row g-2 mb-4" method="post" action="<c:url value='/controlador/administrador/programa_guardar.jsp'/>">
    <input type="hidden" name="accion" value="crear">
    <div class="col-md-9">
        <input type="text" class="form-control" name="nombre" required maxlength="150" placeholder="Nombre del nuevo programa">
    </div>
    <div class="col-md-3">
        <button type="submit" class="btn btn-success w-100"><i class="bi bi-plus-lg"></i> Crear programa</button>
    </div>
</form>

<div class="table-responsive">
    <table class="table align-middle bg-white">
        <thead class="table-light">
            <tr><th>Nombre</th><th class="text-center">Estudiantes</th><th class="text-end">Acciones</th></tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${programas.rows}">
                <tr>
                    <td>
                        <form class="d-flex gap-2" method="post" action="<c:url value='/controlador/administrador/programa_guardar.jsp'/>">
                            <input type="hidden" name="accion" value="editar">
                            <input type="hidden" name="id_programa" value="${p.id_programa}">
                            <input type="text" class="form-control form-control-sm" name="nombre" required maxlength="150"
                                   value="<c:out value='${p.nombre}'/>" aria-label="Nombre del programa">
                            <button type="submit" class="btn btn-sm btn-outline-primary" title="Guardar nombre"><i class="bi bi-check-lg"></i></button>
                        </form>
                    </td>
                    <td class="text-center"><c:out value="${p.total_estudiantes}"/></td>
                    <td class="text-end">
                        <c:if test="${p.total_estudiantes eq 0}">
                            <form class="d-inline" method="post" action="<c:url value='/controlador/administrador/programa_guardar.jsp'/>"
                                  data-confirmar="¿Eliminar este programa?">
                                <input type="hidden" name="accion" value="eliminar">
                                <input type="hidden" name="id_programa" value="${p.id_programa}">
                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar"><i class="bi bi-trash"></i></button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
