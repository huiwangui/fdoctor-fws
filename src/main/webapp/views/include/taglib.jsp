<%@page import="com.boco.common.utils.PropertiesUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> --%>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<%
	String imgHeadUrl = PropertiesUtils.getValue("im_head_img_url_start");
%>

<c:set var="fws" value="${pageContext.request.contextPath}"/>
<c:set var="fwsStatic" value="${pageContext.request.contextPath}/statics/beginnerAdmin"/>

