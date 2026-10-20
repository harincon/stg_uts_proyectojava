<%@ page pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%-- CONTROLADOR: cierra la sesión y vuelve al inicio --%>
${pageContext.session.invalidate()}
<c:redirect url="/index.jsp"><c:param name="msg" value="Sesión cerrada."/></c:redirect>
