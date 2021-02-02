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
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
    <title>Список пользователей</title>
</head>
<body>

<div class="result-items user-options" id="users">
    Пользователи:<br>
    <table>
        <tr>
            <td>Login</td>
            <td>Имя</td>
            <td>Фамилия</td>
            <td>Email</td>
            <td>Роль</td>
            <td></td>
            <td></td>

        </tr>
        <c:forEach var="user" items="${all_users}">
            <tr>
                <td><a href="/profile/${user.id}">${user.login}</a></td>
                <td>${user.firstName}</td>
                <td>${user.lastName}</td>
                <td>${user.email}</td>
                <td>${user.role.name}</td>
                <td><a href="/admin/users/${user.id}">Изменить</a></td>
                <td><a href="/admin/users/delete/${user.id}">Удалить</a></td>
            </tr>
        </c:forEach>
    </table>
    <br><a href="/admin">&larr; Назад</a>
</div>

</body>
</html>