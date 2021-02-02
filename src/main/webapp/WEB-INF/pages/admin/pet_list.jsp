<%@ page import="ru.innopolis.petproject.entities.Pet" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.format.FormatStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
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
    <title>Список питомцев</title>
</head>
<body>

<div class="result-items user-options vertical-containers" id="pets">
    <label for="tablePets">
        Питомцы:
    </label>
    <table id="tablePets">
        <tr>
            <td>Владелец</td>
            <td>Порода</td>
            <td>Кличка</td>
            <td>Дата рождения</td>
            <td>Пол</td>
            <td></td>
        </tr>
        <%
            List<Pet> pets = (List<Pet>) request.getAttribute("all_pets");
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter
                    .ofLocalizedDate(FormatStyle.MEDIUM)
                    .withLocale(new Locale("ru"));
            for (Pet pet : pets) {
                LocalDate birthday = pet.getBirthday().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                String outBirthday = dateTimeFormatter.format(birthday);
        %>
        <tr>
            <td><a href="/profile/<%=pet.getUser().getId()%>"><%=pet.getUser().getLogin()%></a></td>
            <td><%=pet.getTypePet().getTypeName()%></td>
            <td><%=pet.getName()%></td>
            <td><%=outBirthday%></td>
            <th><%=pet.getSex()%></th>
            <td><a href="/admin/pets/<%=pet.getId()%>">Удалить</a></td>
        </tr>
        <%
            }
        %>
        <c:forEach var="pet" items="${all_pets}">

        </c:forEach>
    </table>
    <a href="/admin">&larr; Назад</a>
</div>

</body>
</html>