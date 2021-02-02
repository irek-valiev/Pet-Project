<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.FormatStyle" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="ru.innopolis.petproject.entities.Pet" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/profile.css">
    <link href="${contextPath}/resources/css/pet_profile.css" rel="stylesheet"/>
    <title>Назначить встречу</title>
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
                <c:if test="${pet.user.id != user.id}">
                    <div id="profile_edit_button_group" style="left: 30px">
                        <a href="/user/sending_messages?to=${pet.user.id}">
                            <button type=button class="button btn_edit_profile" style="width: 150px">Отправить
                                сообщение
                            </button>
                        </a>
                    </div>
                </c:if>
                <c:if test="${pet.user.id == user.id}">
                    <div id="profile_edit_button_group">
                        <a href="/user/profile/edit">
                            <button type=button class="button btn_edit_profile">Редактировать</button>
                        </a>
                    </div>
                </c:if>
                <sec:authorize access="hasAuthority('ROLE_ADMIN')">
                    <a href="/admin/users/${pet.user.id}">
                        <button type=button class="btn_edit_profile_admin"></button>
                    </a>
                </sec:authorize>
                <div id="profile_delimiter"></div>
                <span id="profile_name">${pet.user.firstName} ${pet.user.lastName}</span>
                <div id="profile_avatar"></div>
            </div>

            <%@include file="page_parts/navigation_menu.jsp" %>

            <jsp:include page="/upcoming_meetings"/>

            <div id="pet_profile_main_group">
                <div id="pet_profile_group_background"></div>
                <div id="pet_main_info_group">
                    <div id="general_my_pet_background"></div>
                    <div id="pet_avatar">
                        <img id="e344_686" src="/pet_image?id=${pet.id}" width="100" height="100"/>
                    </div>
                    <span id="label_pet_name">${pet.name}</span>
                    <div id="pet_buttons_actions_group">
                            <%--TODO Если такая встреча уже есть в БД, ее можно отменить--%>
                        <c:if test="${pet.user.id != user.id}">
                            <c:if test="false">
                                <a href="#">
                                    <button type=button class="button btn_edit_profile">Отменить встречу</button>
                                </a>
                            </c:if>

                            <c:if test="true">
                                <a href="/user/pet_profile?id=${pet.id}">
                                    <button type=button class="button btn_edit_profile">Отмена</button>
                                </a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
                <div id="sex_group">
                    <c:if test="${pet.sex != 'NONE'}">
                        <%
                            Pet pet = (Pet) request.getAttribute("pet");
                            String contextPath = (String) pageContext.getAttribute("contextPath");
                            String sexIconPath = pet.getSex().equals("MALE") ?
                                    contextPath + "../../resources/images/ic_mars.png" :
                                    contextPath + "../../resources/images/ic_venus.png";

                        %>
                        <div id="sex_background">
                            <img id="sex_image" src="<%=sexIconPath%>"></div>
                        <span id="sex_label">Пол ${contextPath}</span>
                    </c:if>
                </div>
                <div id="pet_type_birthday_group">
                    <div id="pet_type_birthday_background"></div>
                    <span id="label_pet_birthday">
                            <%
                                Pet pet = (Pet) request.getAttribute("pet");
                                LocalDate birthday = pet.getBirthday().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                                String outBirthday = DateTimeFormatter.ofLocalizedDate(FormatStyle.FULL)
                                        .withLocale(new Locale("ru")).format(birthday);
                            %>

                                    Дата рождения:<br> <%=outBirthday%>
                                </span>
                    <span id="label_pet_type">${pet.typePet.typeName}</span>
                </div>
                <div id="meeting_group_form">
                    <form:form method="post" modelAttribute="matingPetsForm">
                        <div id="meeting_group_form_title_label">
                            <span class="input_form_text_styles">Выбрать питомца для встречи</span>
                        </div>

                        <div id="meeting_group_form_from_pet">
                            <form:select path="fromPet" id="select-available-pet" cssClass="select_form_style">
                                <form:options var="availablePet" items="${availableUserPets}" itemLabel="name"/>
                            </form:select>
                        </div>

                        <div class="input_form_text_styles">
                            Выбрать дату встречи
                        </div>

                        <div id="meeting_group_form_date_form">
                            <form:input path="dateMating" type="date"
                                        class="select_form_style"
                                        value="${earliestMeetingDate}"
                                        min="${earliestMeetingDate}"/>
                        </div>

                        <form:input path="toPet" type="hidden" value="${pet.id}"/>

                        <div id="meeting_group_form_button">
                            <button type="submit" class="button">Назначить встречу</button>
                        </div>
                    </form:form>
                </div>
            </div>
            </sec:authorize>
        </div>
    </div>
</div>
</body>
</html>
