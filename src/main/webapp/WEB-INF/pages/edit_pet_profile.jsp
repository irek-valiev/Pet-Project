<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                <c:if test="${edit_pet.user.id != user.id}">
                    <div id="profile_edit_button_group">
                        <a href="${contextPath}/user/sending_messages?to=${pet.user.id}">
                            <button type=button class="button btn_edit_profile">Отправить сообщение</button>
                        </a>
                    </div>
                </c:if>
                <c:if test="${edit_pet.user.id == user.id}">
                    <div id="profile_edit_button_group">
                        <a href="${contextPath}/user/profile/edit">
                            <button type=button class="button btn_edit_profile">Редактировать</button>
                        </a>
                    </div>
                </c:if>
                <sec:authorize access="hasAuthority('ROLE_ADMIN')">
                    <a href="/admin/users/${edit_pet.user.id}">
                        <button type=button class="btn_edit_profile_admin"></button>
                    </a>
                </sec:authorize>
                <div id="profile_delimiter"></div>
                <span id="profile_name">${edit_pet.user.firstName} ${edit_pet.user.lastName}</span>
                <div id="profile_avatar"></div>
            </div>

            <%@include file="page_parts/navigation_menu.jsp" %>

            <jsp:include page="/upcoming_meetings"/>

            <div id="my_pets_group">
                <div id="my_pets_group_style"></div>
                <div id="pet_profile_group">
                    <span class="pet_group_main_label">Изменить сведения о питомце</span>
                    <div id="edit_form">
                        <form:form method="post" modelAttribute="edit_pet" class="pet-edit-form" id="for_edit_pet">
                            <div class="pet-update-option">
                                <label for="pet-name-input">Кличка:</label>
                                <form:input id="pet-name-input" path="name" type="text" placeholder="Name"/>
                                <form:errors path="name"></form:errors>
                            </div>
                            <div class="pet-update-option">
                                <label for="pet-type-input">Тип:</label>
                                <select id="pet-type-input" name="typePet" required>
                                    <option selected></option>
                                    <c:forEach items="${allTypePet}" var="TypePet">
                                        <option value="${TypePet.typeName}">${TypePet.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="pet-update-option">
                                <label for="pet-sex-input">Пол:</label>
                                <select id="pet-sex-input" name="sex" required>
                                    <option selected></option>
                                    <option value="MALE">мальчик</option>
                                    <option value="FEMALE">девочка</option>
                                </select>
                            </div>
                            <div class="pet-update-option">
                                <label for="pet-birthday-input">Дата рождения:</label>
                                <input id="pet-birthday-input" name="birthday" max="${toDay}" type="date" required>
                            </div>
                            <div class="pet-update-option">
                                <label for="pet-status-input">Живой:</label>
                                <select id="pet-status-input" name="alive" required>
                                    <option selected></option>
                                    <option value="true">да</option>
                                    <option value="false">нет</option>
                                </select>
                            </div>
                            <div class="pet-update-option">
                                <button type="submit">Сохранить изменения</button>
                            </div>
                        </form:form>
                        <form:form class="pet-edit-form" enctype="multipart/form-data" method="post">
                            <div class="pet-update-option">
                                <label for="pet-photo-input">Картинка:</label>
                                <input id="pet-photo-input" type="file" accept="image/jpeg,image/png" name="image${pet.id}" size="50"/>
                            </div>
                            <div class="pet-update-option">
                                <button type="submit">Отправить</button>
                            </div>
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

