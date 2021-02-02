<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <link href="${contextPath}/resources/css/style.css" rel="stylesheet"/>
    <title>Pet Project - Error Page</title>
</head>
<body>
<div class="error-container">
    <h3>Ошибка ${errorCode}</h3>
    <c:if test="${errorCode != '404'}">
        <img class="error-img" src="${contextPath}/resources/images/error.png" alt="error-on-page-pic"/>
    </c:if>

    <c:choose>
        <c:when test="${errorCode == '404'}">
            <img class="error-img" src="${contextPath}/resources/images/404.png" alt="page-not-found-pic"/>
            <h4>Страница не найдена</h4>
        </c:when>
        <c:when test="${errorCode == '400'}">
            <h4>Bad Request</h4>
        </c:when>
        <c:when test="${errorCode == '401'}">
            <h4>Unauthorized</h4>
        </c:when>
        <c:when test="${errorCode == '403'}">
            <h4>Нет доступа</h4>
        </c:when>
        <c:when test="${errorCode == '500'}">
            <h4>Внутренняя ошибка сервера</h4>
        </c:when>
    </c:choose>

</div>
</body>
</html>
