<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: base documental (todos los roles) --%>
<c:set var="rolesPermitidos" value="TODOS"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="listarActivos"/>
<%@ include file="/WEB-INF/modelo/documento.jspf" %>

<jsp:forward page="/WEB-INF/vista/comun/base_documental.jsp"/>
