<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: página de inicio. Recibe fases, errorBD, modoDemo y, en modo demostración, usuariosPrueba. --%>
<c:set var="tituloPagina" value="Inicio - Trabajos de Grado UTS"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<section class="portada p-4 p-md-5 mb-4">
    <div class="portada-contenido">
        <span class="portada-etiqueta">Unidades Tecnológicas de Santander</span>
        <h1 class="fw-bold">Sistema de Gestión de Trabajos de Grado</h1>
        <p class="lead mb-0">Inscripción, banco de ideas y seguimiento del trabajo de grado
            desde el anteproyecto hasta el cierre.</p>
    </div>
</section>

<div class="row g-4">
    <div class="col-lg-7">
        <h2 class="h4 mb-3">Las seis fases del trabajo de grado</h2>
        <c:choose>
            <c:when test="${not empty errorBD}">
                <div class="alert alert-warning">No fue posible conectar con la base de datos.</div>
            </c:when>
            <c:otherwise>
                <ul class="list-group">
                    <c:forEach var="fase" items="${fases.rows}">
                        <li class="list-group-item d-flex gap-3 align-items-start">
                            <span class="fase-numero"><c:out value="${fase.id_fase}"/></span>
                            <div>
                                <div class="fw-semibold"><c:out value="${fase.nombre}"/></div>
                                <small class="text-muted"><c:out value="${fase.descripcion}"/></small>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="col-lg-5">
        <div class="card shadow-sm">
            <div class="card-body p-4">
                <h2 class="h4 mb-3"><i class="bi bi-box-arrow-in-right"></i> Iniciar sesión</h2>
                <%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
                <form method="post" action="<c:url value='/controlador/acceso.jsp'/>">
                    <div class="mb-3">
                        <label class="form-label" for="correo">Correo</label>
                        <input type="email" class="form-control" id="correo" name="correo" required
                               placeholder="usuario@uts.edu.co">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="clave">Contraseña</label>
                        <input type="password" class="form-control" id="clave" name="clave" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Ingresar</button>
                </form>
                <p class="text-center small mt-3 mb-0">¿Es estudiante y no tiene cuenta?
                    <a href="<c:url value='/controlador/registro.jsp'/>">Registrarse</a></p>
                <c:if test="${modoDemo}">
                    <button type="button" class="btn btn-outline-secondary w-100 mt-3"
                            data-bs-toggle="modal" data-bs-target="#modalUsuariosPrueba">
                        <i class="bi bi-people"></i> Usuarios de prueba
                    </button>
                </c:if>
            </div>
        </div>
    </div>
</div>

<c:if test="${modoDemo}">
<div class="modal fade" id="modalUsuariosPrueba" tabindex="-1" aria-labelledby="tituloUsuariosPrueba" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title h5" id="tituloUsuariosPrueba">Usuarios de prueba</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-sm table-striped align-middle">
                        <thead>
                            <tr><th>Rol</th><th>Nombre</th><th>Correo</th><th>Contraseña</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${usuariosPrueba.rows}">
                                <tr>
                                    <td><c:out value="${u.rol}"/></td>
                                    <td><c:out value="${u.nombre}"/></td>
                                    <td><c:out value="${u.correo}"/></td>
                                    <td><code><c:out value="${u.rol eq 'ADMINISTRADOR' ? 'Admin123' : 'Clave123'}"/></code></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
