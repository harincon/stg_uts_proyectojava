<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: lista de usuarios. Recibe listaUsuarios, totalFiltrado, filtroTexto, filtroRol, filtroActivo,
     pagina y totalPaginas. --%>
<c:set var="tituloPagina" value="Usuarios"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-3">
    <h1 class="h3 mb-0">Usuarios</h1>
    <a class="btn btn-success" href="<c:url value='/controlador/administrador/usuario_form.jsp'/>">
        <i class="bi bi-person-plus"></i> Crear cuenta
    </a>
</div>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>

<form class="row g-2 mb-3" method="get" action="<c:url value='/controlador/administrador/usuarios.jsp'/>">
    <div class="col-md-5">
        <input type="search" class="form-control" name="q" value="<c:out value='${filtroTexto}'/>"
               placeholder="Buscar por nombre, identificación o correo">
    </div>
    <div class="col-6 col-md-3">
        <select class="form-select" name="rol" aria-label="Filtrar por rol">
            <option value="">Todos los roles</option>
            <c:forEach var="r" items="${['ADMINISTRADOR','COMITE','DOCENTE','ESTUDIANTE']}">
                <option value="${r}" ${filtroRol eq r ? 'selected' : ''}><c:out value="${r}"/></option>
            </c:forEach>
        </select>
    </div>
    <div class="col-6 col-md-2">
        <select class="form-select" name="activo" aria-label="Filtrar por estado">
            <option value="">Todos</option>
            <option value="true" ${filtroActivo eq 'true' ? 'selected' : ''}>Activos</option>
            <option value="false" ${filtroActivo eq 'false' ? 'selected' : ''}>Inactivos</option>
        </select>
    </div>
    <div class="col-md-2">
        <button type="submit" class="btn btn-outline-success w-100"><i class="bi bi-search"></i> Buscar</button>
    </div>
</form>

<div class="table-responsive">
    <table class="table table-hover align-middle bg-white">
        <thead class="table-light">
            <tr>
                <th>Nombre</th><th>Identificación</th><th>Correo</th><th>Rol</th>
                <th>Programa / semestre / inscripción</th><th>Estado</th><th class="text-end">Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${listaUsuarios.rowCount eq 0}">
                <tr><td colspan="7" class="text-center text-muted">No hay usuarios con esos filtros.</td></tr>
            </c:if>
            <c:forEach var="u" items="${listaUsuarios.rows}">
                <tr>
                    <td><c:out value="${u.nombres} ${u.apellidos}"/></td>
                    <td><c:out value="${u.identificacion}"/></td>
                    <td><c:out value="${u.correo}"/></td>
                    <td><c:out value="${u.rol}"/></td>
                    <td>
                        <c:if test="${u.rol eq 'ESTUDIANTE'}">
                            <c:out value="${u.programa}"/> &middot; semestre <c:out value="${u.semestre}"/> &middot;
                            <span class="badge text-bg-light"><c:out value="${u.estado_inscripcion}"/></span>
                        </c:if>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${u.activo}"><span class="badge text-bg-success">Activo</span></c:when>
                            <c:otherwise><span class="badge text-bg-secondary">Inactivo</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-end text-nowrap">
                        <c:url var="urlEditar" value="/controlador/administrador/usuario_form.jsp">
                            <c:param name="id" value="${u.id_usuario}"/>
                        </c:url>
                        <a class="btn btn-sm btn-outline-primary" href="${urlEditar}" title="Editar"><i class="bi bi-pencil"></i></a>
                        <c:if test="${u.id_usuario ne sessionScope.usuario.id_usuario}">
                            <form class="d-inline" method="post" action="<c:url value='/controlador/administrador/usuario_guardar.jsp'/>"
                                  data-confirmar="${u.activo ? '¿Desactivar esta cuenta? La persona no podrá iniciar sesión.' : ''}">
                                <input type="hidden" name="id_usuario" value="${u.id_usuario}">
                                <input type="hidden" name="accion" value="${u.activo ? 'desactivar' : 'activar'}">
                                <button type="submit" class="btn btn-sm ${u.activo ? 'btn-outline-warning' : 'btn-outline-success'}"
                                        title="${u.activo ? 'Desactivar' : 'Activar'}">
                                    <i class="bi ${u.activo ? 'bi-person-dash' : 'bi-person-check'}"></i>
                                </button>
                            </form>
                            <form class="d-inline" method="post" action="<c:url value='/controlador/administrador/usuario_guardar.jsp'/>"
                                  data-confirmar="¿Eliminar definitivamente esta cuenta? Esta acción no se puede deshacer.">
                                <input type="hidden" name="id_usuario" value="${u.id_usuario}">
                                <input type="hidden" name="accion" value="eliminar">
                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar"><i class="bi bi-trash"></i></button>
                            </form>
                        </c:if>
                        <button type="button" class="btn btn-sm btn-outline-secondary" title="Restablecer contraseña"
                                data-bs-toggle="modal" data-bs-target="#modalRestablecer"
                                data-id="${u.id_usuario}" data-nombre="<c:out value='${u.nombres} ${u.apellidos}'/>">
                            <i class="bi bi-key"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<nav class="d-flex justify-content-between align-items-center" aria-label="Páginas">
    <span class="text-muted small">Página <c:out value="${pagina}"/> de <c:out value="${totalPaginas}"/>
        &middot; <c:out value="${totalFiltrado.rows[0].total}"/> usuarios</span>
    <div>
        <c:if test="${pagina gt 1}">
            <c:url var="urlAnterior" value="/controlador/administrador/usuarios.jsp">
                <c:param name="q" value="${filtroTexto}"/><c:param name="rol" value="${filtroRol}"/>
                <c:param name="activo" value="${filtroActivo}"/><c:param name="pagina" value="${pagina - 1}"/>
            </c:url>
            <a class="btn btn-sm btn-outline-secondary" href="${urlAnterior}">&laquo; Anterior</a>
        </c:if>
        <c:if test="${pagina lt totalPaginas}">
            <c:url var="urlSiguiente" value="/controlador/administrador/usuarios.jsp">
                <c:param name="q" value="${filtroTexto}"/><c:param name="rol" value="${filtroRol}"/>
                <c:param name="activo" value="${filtroActivo}"/><c:param name="pagina" value="${pagina + 1}"/>
            </c:url>
            <a class="btn btn-sm btn-outline-secondary" href="${urlSiguiente}">Siguiente &raquo;</a>
        </c:if>
    </div>
</nav>

<div class="modal fade" id="modalRestablecer" tabindex="-1" aria-labelledby="tituloRestablecer" aria-hidden="true">
    <div class="modal-dialog">
        <form class="modal-content" method="post" action="<c:url value='/controlador/administrador/usuario_guardar.jsp'/>"
              data-confirmar="¿Restablecer la contraseña de esta cuenta?">
            <div class="modal-header">
                <h2 class="modal-title h5" id="tituloRestablecer">Restablecer contraseña</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <p class="mb-2">Usuario: <strong id="nombreRestablecer"></strong></p>
                <input type="hidden" name="accion" value="restablecer">
                <input type="hidden" name="id_usuario" id="idRestablecer">
                <label class="form-label" for="claveRestablecer">Nueva contraseña</label>
                <input type="text" class="form-control" id="claveRestablecer" name="clave" required minlength="8">
                <div class="form-text">Mínimo 8 caracteres. Entréguela al usuario por fuera del sistema.</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Restablecer</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
