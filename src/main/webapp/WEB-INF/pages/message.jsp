<%@ page import="ru.innopolis.petproject.entities.Message" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="messageAuthor" value="${message.fromUser.login}"/>

<html>
<head>
    <title>Сообщение</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/messaging.css">
</head>
<body>

<%
    Message message = (Message) request.getAttribute("message");
%>

<div id="site_wrapper">
    <div id="main_container">
        <div id="navigation_block_group">
            <div id="navigation_block_background"></div>
            <span id="navigation_top_label">Сообщения</span>
            <div id="inbox_group">
                <c:if test="${messageAuthor == username}">
                    <span id="inbox_text" class="menu_text_style"><a href="/user/profile/messages?t=inbox">Входящие</a></span>
                </c:if>

                <c:if test="${messageAuthor != username}">
                    <span id="inbox_text" class="menu_text_style" style="font-weight: bold"><a
                            href="/user/profile/messages?t=inbox">Входящие</a></span>
                </c:if>
                <div id="ic_inbox"></div>
            </div>
            <div id="outbox_group">
                <c:if test="${messageAuthor == username}">
                    <span id="outbox_text" class="menu_text_style" style="font-weight: bold"><a
                            href="/user/profile/messages?t=sent">Исходящие</a></span>
                </c:if>

                <c:if test="${messageAuthor != username}">
                    <span id="outbox_text" class="menu_text_style"><a href="/user/profile/messages?t=sent">Исходящие</a></span>
                </c:if>
                <div id="ic_outbox"></div>
            </div>

            <div id="delimiter"></div>

            <div id="my_profile_group">
                <span id="my_profile_text" class="menu_text_style"><a href="/user/profile/">Мой профиль</a></span>
                <div id="ic_my_profile"></div>
            </div>
            <div id="search_pets_group">
                <span id="search_text" class="menu_text_style"><a href="/">Поиск животных</a></span>
                <div id="ic_search"></div>
            </div>
        </div>

        <div id="message_container">
            <div id="message_background"></div>
            <div id="message_header">
                <div id="message_header_background"></div>
                <a href="#" onclick="history.go(-1)">
                    <div id="header_back_button_group">
                        <div id="header_back_button_background"></div>
                        <div id="ic_back"></div>
                    </div>
                </a>

                <c:if test="${messageAuthor != username}">
                    <a href="/user/sending_messages?to=${message.fromUser.id}">
                        <div id="header_response_button_group">
                            <div id="header_response_button_background"></div>
                            <div id="ic_write"></div>
                        </div>
                    </a>
                </c:if>


                <span id="message_author">
                        ${message.fromUser.firstName} ${message.fromUser.lastName}
                </span>
                <span id="message_date">
                    <%=message.getDateWrite()%>
                </span>

            </div>
            <span id="message_text">
                <%=message.getMessageBody()%>
            </span>
        </div>
    </div>
</div>
</body>
</html>