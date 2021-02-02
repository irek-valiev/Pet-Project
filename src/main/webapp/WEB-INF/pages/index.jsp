<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Pet Project - главная</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
</head>
<body>

<div class="user-welcome">
    <div class="project-info">
        <h1>Pet Project</h1>
        <h2>Социальная сеть для ваших питомцев</h2>
    </div>

    <div class="user-options">
        <sec:authorize access="!isAuthenticated()">
            <div class="vertical-containers">
                <h3>Здравствуйте, гость!</h3>
                <a class="btn-link filter-select" href="${contextPath}/login">Войти</a>
                <a class="btn-link filter-select" href="${contextPath}/registration">Зарегистрироваться</a>
            </div>
            </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <div class="vertical-containers">
                <h3>Здравствуйте, ${pageContext.request.userPrincipal.name}!</h3>
                <a class="btn-link filter-select" href="${contextPath}/user/profile">Профиль</a>
                <a class="btn-link filter-select" href="${contextPath}/logout">Выйти</a>

                <sec:authorize access="hasAuthority('ROLE_ADMIN')">
                    <a class="btn-link filter-select" href="${contextPath}/admin">Панель администратора</a>
                </sec:authorize>
            </div>
        </sec:authorize>
    </div>
</div>

<div class="vertical-containers">
    <div class="search-field" id="search">
        <form:form action="/" method="get" class="search-form">
            <div class="filter-select" id="nameText">
                <label for="name-input-field"></label>
                <input id="name-input-field" name="name" type="text" placeholder="Кличка">
            </div>
            <div class="filter-select" id="sexSelect">
                <label for="sex-input-field">Пол:</label>
                <select id="sex-input-field" name="sex">
                    <option selected></option>
                    <option>MALE</option>
                    <option>FEMALE</option>
                </select>
            </div>

            <div class="filter-select" id="typeSelect">
                <label for="type-input-field">Тип:</label>
                <select id="type-input-field" name="type">
                    <option selected></option>
                    <c:forEach items="${listTypes}" var="TypePet">
                        <option value="${TypePet.typeName}">${TypePet.typeName}</option>
                    </c:forEach>
                </select>
            </div>
            <div id="buttonSearch">
                <button class="button" type="submit">Поиск</button>
            </div>
        </form:form>
    </div>

    <div class="result-items" id="result">
        <div id="textResult">
            <span>Результаты поиска</span>
        </div>
        <div id="resultTable">
            <table>
                <tr>
                    <td>Владелец</td>
                    <td>Порода</td>
                    <td>Кличка</td>
                    <td>Дата рождения</td>
                    <td>Картинка</td>
                    <sec:authorize access="isAuthenticated()">
                        <td>Профиль</td>
                    </sec:authorize>
                </tr>
                <c:forEach var="pet" items="${pets}">

                    <tr>
                        <td><a href="/profile/${pet.user.id}">${pet.user.login}</a></td>
                        <td><c:out value="${pet.typePet.typeName}"/></td>
                        <td><c:out value="${pet.name}"/></td>
                        <td><c:out value="${pet.birthday}"/></td>
                        <td align="center"><img src="/pet_image?id=${pet.id}" width="100" height="100"/>
                        <sec:authorize access="isAuthenticated()">
                            <td><a href="${contextPath}/user/pet_profile?id=${pet.id}">ссылка</a></td>
                        </sec:authorize>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>
