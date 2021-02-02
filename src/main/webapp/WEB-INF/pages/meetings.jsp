<%@ page import="ru.innopolis.petproject.entities.MatingPets" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.FormatStyle" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
    final int meetLabelHeight = 22;
    final int meetItemHeight = 90;
    final int itemsPadding = 5;
    int yPos;
    int currentItem;
    final List<MatingPets> incomingMeets = (List<MatingPets>) request.getAttribute("incoming_meets");
    final List<MatingPets> outcomingMeets = (List<MatingPets>) request.getAttribute("outcoming_meets");
    final int incomingMeetsCount = incomingMeets.size();
    final int outcomingMeetsCount = outcomingMeets.size();
    pageContext.setAttribute("incomingMeetsCount", incomingMeetsCount);
    pageContext.setAttribute("outcomingMeetsCount", outcomingMeetsCount);
    final int outcomingMeetsStartYPos = incomingMeetsCount * (meetItemHeight + itemsPadding) + meetLabelHeight;

    LocalDate currentDate = LocalDate.now();
    DateTimeFormatter dateFormat = DateTimeFormatter.ofLocalizedDate(FormatStyle.FULL)
            .withLocale(new Locale("ru"));
%>

<html>
<head>
    <title>Встречи</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/profile.css">
    <link href="${contextPath}/resources/css/meeting.css" rel="stylesheet"/>
</head>
<body>

<div>
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

            <div id="meetings_list_container" >
                <div id="meeting_header">
                    <div id="meeting_header_top_part_bg"></div>
                    <span id="meeting_top_label">Запросы на встречу</span>
                    <div id="meeting_header_bot_part_bg"></div>
                    <span id="label_to">Кому</span>
                    <span id="label_with">С кем</span>
                    <span id="label_from">От кого/Кому</span>
                    <span id="label_date">Дата</span>
                    <span id="label_conclusion">Решение</span>
                </div>
                <div id="meetings_list_background"></div>

                <div id="meetings_list_group">
                    <c:if test="${incomingMeetsCount > 0}">
                        <span class="meeting_group_label">Входящие запросы</span>
                        <div class="meet_type_label_delimiter"></div>

                        <%
                            yPos = meetLabelHeight + itemsPadding;
                            currentItem = 0;
                            pageContext.setAttribute("yPos", yPos);
                        %>

                        <c:forEach var="incomingMeet" items="${incoming_meets}">
                            <c:set var="owner" value="${incomingMeet.fromPet.user}"/>
                            <%
                                MatingPets meet = (MatingPets) pageContext.getAttribute("incomingMeet");
                                LocalDate meetDate = meet.getDateMating()
                                        .toInstant()
                                        .atZone(ZoneId.systemDefault())
                                        .toLocalDate();
                                String dateOutput = meetDate.equals(currentDate) ? "сегодня"
                                        : (meetDate.minusDays(1).equals(currentDate) ? "завтра"
                                        : (meetDate.minusDays(2).equals(currentDate) ? "послезавтра" : dateFormat.format(meetDate)));

                            %>
                            <div id="meet_item_group" style="top: ${yPos}">
                                <div id="meet_item_delimiter"></div>
                                <a href="/user/pet_profile?id=${incomingMeet.toPet.id}">
                                    <img src="/pet_image?id=${incomingMeet.toPet.id}" class="pet_avatar_left"/>
                                    <span class="label_pet_left">${incomingMeet.toPet.name}</span>
                                </a>
                                <a href="/user/pet_profile?id=${incomingMeet.fromPet.id}">
                                    <img src="/pet_image?id=${incomingMeet.fromPet.id}" class="pet_avatar_right"/>
                                    <span class="label_pet_right">${incomingMeet.fromPet.name}</span>
                                </a>
                                <span id="pet_owner">${owner.firstName} ${owner.lastName}</span>
                                <span id="meet_date"><%=dateOutput%></span>

                                <c:if test="${incomingMeet.isDone == null}">
                                    <div id="meet_button_group">
                                        <div class="decline_button_group">
                                            <form method="post" action="meetings">
                                                <input type="hidden" name="meetingId" value="${incomingMeet.id}">
                                                <input type="hidden" name="isApproved" value="false">
                                                <input type="submit" class="meet_button_decline" value="">
                                            </form>
                                        </div>
                                        <div class="approve_button_group">
                                            <form method="post" action="meetings">
                                                <input type="hidden" name="meetingId" value="${incomingMeet.id}">
                                                <input type="hidden" name="isApproved" value="true">
                                                <input type="submit" class="meet_button_approve" value="">
                                            </form>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${incomingMeet.isDone == true}">
                                    <div class="meet_conclusion_group"><span
                                            class="label_approve">Подтверждено</span></div>
                                </c:if>

                                <c:if test="${incomingMeet.isDone == false}">
                                    <div class="meet_conclusion_group">
                                        <span class="label_decline">Отказано</span>
                                    </div>
                                </c:if>
                            </div>

                            <%
                                currentItem++;
                                yPos = meetLabelHeight + meetItemHeight * currentItem + itemsPadding;
                                pageContext.setAttribute("yPos", yPos);
                            %>
                        </c:forEach>
                    </c:if>

                    <c:if test="${outcomingMeetsCount > 0}">
                    <span class="meeting_group_label"
                          style="top: <%=outcomingMeetsStartYPos%>px; left: 20px">Исходящие запросы</span>
                        <div class="meet_type_label_delimiter"
                             style="top: <%=outcomingMeetsStartYPos + meetLabelHeight - 2%>px"></div>
                        <%
                            yPos = (meetLabelHeight * 2) + ((meetItemHeight + itemsPadding) * incomingMeetsCount);
                            currentItem = 0;
                            pageContext.setAttribute("yPos", yPos);
                        %>

                        <c:forEach var="outcomingMeet" items="${outcoming_meets}">
                            <c:set var="owner" value="${outcomingMeet.toPet.user}"/>
                            <%
                                MatingPets meet = (MatingPets) pageContext.getAttribute("outcomingMeet");
                                LocalDate meetDate = meet.getDateMating()
                                        .toInstant()
                                        .atZone(ZoneId.systemDefault())
                                        .toLocalDate();
                                String dateOutput = meetDate.equals(currentDate) ? "сегодня"
                                        : (meetDate.minusDays(1).equals(currentDate) ? "завтра"
                                        : (meetDate.minusDays(2).equals(currentDate) ? "послезавтра" : dateFormat.format(meetDate)));

                            %>
                            <div id="meet_item_group" style="top: ${yPos}">
                                <div id="meet_item_delimiter"></div>
                                <a href="/user/pet_profile?id=${outcomingMeet.fromPet.id}">
                                    <img src="/pet_image?id=${outcomingMeet.fromPet.id}" class="pet_avatar_left"/>
                                    <span class="label_pet_left">${outcomingMeet.fromPet.name}</span>
                                </a>
                                <a href="/user/pet_profile?id=${outcomingMeet.toPet.id}">
                                    <img src="/pet_image?id=${outcomingMeet.toPet.id}" class="pet_avatar_right"/>
                                    <span class="label_pet_right">${outcomingMeet.toPet.name}</span>
                                </a>
                                <span id="pet_owner">${owner.firstName} ${owner.lastName}</span>
                                <span id="meet_date"><%=dateOutput%></span>

                                <c:if test="${outcomingMeet.isDone == null}">
                                    <div class="meet_conclusion_group" style="top: 18px"><span
                                            class="label_waiting_response">Ожидает подтверждения</span>
                                    </div>
                                </c:if>

                                <c:if test="${outcomingMeet.isDone == true}">
                                    <div class="meet_conclusion_group"><span class="label_approve">Подтверждено</span>
                                    </div>
                                </c:if>

                                <c:if test="${outcomingMeet.isDone == false}">
                                    <div class="meet_conclusion_group"><span class="label_decline">Отказано</span></div>
                                </c:if>
                            </div>

                            <%
                                currentItem++;
                                yPos += meetItemHeight + itemsPadding;
                                pageContext.setAttribute("yPos", yPos);
                            %>
                        </c:forEach>
                    </c:if>

                    <c:if test="${incomingMeetsCount == 0 && outcomingMeetsCount == 0}">
                        <span class="no_meetings_label">Нет запросов на встречу</span>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
