<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: ficha de seguimiento del proyecto. Recibe los datos de cargar_ficha.jspf (incluido esResponsable). --%>
<c:set var="tituloPagina" value="Seguimiento del proyecto"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>
<%@ include file="/WEB-INF/vista/plantilla/mensajes.jspf" %>
<c:set var="fp" value="${ficha.rows[0]}"/>

<c:if test="${sessionScope.usuario.rol eq 'COMITE'}">
    <c:url var="urlGestionar" value="/controlador/comite/proyecto_gestionar.jsp">
        <c:param name="id_proyecto" value="${fp.id_proyecto}"/>
    </c:url>
    <div class="text-end mb-2">
        <a class="btn btn-success" href="${urlGestionar}"><i class="bi bi-gear"></i> Gestionar</a>
    </div>
</c:if>

<c:if test="${esResponsable and fp.estado eq 'EN_CURSO' and fp.responsable_actual eq 'ESTUDIANTE'
              and (fp.id_fase eq 1 or fp.id_fase eq 2 or fp.id_fase eq 4)}">
    <div class="card shadow-sm border-success mb-3">
        <div class="card-body">
            <h2 class="h5">
                <c:choose>
                    <c:when test="${fp.id_fase eq 1}">Registrar URL del soporte de pago</c:when>
                    <c:when test="${fp.id_fase eq 2}">Registrar URL del anteproyecto (F-DC-124)</c:when>
                    <c:otherwise>Registrar URL del informe final (F-DC-125)</c:otherwise>
                </c:choose>
            </h2>
            <form class="row g-2" method="post" action="<c:url value='/controlador/estudiante/entrega_guardar.jsp'/>">
                <input type="hidden" name="id_proyecto" value="${fp.id_proyecto}">
                <div class="col-md-9">
                    <input type="url" class="form-control" name="url" required maxlength="500" placeholder="https://…"
                           aria-label="URL del documento">
                    <div class="form-text">El enlace debe permitir el acceso de lectura a los revisores.</div>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-success w-100"><i class="bi bi-upload"></i> Registrar</button>
                </div>
            </form>
        </div>
    </div>
</c:if>

<%@ include file="/WEB-INF/vista/comun/ficha_proyecto.jspf" %>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
