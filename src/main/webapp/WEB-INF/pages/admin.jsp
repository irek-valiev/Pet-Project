<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Панель администратора</title>
</head>
<body>

<div class="user-options">
    <a href="/admin/users">Список пользователей</a><br>
    <a href="/admin/roles">Список ролей</a><br>
    <a href="/admin/pets">Список питомцев</a><br>
    <a href="/admin/types-pet">Список типов животных</a><br>
    <br><a href="/">&larr; Назад</a>
</div>

</body>
</html>
