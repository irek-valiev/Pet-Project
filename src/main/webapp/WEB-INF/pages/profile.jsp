<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
                    <div id="my_pets_group_style">
                        <c:set var="petsCount" value="${user.pets.size()}"/>

                        <c:if test="${petsCount > 0}">
                            <span id="my_pets_label">Мои питомцы: ${petsCount}</span>
                            <a href="/user/add_pet" id="add_pet_label">Добавить</a>
                            <jsp:include page="utils/fill_profile_with_pets.jsp">
                                <jsp:param name="widthPadding" value="30"/>
                                <jsp:param name="heightPadding" value="25"/>
                                <jsp:param name="posX" value="20"/>
                                <jsp:param name="posY" value="50"/>
                            </jsp:include>

                        </c:if>

                        <c:if test="${petsCount == 0}">
                            <span id="my_pets_no_pets_label">У вас пока нет ни одного питомца</span>
                            <div id="no_pets_image"></div>
                            <div id="my_pets_add_button">
                                <a href="/user/add_pet">
                                    <button type=button class="button btn_edit_profile">Добавить</button>
                                </a>
                            </div>
                        </c:if>

                    </div>
                </div>

            </div>
        </div>
    </sec:authorize>
</div>

</body>
</html>
