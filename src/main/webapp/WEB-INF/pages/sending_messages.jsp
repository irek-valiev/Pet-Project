<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Сообщение для ${to}</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/messaging.css">
</head>
<body>
<div id="site_wrapper">
    <div id="main_container">
        <div id="navigation_block_group">
            <div id="navigation_block_background"></div>
            <span id="navigation_top_label">Сообщения</span>
            <div id="inbox_group">
                <span id="inbox_text" class="menu_text_style"><a
                        href="/user/profile/messages?t=inbox">Входящие</a></span>
                <div id="ic_inbox"></div>
            </div>
            <div id="outbox_group">
                <span id="outbox_text" class="menu_text_style"><a
                        href="/user/profile/messages?t=sent">Исходящие</a></span>
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

                <span id="message_author">Сообщение для ${to}</span>
            </div>
            <form method="post" id="text_area_group">
                <div>
                    <textarea autofocus=autofocus id="new_message_text_area" placeholder="Введите текст сообщения"
                              name="message"></textarea>
                    <button class="button" id="button_send_message" type="submit">Отправить</button>
                </div>

            </form>
        </div>
    </div>
</div>
</body>
</html>