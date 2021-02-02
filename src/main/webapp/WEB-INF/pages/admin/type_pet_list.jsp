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
    <title>Типы животных</title>
</head>
<body>

<div class="result-items user-options" id="pet_type">
    Типы животных:<br>
    <table>
        <tr><td>Наименование</td><td></td></tr>
        <c:forEach var="type" items="${all_types}">
            <tr>
                <td>${type.typeName}</td>
                <td><a href="/admin/types-pet/${type.id}">Удалить</a></td>
            </tr>
        </c:forEach>
    </table>
    <form:form method="post" action="/admin/types-pet" modelAttribute="new_type">
        <div>
            <form:input path="typeName" type="text" placeholder="Новый тип" autofocus="true"/>
        </div>
        <button class="button" type="submit">Добавить</button>
    </form:form>
    <br><a href="/admin">&larr; Назад</a>
</div>

</body>
</html>