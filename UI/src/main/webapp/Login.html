<!DOCTYPE html>
<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.StaticContent" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.User" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css"/>
    <meta charset="UTF-8">
    <script>

        $('.message a').click(function () {
            $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
        });
    </script>
<body bgcolor="#fffff0">

<%
    String ua = request.getHeader("User-Agent");
    if (ua.indexOf("Chrome") == -1) {
        out.print(" This Application is supported only in Google Chrome !!!");
        return;
    }

%>

<%
    ApiHelper apiHelper = new ApiHelper();
    StaticContent.reloadData();
    String action = request.getParameter("Action");
    if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Logout")) {
        session.invalidate();
        response.sendRedirect("Login.jsp");
        return;
    } else if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Login")) {
        String userName = request.getParameter("UserName");
        String password = request.getParameter("Password");
        User user = apiHelper.verifyUser(userName, password);

        if (user != null && user.getUserName().equalsIgnoreCase(userName)) {
            session.setAttribute("UserName", userName);
            session.setAttribute("Name", user.getName());
            session.setAttribute("IsLogged", true);
            response.sendRedirect("Home.jsp");
            return;
        } else {
            out.println("Wrong UserName/Password");
        }
    }

%>

<div class="login-page">
    <div class="form">
        <form class="register-form" action="Login.jsp" method="post">
            <input type="text" placeholder="name"/>
            <input type="password" placeholder="password"/>
            <input type="text" placeholder="email address"/>
            <button>create</button>
            <p class="message">Already registered? <a href="#">Sign In</a></p>
        </form>
        <form class="login-form" action="Login.jsp" method="post">
            <input type="text" name="UserName" placeholder="username"/>
            <input type="password" name="Password" placeholder="Password"/>
            <button value="Login">login</button>
            <p class="message">Not registered? <a href="#">Create an account</a></p>
            <input type="hidden" name="Action" mfethod="post" value="Login">
        </form>
    </div>
</div>
</body>
</head>
</html>