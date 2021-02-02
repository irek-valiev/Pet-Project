<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
    <link href="${contextPath}/resources/css/pet_profile.css" rel="stylesheet"/>
    <title>Объявления о продаже питомцев</title>
</head>
<body>
<div class="result-items">
    <sec:authorize access="!isAuthenticated()">
            <% response.sendRedirect("/login"); %>
    </sec:authorize>

    <sec:authorize access="isAuthenticated()">

    <div class="sale-pet-table">
        <c:if test="${empty petsForSale}">
            <span>Нет животных на продажу</span>
        </c:if>

        <table>
            <tr>
                <th>Вид</th>
                <th>Имя питомца</th>
                <th>Пол питомца</th>
                <th>Цена</th>
                <th>Владелец</th>
                <th>Возможность</th>
            </tr>
            <c:forEach var="petForSale" items="${petsForSale}">
                <tr>
                    <td>${petForSale.pet.typePet.typeName}</td>
                    <td>${petForSale.pet.name}</td>
                    <td>${petForSale.pet.sex}</td>
                    <td>${petForSale.price}</td>
                    <td>${petForSale.oldOwner.login}</td>

                    <c:choose>
                        <c:when test="${petForSale.oldOwner.id == user.id}">
                            <td>
                                <form action="${contextPath}/user/pet_profile">
                                    <input type="hidden" name="id" value="${petForSale.pet.id}">
                                    <input type="submit" value="Профиль"/>
                                </form>
                            </td>
                        </c:when>
                        <c:when test="${petForSale.oldOwner.id != user.id}">
                            <td>
                                <form:form method="post"
                                           action="${contextPath}/user/sale_pets?sale_id=${petForSale.id}">
                                    <input type="submit" value="Купить"/>
                                </form:form>
                            </td>
                        </c:when>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
        <a href="/user/profile">
            <button type=button class="button btn_edit_profile">Мой профиль</button>
        </a>
    </div>
    </sec:authorize>
</body>
</html>
