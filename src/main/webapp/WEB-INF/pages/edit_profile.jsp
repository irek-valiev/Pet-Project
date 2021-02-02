<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Мой профиль</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/profile.css">
</head>
<body>

<div>
    <sec:authorize access="!isAuthenticated()">
        <% response.sendRedirect("/login"); %>
    </sec:authorize>

    <sec:authorize access="isAuthenticated()">
        <div id="site_wrapper">
            <div id="main_container">
                <div id="profile_group">
                    <div id="profile_style"></div>
                    <div id="profile_edit_button_group">
                        <a href="/user/profile/edit">
                            <button type=button class="button btn_edit_profile">Редактировать</button>
                        </a>
                    </div>
                    <div id="profile_delimiter"></div>
                    <span id="profile_name">${user.firstName} ${user.lastName}</span>
                    <div id="profile_avatar"></div>
                </div>

                <%@include file="page_parts/navigation_menu.jsp" %>

                <jsp:include page="/upcoming_meetings"/>

                <div id="my_pets_group">
                    <div id="my_pets_group_style"></div>
                    <label for="my_pets_no_pets_label">Редактирование профиля</label>
                    <form:form method="post" modelAttribute="edit_user" class="user-edit-form" id="my_pets_no_pets_label">
                        <div class="user-update-option">
                            <label for="inputFirstName">Имя:</label>
                            <form:input id="inputFirstName" path="firstName" type="text" placeholder="First Name"/>
                            <form:errors path="firstName"></form:errors>
                        </div>
                        <div class="user-update-option">
                            <label for="inputLastName">Фамилия:</label>
                            <form:input id="inputLastName" path="lastName" type="text" placeholder="Last Name"/>
                            <form:errors path="lastName"></form:errors>
                        </div>
                        <div class="user-update-option">
                            <label for="inputEmail">Email:</label>
                            <form:input id="inputEmail" path="email" type="text" placeholder="Email"/>
                            <form:errors path="email"></form:errors>
                        </div>

                        <div class="user-update-option">
                            <label for="passwordUpdate">Сменить пароль</label>
                            <form:input id="passwordUpdate" path="password" type="password" placeholder="Новый пароль"/>
                            <form:errors path="password"></form:errors>
                        </div>
                        <div class="user-update-option">
                            <form:input path="confirmPassword" type="password" placeholder="Продтверждение нового пароля"/>
                            <form:errors path="confirmPassword"></form:errors>
                        </div>
                        <div class="user-update-option">
                            <button type="submit">Сохранить изменения</button>
                        </div>
                    </form:form>

                </div>

            </div>
        </div>
    </sec:authorize>
</div>

</body>
</html>
