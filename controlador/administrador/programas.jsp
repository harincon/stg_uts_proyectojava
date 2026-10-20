<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: lista de programas académicos --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="listar"/>
<%@ include file="/WEB-INF/modelo/programa.jspf" %>

<jsp:forward page="/WEB-INF/vista/administrador/programas.jsp"/>
