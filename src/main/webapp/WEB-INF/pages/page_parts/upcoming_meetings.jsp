<%@ page import="ru.innopolis.petproject.entities.MatingPets" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.FormatStyle" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="meeting_group">
    <div id="meeting_group_style"></div>
    <a href="/user/meetings"><span id="meeting_label">Встречи </span></a>
    <div id="meeting_delimiter"></div>

    <c:if test="${upcomingMeetings.size() == 0}">
        <div id="meeting_image"></div>
        <span id="no_meeting_label">Нет запланированных встреч</span>
    </c:if>

    <c:if test="${upcomingMeetings.size() > 0}">
        <%
            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter dateFormat = DateTimeFormatter.ofLocalizedDate(FormatStyle.FULL)
                    .withLocale(new Locale("ru"));
        %>

        <c:forEach var="upcomingMeet" items="${upcomingMeetings}" varStatus="loop">
                <span id="upcoming_meet_element_date" style="top: ${(loop.index + 1) * 33}px">
                    <%
                        MatingPets upcomingMeet = (MatingPets) pageContext.getAttribute("upcomingMeet");
                        LocalDate meetDate = upcomingMeet.getDateMating().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                        String dateOutput = meetDate.equals(currentDate) ? "сегодня"
                                : (meetDate.minusDays(1).equals(currentDate) ? "завтра"
                                : (meetDate.minusDays(2).equals(currentDate) ? "послезавтра" : meetDate.toString()));
                    %>
                    <%=dateOutput%>
                                </span>
            <span id="upcoming_meet_element_names" style="top: ${(loop.index + 1) * 33}px">
                <%=upcomingMeet.getFromPet().getName()%> <%=upcomingMeet.getToPet().getName()%>
            </span>
        </c:forEach>
    </c:if>
</div>
