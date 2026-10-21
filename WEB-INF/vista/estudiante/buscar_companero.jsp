<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- VISTA (JSON): sugerencias de compañero. Recibe sugerenciasCompanero (puede no existir: lista vacía).
     Solo envía nombre, identificación, programa y semestre. --%>
[<c:forEach var="s" items="${sugerenciasCompanero.rows}" varStatus="estado">${estado.first ? '' : ','}{"identificacion":"${fn:replace(fn:replace(s.identificacion, '\\', '\\\\'), '"', '\\"')}","nombre":"${fn:replace(fn:replace(s.nombre, '\\', '\\\\'), '"', '\\"')}","programa":"${fn:replace(fn:replace(s.programa, '\\', '\\\\'), '"', '\\"')}","semestre":${s.semestre}}</c:forEach>]
