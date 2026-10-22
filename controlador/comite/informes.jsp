<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ include file="/WEB-INF/modelo/conexion.jspf" %>
<%-- CONTROLADOR: informes de estado del comité (por estudiante, por director, por evaluador y resumen) --%>
<c:set var="rolesPermitidos" value="COMITE"/>
<%@ include file="/WEB-INF/jspf/seguridad.jspf" %>

<c:set var="operacion" value="porEstudiante"/>
<%@ include file="/WEB-INF/modelo/informe.jspf" %>

<c:set var="operacion" value="porDocente"/>
<c:set var="funcionInforme" value="DIRECTOR"/>
<%@ include file="/WEB-INF/modelo/informe.jspf" %>
<c:set var="informeDirectores" value="${informeDocentes}" scope="request"/>
<c:set var="funcionInforme" value="EVALUADOR"/>
<%@ include file="/WEB-INF/modelo/informe.jspf" %>
<c:set var="informeEvaluadores" value="${informeDocentes}" scope="request"/>

<c:set var="operacion" value="resumenPorFase"/>
<%@ include file="/WEB-INF/modelo/informe.jspf" %>
<c:set var="operacion" value="resumenGeneral"/>
<%@ include file="/WEB-INF/modelo/informe.jspf" %>

<jsp:forward page="/WEB-INF/vista/comite/informes.jsp"/>
