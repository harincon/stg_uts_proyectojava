<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- VISTA: base documental. Recibe documentos. --%>
<c:set var="tituloPagina" value="Base documental"/>
<%@ include file="/WEB-INF/vista/plantilla/cabecera.jspf" %>

<h1 class="h3">Base documental</h1>
<p class="text-muted">Calendario académico, reglamento y plantillas de los formatos de trabajo de grado.</p>

<c:choose>
    <c:when test="${documentos.rowCount eq 0}">
        <div class="alert alert-info">No hay documentos publicados.</div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <c:forEach var="doc" items="${documentos.rows}">
                <div class="col-sm-6 col-lg-4">
                    <a class="btn btn-outline-success w-100 text-start p-3" href="<c:out value='${doc.url}'/>"
                       target="_blank" rel="noopener">
                        <i class="bi bi-file-earmark-text"></i> <c:out value="${doc.nombre}"/>
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/vista/plantilla/pie.jspf" %>
