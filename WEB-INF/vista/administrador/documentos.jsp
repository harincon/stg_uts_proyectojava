<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: gestión de la base documental. Recibe documentos. --%>
<c:set var="tituloPagina" value="Base documental"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Base documental</h1>
<p class="text-muted">Enlaces al calendario académico, al reglamento y a las plantillas que ven todos los usuarios.</p>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<form class="row g-2 mb-4" method="post" action="<c:url value='/controlador/administrador/documento_guardar.jsp'/>">
    <input type="hidden" name="accion" value="crear">
    <div class="col-md-4">
        <input type="text" class="form-control" name="nombre" required maxlength="150" placeholder="Nombre visible">
    </div>
    <div class="col-md-6">
        <input type="url" class="form-control" name="url" required maxlength="500" placeholder="https://…">
    </div>
    <div class="col-md-2">
        <button type="submit" class="btn btn-success w-100"><i class="bi bi-plus-lg"></i> Agregar</button>
    </div>
</form>

<div class="table-responsive">
    <table class="table align-middle bg-white">
        <thead class="table-light">
            <tr><th>Nombre y URL</th><th>Estado</th><th class="text-end">Acciones</th></tr>
        </thead>
        <tbody>
            <c:forEach var="d" items="${documentos.rows}">
                <tr>
                    <td>
                        <form class="row g-2" method="post" action="<c:url value='/controlador/administrador/documento_guardar.jsp'/>">
                            <input type="hidden" name="accion" value="editar">
                            <input type="hidden" name="id_documento" value="${d.id_documento}">
                            <div class="col-md-5">
                                <input type="text" class="form-control form-control-sm" name="nombre" required maxlength="150"
                                       value="<c:out value='${d.nombre}'/>" aria-label="Nombre">
                            </div>
                            <div class="col-md-6">
                                <input type="url" class="form-control form-control-sm" name="url" required maxlength="500"
                                       value="<c:out value='${d.url}'/>" aria-label="URL">
                            </div>
                            <div class="col-md-1">
                                <button type="submit" class="btn btn-sm btn-outline-primary" title="Guardar"><i class="bi bi-check-lg"></i></button>
                            </div>
                        </form>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${d.activo}"><span class="badge text-bg-success">Visible</span></c:when>
                            <c:otherwise><span class="badge text-bg-secondary">Oculto</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-end text-nowrap">
                        <a class="btn btn-sm btn-outline-secondary" href="<c:out value='${d.url}'/>" target="_blank" rel="noopener"
                           title="Abrir"><i class="bi bi-box-arrow-up-right"></i></a>
                        <form class="d-inline" method="post" action="<c:url value='/controlador/administrador/documento_guardar.jsp'/>">
                            <input type="hidden" name="accion" value="${d.activo ? 'desactivar' : 'activar'}">
                            <input type="hidden" name="id_documento" value="${d.id_documento}">
                            <button type="submit" class="btn btn-sm ${d.activo ? 'btn-outline-warning' : 'btn-outline-success'}">
                                <c:out value="${d.activo ? 'Ocultar' : 'Mostrar'}"/>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
