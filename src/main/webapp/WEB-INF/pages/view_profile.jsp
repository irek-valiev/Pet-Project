<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Профиль ${user.login}</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/profile.css">
</head>
<body>

<div>
    <div id="site_wrapper">
        <div id="main_container">
            <div id="profile_group">
                <div id="profile_style"></div>
                <div id="profile_edit_button_group" style="left: 30px">
                    <sec:authorize access="isAuthenticated()">
                        <a href="${contextPath}/user/sending_messages?to=${user.id}">
                            <button type=button class="button btn_edit_profile" style="width: 150px">Отправить
                                сообщение
                            </button>
                        </a>
                    </sec:authorize>
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

            <div id="my_pets_group">
                <div id="my_pets_group_style">
                    <c:set var="petsCount" value="${user.pets.size()}"/>

                    <c:if test="${petsCount > 0}">
                        <span id="my_pets_label">Питомцы ${user.login}: ${petsCount}</span>
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
                            <a href="/add_pet">
                                <button type=button class="button btn_edit_profile">Добавить</button>
                            </a>
                        </div>
                    </c:if>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
