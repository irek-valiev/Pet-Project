<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
    <title>Pet Project - История ${pet.name}</title>
</head>
<body>
<div class="result-items user-options">
    <div class="filter-select">
        <label for="pet-sale-story">История питомца ${pet.name}:</label>
        <table id="pet-sale-story">
            <tr>
                <td>Предыдущий владелец</td>
                <td>Цена</td>
                <td>Дата покупки</td>
            </tr>
            <c:forEach var="sale" items="${listOfSales}">
                <tr>
                    <td>${sale.oldOwner.login}</td>
                    <td>${sale.price}</td>
                    <td><fmt:formatDate pattern="dd/MM/yyyy" value="${sale.dateSale}"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="filter-select">
        <label>Текущий владелец: <a href="/profile/${pet.user.id}">${pet.user.login}</a></label>
    </div>
    <div class="filter-select">
        <button class="button" type="button" onclick="location.href='${contextPath}/user/pet_profile?id=${pet.id}'">Назад к профилю
            питомца
        </button>
    </div>
</div>
</body>
</html>
