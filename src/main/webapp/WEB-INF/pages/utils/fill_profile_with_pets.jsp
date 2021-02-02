<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ru.innopolis.petproject.entities.User" %>
<%@ page import="ru.innopolis.petproject.entities.Pet" %>
<%
    String outString = "<a class=\"none\" href=\"/user/pet_profile?id=%s\"><div id=\"pet_group\" style=\"left: %spx; top: %spx\">\n" +
            "<div id=\"pet_group_background\"></div>\n" +
            "<img src=\"/pet_image?id=%s\" id=\"pet_avatar\"/>\n" +
            "<span id=\"pet_name\">%s</span><span id=\"pet_type\">%s</span>\n" +
            "</div></a>";

    int widthPadding = Integer.parseInt(request.getParameter("widthPadding"));
    int heightPadding = Integer.parseInt(request.getParameter("heightPadding"));
    int posX = Integer.parseInt(request.getParameter("posX"));
    int posY = Integer.parseInt(request.getParameter("posY"));
    int width = 100;
    int height = 100;
    int columnPerRow = 4;
    int currentColumn = 1;
    int currentRow = 1;

    User user = (User) pageContext.findAttribute("user");

    for (Pet pet : user.getPets()) {
        int newPosX = posX + ((currentColumn % (columnPerRow + 1)) * widthPadding) + (width * (currentColumn - 1));
        int newPosY = posY + (currentRow * heightPadding) + (height * (currentRow - 1));
        currentColumn++;
        if (currentColumn == (columnPerRow + 1)) {
            currentRow++;
            currentColumn = 1;
        }
        out.print(String.format(outString, pet.getId(), newPosX, newPosY, pet.getId(), pet.getName(), pet.getTypePet().getTypeName()));
    }
%>