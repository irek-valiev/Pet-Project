<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<sec:authorize access="isAuthenticated()">
    <div class="navigation_block_group">
        <div class="navigation_block_background"></div>
        <div class="my_profile_group"><span class="my_profile_text"><a
                href="${contextPath}/user/profile/">Мой профиль</a></span>
            <div class="ic_home"></div>
        </div>
        <div class="search_group">
            <span class="search_text"><a href="${contextPath}/">Поиск животных</a></span>
            <div class="ic_search"></div>
        </div>
        <div class="message_group"><span class="message_text"><a
                href="${contextPath}/user/profile/messages?t=inbox">Сообщения</a></span>
            <div class="ic_message">
            </div>
        </div>
        <div class="shop_group"><span class="shop_text"><a href="/user/sale_pets">Купить питомца</a></span>
            <div class="ic_shop">
            </div>
        </div>
        <div class="logout_group"><span class="logout_text"><a href="${contextPath}/logout">Выход</a></span>
            <div class="ic_logout">
            </div>
        </div>
    </div>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <div class="navigation_block_group" style="height: 65px;">
        <div class="navigation_block_background" style="height: 65px;"></div>
        <div class="search_group" style="top: 12px">
            <span class="search_text"><a href="${contextPath}/">Поиск животных</a></span>
            <div class="ic_search"></div>
        </div>
        <div class="logout_group" style="top: 37px;"><span class="logout_text"><a href="${contextPath}/login">Войти</a></span>
            <div class="ic_login"></div>
        </div>
    </div>
</sec:authorize>

