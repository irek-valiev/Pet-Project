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
    <title>Log in</title>
</head>
<body>

<sec:authorize access="isAuthenticated()">
    <% response.sendRedirect("/"); %>
</sec:authorize>
<div class="user-welcome user-options">
    <form action="${contextPath}/login" method="post">
        <h2>Авторизация</h2>
        <div class="">
            Login: admin, user<br/>
            Password: test<br/><br/>
            <div class="filter-select">
                <label for="usernameInput">Логин:</label>
                <input id="usernameInput" name="username" type="text" placeholder="Login" autofocus="true"/>
            </div>
            <div class="filter-select">
                <label for="passwordInput">Пароль:</label>
                <input id="passwordInput" name="password" type="password" placeholder="Password">
            </div>
            <div class="filter-select">
               <button class="button" type="submit">Войти</button>
               <a class="btn-link filter-select" href="${contextPath}/registration">Зарегистрироваться</a>
            </div>
        </div>
    </form>
</div>


</body>
</html>