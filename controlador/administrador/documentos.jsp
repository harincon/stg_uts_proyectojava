<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: gestión de la base documental --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="listarTodos"/>
<%@ include file="/WEB-INF/modelo/documento.jspf" %>

<jsp:forward page="/WEB-INF/vista/administrador/documentos.jsp"/>
