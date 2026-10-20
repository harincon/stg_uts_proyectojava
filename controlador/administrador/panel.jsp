<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: panel del administrador (totales de usuarios) --%>
<c:set var="rolesPermitidos" value="ADMINISTRADOR"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="conteoPorRol"/>
<%@ include file="/WEB-INF/modelo/usuario.jspf" %>
<c:set var="operacion" value="contarPendientes"/>
<%@ include file="/WEB-INF/modelo/estudiante.jspf" %>

<jsp:forward page="/WEB-INF/vista/administrador/panel.jsp"/>
