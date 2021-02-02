<%@ page import="ru.innopolis.petproject.entities.TypePet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>


<html lang="ru">
<head>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/profile.css">
    <link href="${contextPath}/resources/css/pet_profile.css" rel="stylesheet"/>
    <title>Профиль питомца</title>
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
                <sec:authorize access="hasAuthority('ROLE_ADMIN')">
                    <a href="/admin/users/${user.id}">
                        <button type=button class="btn_edit_profile_admin"></button>
                    </a>
                </sec:authorize>
                <div id="profile_delimiter"></div>
                <span id="profile_name">${user.firstName} ${user.lastName}</span>
                <div id="profile_avatar"></div>
            </div>

            <%@include file="page_parts/navigation_menu.jsp" %>

            <jsp:include page="/upcoming_meetings"/>

            <div id="my_pets_group">
                <div id="my_pets_group_style">
                    <span class="pet_group_main_label">Внесите сведения о пимтомце</span>
                    <div id="add_pet_form">
                        <form:form method="post" modelAttribute="petForm" id="for_add_pet">
                            <div>
                                Кличка: <input required name="name" type="text" placeholder="Введите кличку" maxlength="15">
                            </div>
                            <br><br>
                            <div>
                                Тип:
                                <select name="typePet" required>
                                    <option selected></option>
                                    <c:forEach items="${allTypePet}" var="TypePet">
                                        <option value="${TypePet.typeName}">${TypePet.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <br><br>
                            <div>
                                Пол: <select name="sex" required placeholder="пол">
                                <option selected></option>
                                <option value="MALE">мальчик</option>
                                <option value="FEMALE">девочка</option>
                            </select>
                            </div>
                            <br><br>
                            <div>
                                Дата рождения: <input name="birthday" max="${toDay}" type="date" required >
                            </div>
                            <br><br>
                            <div>
                                <label class="container">Питомец родился без использования сервиса
                                    <input type="checkbox" name="checkBox">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <br><br>
                            <button type="submit">Продолжить</button>





                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </sec:authorize>
        </div>
    </div>
</div>
</body>
</html>

