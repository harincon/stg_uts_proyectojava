<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: acciones del administrador sobre usuarios.
     accion = crear | editar | activar | desactivar | eliminar | restablecer --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>
<c:if test="${pageContext.request.method ne 'POST'}">
    <c:redirect url="/controlador/administrador/usuarios.jsp"/>
</c:if>

<c:set var="accion" value="${param.accion}"/>
<c:catch var="errorNumero">
    <fmt:parseNumber var="idObjetivo" value="${param.id_usuario}" integerOnly="true"/>
    <fmt:parseNumber var="idRolNuevo" value="${param.id_rol}" integerOnly="true"/>
    <fmt:parseNumber var="idProgramaNuevo" value="${param.id_programa}" integerOnly="true"/>
    <fmt:parseNumber var="semestreNuevo" value="${param.semestre}" integerOnly="true"/>
</c:catch>
<c:if test="${empty idObjetivo}">
    <c:set var="idObjetivo" value="${0}"/>
</c:if>

<%-- El usuario sobre el que se actúa (editar y acciones de cuenta) --%>
<c:if test="${accion ne 'crear'}">
    <c:set var="operacion" value="obtener"/>
    <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
    <c:if test="${usuarioObjetivo.rowCount eq 0}">
        <c:redirect url="/controlador/administrador/usuarios.jsp"><c:param name="err" value="El usuario no existe."/></c:redirect>
    </c:if>
    <c:set var="objetivo" value="${usuarioObjetivo.rows[0]}"/>
</c:if>

<c:choose>
    <%-- ===== Crear o editar ===== --%>
    <c:when test="${accion eq 'crear' or accion eq 'editar'}">
        <c:set var="nombresNuevo" value="${fn:trim(param.nombres)}"/>
        <c:set var="apellidosNuevo" value="${fn:trim(param.apellidos)}"/>
        <c:set var="identificacionNueva" value="${fn:trim(param.identificacion)}"/>
        <c:set var="correoNuevo" value="${fn:toLowerCase(fn:trim(param.correo))}"/>
        <c:set var="claveNueva" value="${param.clave}"/>

        <%-- El rol del administrador no se cambia desde el formulario --%>
        <c:if test="${objetivo.rol eq 'ADMINISTRADOR'}">
            <c:set var="idRolNuevo" value="${objetivo.id_rol}"/>
        </c:if>
        <c:set var="operacion" value="obtener"/>
        <%@ include file="/WEB-INF/modelo/rol.jspf" %>
        <c:set var="rolNuevo" value="${rolBuscado.rowCount gt 0 ? rolBuscado.rows[0].nombre : ''}"/>

        <c:choose>
            <c:when test="${not empty errorNumero}">
                <c:set var="error" value="Los datos enviados no son válidos."/>
            </c:when>
            <c:when test="${empty nombresNuevo or empty apellidosNuevo or empty identificacionNueva or empty correoNuevo}">
                <c:set var="error" value="Nombres, apellidos, identificación y correo son obligatorios."/>
            </c:when>
            <c:when test="${not fn:contains(correoNuevo, '@')}">
                <c:set var="error" value="El correo no es válido."/>
            </c:when>
            <c:when test="${empty rolNuevo}">
                <c:set var="error" value="Seleccione un rol."/>
            </c:when>
            <c:when test="${rolNuevo eq 'ADMINISTRADOR' and objetivo.rol ne 'ADMINISTRADOR'}">
                <c:set var="error" value="El rol ADMINISTRADOR no se puede asignar."/>
            </c:when>
            <c:when test="${accion eq 'crear' and fn:length(claveNueva) lt 8}">
                <c:set var="error" value="La contraseña debe tener al menos 8 caracteres."/>
            </c:when>
            <c:when test="${accion eq 'editar' and objetivo.rol eq 'ESTUDIANTE' and rolNuevo ne 'ESTUDIANTE'}">
                <c:set var="error" value="El rol de un estudiante no se puede cambiar."/>
            </c:when>
            <c:when test="${accion eq 'editar' and objetivo.rol ne 'ESTUDIANTE' and rolNuevo eq 'ESTUDIANTE'}">
                <c:set var="error" value="Solo se puede cambiar el rol entre Docente y Comité."/>
            </c:when>
            <c:when test="${rolNuevo eq 'ESTUDIANTE' and (empty idProgramaNuevo or empty semestreNuevo or semestreNuevo lt 1 or semestreNuevo gt 10)}">
                <c:set var="error" value="Programa y semestre (1 a 10) son obligatorios para estudiantes."/>
            </c:when>
        </c:choose>

        <%-- Cambio de rol solo si la cuenta no tiene registros asociados --%>
        <c:if test="${empty error and accion eq 'editar' and objetivo.rol ne rolNuevo}">
            <c:set var="operacion" value="registrosAsociados"/>
            <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
            <c:if test="${asociados.rows[0].total gt 0}">
                <c:set var="error" value="No se puede cambiar el rol: la cuenta tiene registros asociados."/>
            </c:if>
        </c:if>

        <c:if test="${empty error}">
            <c:set var="operacion" value="contarDuplicados"/>
            <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
            <c:if test="${duplicados.rows[0].total gt 0}">
                <c:set var="error" value="Ya existe un usuario con ese correo o identificación."/>
            </c:if>
        </c:if>

        <c:if test="${empty error}">
            <c:catch var="errorGuardar">
                <sql:transaction>
                    <c:choose>
                        <c:when test="${accion eq 'crear'}">
                            <c:set var="operacion" value="crear"/>
                            <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                            <c:if test="${rolNuevo eq 'ESTUDIANTE'}">
                                <c:set var="idObjetivo" value="${usuarioCreado.rows[0].id_usuario}"/>
                                <c:set var="operacion" value="crearAprobado"/>
                                <%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:set var="operacion" value="actualizar"/>
                            <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                            <c:if test="${rolNuevo eq 'ESTUDIANTE'}">
                                <c:set var="operacion" value="actualizarPrograma"/>
                                <%@ include file="/WEB-INF/modelo/estudiante.jspf" %>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </sql:transaction>
            </c:catch>
            <c:if test="${not empty errorGuardar}">
                <c:set var="error" value="No fue posible guardar el usuario."/>
            </c:if>
        </c:if>

        <c:choose>
            <c:when test="${not empty error}">
                <c:redirect url="/controlador/administrador/usuario_form.jsp">
                    <c:if test="${accion eq 'editar'}"><c:param name="id" value="${idObjetivo}"/></c:if>
                    <c:param name="err" value="${error}"/>
                </c:redirect>
            </c:when>
            <c:otherwise>
                <c:redirect url="/controlador/administrador/usuarios.jsp"><c:param name="msg" value="Usuario guardado."/></c:redirect>
            </c:otherwise>
        </c:choose>
    </c:when>

    <%-- ===== Activar ===== --%>
    <c:when test="${accion eq 'activar'}">
        <c:set var="operacion" value="cambiarActivo"/>
        <c:set var="activoNuevo" value="true"/>
        <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
        <c:set var="mensaje" value="Usuario activado."/>
    </c:when>

    <%-- ===== Desactivar ===== --%>
    <c:when test="${accion eq 'desactivar'}">
        <c:choose>
            <c:when test="${idObjetivo eq sessionScope.usuario.id_usuario}">
                <c:set var="error" value="No puede desactivar su propia cuenta."/>
            </c:when>
            <c:otherwise>
                <c:set var="operacion" value="proyectosEnCurso"/>
                <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                <c:choose>
                    <c:when test="${proyectosEnCurso.rowCount gt 0}">
                        <c:forEach var="proyecto" items="${proyectosEnCurso.rows}" varStatus="estado">
                            <c:set var="titulos" value="${titulos}${estado.first ? '' : ', '}${proyecto.titulo}"/>
                        </c:forEach>
                        <c:set var="error" value="No se puede desactivar: el docente tiene proyectos en curso asignados: ${titulos}."/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="operacion" value="cambiarActivo"/>
                        <c:set var="activoNuevo" value="false"/>
                        <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                        <c:set var="mensaje" value="Usuario desactivado."/>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>

    <%-- ===== Eliminar ===== --%>
    <c:when test="${accion eq 'eliminar'}">
        <c:choose>
            <c:when test="${idObjetivo eq sessionScope.usuario.id_usuario}">
                <c:set var="error" value="No puede eliminar su propia cuenta."/>
            </c:when>
            <c:otherwise>
                <c:set var="operacion" value="registrosAsociados"/>
                <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                <c:choose>
                    <c:when test="${asociados.rows[0].total gt 0}">
                        <c:set var="error" value="La cuenta tiene registros asociados; desactívela en lugar de eliminarla."/>
                    </c:when>
                    <c:otherwise>
                        <sql:transaction>
                            <c:set var="operacion" value="eliminar"/>
                            <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                        </sql:transaction>
                        <c:set var="mensaje" value="Usuario eliminado."/>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>

    <%-- ===== Restablecer contraseña ===== --%>
    <c:when test="${accion eq 'restablecer'}">
        <c:choose>
            <c:when test="${fn:length(param.clave) lt 8}">
                <c:set var="error" value="La contraseña debe tener al menos 8 caracteres."/>
            </c:when>
            <c:otherwise>
                <c:set var="operacion" value="restablecerClave"/>
                <c:set var="claveNueva" value="${param.clave}"/>
                <%@ include file="/WEB-INF/modelo/usuario.jspf" %>
                <c:set var="mensaje" value="Contraseña restablecida."/>
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:otherwise>
        <c:set var="error" value="Acción no válida."/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${not empty error}">
        <c:redirect url="/controlador/administrador/usuarios.jsp"><c:param name="err" value="${error}"/></c:redirect>
    </c:when>
    <c:otherwise>
        <c:redirect url="/controlador/administrador/usuarios.jsp"><c:param name="msg" value="${mensaje}"/></c:redirect>
    </c:otherwise>
</c:choose>
