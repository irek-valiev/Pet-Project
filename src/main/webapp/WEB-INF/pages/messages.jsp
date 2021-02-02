<%@ page import="ru.innopolis.petproject.entities.Message" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="contentHeightLimit" value="700"/>
<c:set var="headerHeight" value="29"/>
<c:set var="messageItemHeight" value="40"/>
<c:set var="inbox" value="inbox"/>
<c:set var="outbox" value="sent"/>

<%
    final int prevTxtLengthLimit = 50;
    List<Message> messageList = (List<Message>) request.getAttribute("messagesList");
    String messageType = (String) request.getAttribute("type");
%>


<html>
<head>
    <title>Сообщения</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/messaging.css">
</head>
<body>


<div id="site_wrapper">
    <div id="main_container">
        <div id="navigation_block_group">
            <div id="navigation_block_background"></div>
            <span id="navigation_top_label">Сообщения</span>
            <div id="inbox_group">
                <c:if test="${type == outbox}">
                    <span id="inbox_text" class="menu_text_style"><a href="/user/profile/messages?t=inbox">Входящие</a></span>
                </c:if>

                <c:if test="${type == inbox}">
                    <span id="inbox_text" class="menu_text_style" style="font-weight: bold"><a
                            href="/user/profile/messages?t=inbox">Входящие</a></span>
                </c:if>
                <div id="ic_inbox"></div>
            </div>
            <div id="outbox_group">
                <c:if test="${type == outbox}">
                    <span id="outbox_text" class="menu_text_style" style="font-weight: bold"><a
                            href="/user/profile/messages?t=sent">Исходящие</a></span>
                </c:if>

                <c:if test="${type == inbox}">
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


        <div id="message_list_header">
            <div id="message_list_header_background"></div>
            <span id="message_list_author_label"> <c:out
                    value="${type == inbox ? 'Отправитель' : 'Получатель'}"/></span>
            <span id="message_list_content_label">Содержимое</span>
            <span id="message_list_date_label">Дата</span>
        </div>

        <c:if test="${empty messagesList}">
        <div class="message_list_container">
            <div id="messages_list_background"></div>
            </c:if>

            <c:set var="contentHeight" value="${messagesList.size() * messageItemHeight + headerHeight}"/>
            <c:set var="height" value="${(contentHeight > contentHeightLimit) ? contentHeightLimit : contentHeight}"/>

            <c:if test="${!empty messagesList}">
            <div class="message_list_container"
                 style="height: ${height}px">
                <div id="messages_list_background"
                     style="height: ${height}px"></div>
                </c:if>


                <c:if test="${empty messagesList}">
                    <span id="message_list_no_messages">Нет сообщений</span>
                </c:if>

                <c:if test="${!empty messagesList}">
                    <%
                        String messageItemTemplate =
                                "<a href=\"/user/profile/messages?t=%s&message_id=%d\"><div id=\"item_message_group\" style=\"top: %dpx\">\n" +
                                        "                    <div id=\"%s\"></div>\n" +
                                        "                    <span id=\"item_message_date\">%s</span>\n" +
                                        "                    <span id=\"item_message_preview\">%s</span><span\n" +
                                        "                        id=\"item_message_author\">%s</span>\n" +
                                        "                </div>  ";

                        int currentYPos = 28;
                        int height = 40;

                        for (Message message : messageList) {
                            boolean isRead = message.getDateRead() != null;
                            String messageBody = message.getMessageBody();
                            try {
                                out.print(String.format(
                                        messageItemTemplate,
                                        messageType,
                                        message.getId(),
                                        currentYPos,
                                        isRead ? "item_message_background" : "unread_message_background",
                                        message.getDateWrite(),
                                        messageBody.length() > prevTxtLengthLimit ?
                                                messageBody.substring(0, prevTxtLengthLimit).concat("...") :
                                                messageBody,
                                        messageType.equals("inbox") ?
                                                message.getFromUser().getFirstName() + " " + message.getFromUser().getLastName() :
                                                message.getToUser().getFirstName() + " " + message.getToUser().getLastName()));
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                            currentYPos += height;
                        }
                    %>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>