<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: formulario de usuario. Recibe rolesAsignables, programas y, al editar, usuarioObjetivo. --%>
<c:set var="editando" value="${not empty usuarioObjetivo and usuarioObjetivo.rowCount gt 0}"/>
<c:set var="u" value="${editando ? usuarioObjetivo.rows[0] : null}"/>
<c:set var="tituloPagina" value="${editando ? 'Editar usuario' : 'Crear cuenta'}"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <h1 class="h3"><c:out value="${tituloPagina}"/></h1>
        <%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
        <div class="card shadow-sm">
            <div class="card-body">
                <form method="post" action="<c:url value='/controlador/administrador/usuario_guardar.jsp'/>">
                    <input type="hidden" name="accion" value="${editando ? 'editar' : 'crear'}">
                    <c:if test="${editando}">
                        <input type="hidden" name="id_usuario" value="${u.id_usuario}">
                    </c:if>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label" for="nombres">Nombres</label>
                            <input type="text" class="form-control" id="nombres" name="nombres" required maxlength="100"
                                   value="<c:out value='${u.nombres}'/>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="apellidos">Apellidos</label>
                            <input type="text" class="form-control" id="apellidos" name="apellidos" required maxlength="100"
                                   value="<c:out value='${u.apellidos}'/>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="identificacion">Identificación</label>
                            <input type="text" class="form-control" id="identificacion" name="identificacion" required maxlength="20"
                                   value="<c:out value='${u.identificacion}'/>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" for="correo">Correo</label>
                            <input type="email" class="form-control" id="correo" name="correo" required maxlength="150"
                                   value="<c:out value='${u.correo}'/>">
                        </div>
                        <c:if test="${not editando}">
                            <div class="col-md-6">
                                <label class="form-label" for="clave">Contraseña inicial</label>
                                <input type="text" class="form-control" id="clave" name="clave" required minlength="8">
                                <div class="form-text">Mínimo 8 caracteres.</div>
                            </div>
                        </c:if>
                        <div class="col-md-6">
                            <label class="form-label" for="id_rol">Rol</label>
                            <c:choose>
                                <c:when test="${u.rol eq 'ADMINISTRADOR'}">
                                    <input type="text" class="form-control" value="ADMINISTRADOR" disabled>
                                    <input type="hidden" name="id_rol" value="${u.id_rol}">
                                </c:when>
                                <c:otherwise>
                                    <select class="form-select" id="id_rol" name="id_rol" required data-campos-estudiante="#camposEstudiante">
                                        <option value="">Seleccione…</option>
                                        <c:forEach var="r" items="${rolesAsignables.rows}">
                                            <option value="${r.id_rol}" data-rol="${r.nombre}" ${r.id_rol eq u.id_rol ? 'selected' : ''}>
                                                <c:out value="${r.nombre}"/>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="row g-3 mt-1" id="camposEstudiante">
                        <div class="col-md-8">
                            <label class="form-label" for="id_programa">Programa académico</label>
                            <select class="form-select" id="id_programa" name="id_programa">
                                <option value="">Seleccione…</option>
                                <c:forEach var="p" items="${programas.rows}">
                                    <option value="${p.id_programa}" ${p.id_programa eq u.id_programa ? 'selected' : ''}>
                                        <c:out value="${p.nombre}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label" for="semestre">Semestre</label>
                            <input type="number" class="form-control" id="semestre" name="semestre" min="1" max="10"
                                   value="<c:out value='${u.semestre}'/>">
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-4">
                        <button type="submit" class="btn btn-success">Guardar</button>
                        <a class="btn btn-outline-secondary" href="<c:url value='/controlador/administrador/usuarios.jsp'/>">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
