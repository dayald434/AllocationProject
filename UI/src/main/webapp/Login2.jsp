<!DOCTYPE html>
<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>

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
<body>
<%
    ApiHelper apiHelper = new ApiHelper();
    String action = request.getParameter("Action");
    if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Logout")) {
        session.invalidate();
        response.sendRedirect("Login.jsp");
        return;
    } else if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Login")) {
        String userName = request.getParameter("UserName");
        String password = request.getParameter("Password");
        boolean isUserVerified = true;
        if (isUserVerified) {
            session.setAttribute("UserName", userName);
            session.setAttribute("IsLogged", true);
            response.sendRedirect("Index.jsp");
            return;
        } else {
            out.println("Wrong UserName/Password");
        }
    }

%>

<div class="login-page">
    <div class="form">
        <form class="register-form" action="Login.jsp">
            <input type="text" placeholder="name"/>
            <input type="password" placeholder="password"/>
            <input type="text" placeholder="email address"/>
        </form>
        <form class="login-form" action="Login.jsp">
            <input type="text" name="UserName" placeholder="username"/>
            <input type="password" name="Password" placeholder="Password"/>
            <button value="Login">login</button>
            <input type="hidden" name="Action" value="Login">
        </form>
    </div>
</div>
</body>
</head>
</html>