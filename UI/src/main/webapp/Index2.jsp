<%@ page import="com.google.common.base.Strings" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="Menu_Style.css"/>
</head>

<body bgcolor="#fffff0">

<script>

    function loadUrl(url) {
        document.getElementById('sframe').src = url;
    }

</script>

<%
    String userName = (String) session.getAttribute("UserName");
    if (Strings.isNullOrEmpty(userName)) {
        response.sendRedirect("Login.jsp");
    }

%>

<table width="100%" bgcolor="gray" border="2">
    <tr>
        <td style="margin-top: 5%; margin-left: 5%; margin-right: 10%">

            <div class="main_menu">
                <ul>

                    <li><a href="SgReg.jsp" name="SG" value="SG">Registration </a></li>
                    <li><a href="Preacher.jsp" name="PR" value="PR">Preacher</a></li>
                    <li><a href="AllocationForm.jsp" name="AL" value="AL">Allocation</a></li>

                    <li>

                            <%

                            out.println("<A href=\"Login.jsp?Action=Logout\">Logout</A>");

                        %>
                    <li>

                        <%
                            out.println("Welcome " + userName + "!!!");
                        %>

                    </li>

                    </li>
                </ul>
            </div>
        </td>
    </tr>

</table>

</body>