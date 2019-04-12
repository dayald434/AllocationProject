<%@ page import="com.google.common.base.Strings" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="Menu_Style.css"/>
    <style type="text/css">

        a:hover {
            color: #3985B1;
        }
        .link {
            color: #4a4a4a;
            font-size: large;
            font-family: "Roboto", sans-serif;
            text-decoration: none;
            text-blink: true;
        }

        .table {
            border-bottom: groove;
            border: groove;
        }

        .tabD {
            border: groove;

        }
    </style>
</head>

<body bgcolor="#fffff0">

    <%
    String userName = (String) session.getAttribute("UserName");
    String name = (String) session.getAttribute("Name");

    if (Strings.isNullOrEmpty(userName)) {
        response.sendRedirect("Login.jsp");
    }

%>

<table class="table" align="center" width="100%" bgcolor=#a9a9a9 style="width: 100%; height: 10%">
    <tr>
        <td class="tabD" align="center"><a class="link"  href="Home.jsp" name="SG" value="SG">Home</a></td>
        <td class="tabD" align="center"><a class="link" href="SgReg.jsp" name="SG" value="SG">Satsang Ghar</a></td>
        <td class="tabD" align="center"><a class="link" href="Preacher.jsp" name="PR" value="PR">SK/SR/Pathi</a></td>
        <td class="tabD" align="center"><a class="link" href="AllocationForm.jsp" name="AL" value="AL">Sewa Allocation</a></td>
        <td class="tabD" align="center"><a class="link" href="Attendance.jsp" name="AL" value="AL">Un-Availability</a></td>
        <td class="tabD" align="center"><a class="link" href="Reports.jsp" name="AL" value="AL">Reports</a></td>

        <td class="tabD" align="center"><a class="link" href="Login.jsp?Action=Logout" name="AL" value="AL">Logout</a></td>
        <td align="center">
            <%
                out.print(name);
            %>
            </font>
        </td>

    </tr>

</table>
