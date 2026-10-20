<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<c:set var="tituloPagina" value="Inicio - Trabajos de Grado UTS"/>
<c:catch var="errorBD">
    <sql:query var="fases">
        SELECT id_fase, nombre, descripcion FROM fases ORDER BY id_fase
    </sql:query>
</c:catch>
<%@ include file="/WEB-INF/jspf/cabecera.jspf" %>

<section class="portada p-4 p-md-5 mb-4">
    <h1 class="fw-bold">Sistema de Gestión de Trabajos de Grado</h1>
    <p class="lead mb-0">Unidades Tecnológicas de Santander. Inscripción, banco de ideas y seguimiento
        del trabajo de grado desde el anteproyecto hasta el cierre.</p>
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
                <%@ include file="/WEB-INF/jspf/mensajes.jspf" %>
                <form method="post" action="<c:url value='/acceso.jsp'/>">
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
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/pie.jspf" %>
