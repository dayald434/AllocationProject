<%@ page import="com.google.common.base.Strings" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <link rel="stylesheet" type="text/css" href="Menu_Style.css"/>
</head>

<body bgcolor="#fffff0">
<%
    String ua = request.getHeader("User-Agent");
    String userName = (String) session.getAttribute("UserName");
    if (ua.indexOf("Chrome") == -1) {
        out.print(" This Application is supported only in Google Chrome !!!");
        return;
    }

    if (Strings.isNullOrEmpty(userName)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<jsp:include page="menu.jsp"/>
<BR>
<BR>
<BR>
<center>

    <font class="headerLarge"><B class="header1">Welcome to SD-AS : Satsang Duty Allocation System !!!</B></font>

</center>

</body>