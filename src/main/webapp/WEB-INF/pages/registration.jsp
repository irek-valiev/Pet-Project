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
    <title>Регистрация</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
</head>
<body>

<div class="user-welcome user-options">
    <form:form method="post" modelAttribute="userForm">
        <h2>Регистрация</h2>
        <div class="filter-select">
            <form:input type="text" path="login" placeholder="Login" autofocus="true"/>
            <form:errors path="username"></form:errors>
        </div>

        <div class="filter-select">
            <form:input path="password" type="password" placeholder="Password"/>
            <form:errors path="password"></form:errors>
        </div>
        <div class="filter-select">
            <form:input path="confirmPassword" type="password" placeholder="Confirm your password"/>
            <form:errors path="confirmPassword"></form:errors>
        </div>

        <div class="filter-select">
            <form:input path="firstName" type="text" placeholder="First Name"/>
            <form:errors path="firstName"></form:errors>
        </div>
        <div class="filter-select">
            <form:input path="lastName" type="text" placeholder="Last Name"/>
            <form:errors path="lastName"></form:errors>
        </div>
        <div class="filter-select">
            <form:input path="email" type="text" placeholder="Email"/>
            <form:errors path="email"></form:errors>
        </div>
        <div class="filter-select">
            <button class="button" type="submit">Зарегистрироваться</button>
        </div>
    </form:form>
</div>

</body>
</html>
