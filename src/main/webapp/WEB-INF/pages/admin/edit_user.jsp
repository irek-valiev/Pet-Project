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
    <title>Редактирование профиля юзера</title>
</head>
<body>
<div class="user-options">
    <form:form method="post" action="/admin/users" modelAttribute="edit_user">
        <div>
            <form:input path="id" type="hidden"/>
        </div>
        <div>
            Имя: <form:input path="firstName" type="text" placeholder="First Name"/>
            <form:errors path="firstName"/>
        </div>
        <div>
            Фамилия: <form:input path="lastName" type="text" placeholder="Last Name"/>
            <form:errors path="lastName"/>
        </div>
        <div>
            Email: <form:input path="email" type="text" placeholder="Email"/>
            <form:errors path="email"/>
        </div>

        <div>
            <form:radiobuttons path="role" items="${all_roles}" itemLabel="name"/>
        </div>

        <br><br>
        <button type="submit">Сохранить изменения</button>
    </form:form>
    <br><a href="/admin/users">&larr; Назад</a>
</div>
</body>
</html>