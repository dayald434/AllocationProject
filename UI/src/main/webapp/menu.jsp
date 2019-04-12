<%@ page import="com.google.common.base.Strings" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="Menu_Style.css"/>

    <style>
        .formM {
            display: inline;
        }

        .container {
            overflow: hidden;
            background-color: #8D331F;
            font-family: "Trebuchet MS";

        }

        .container a {
            font-family: "Trebuchet MS";
            float: left;
            font-size: 16px;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        .dropdown {
            float: left;
            overflow: hidden;
        }

        .dropdown .dropbtn {
            font-size: 16px;
            border: none;
            outline: none;
            color: white;
            padding: 14px 16px;
            background-color: inherit;
        }

        .container a:hover, .dropdown:hover .dropbtn {
            background-color: #B25541;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .dropdown-content a {
            float: none;
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            text-align: left;
        }

        .dropdown-content a:hover {
            background-color: #ddd;
        }

        .dropdown:hover .dropdown-content {
            display: block;
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

<div class="container">
    <a href="Home.jsp">Home</a>

    <div class="dropdown">
        <button class="dropbtn">Satsang Ghar</button>
        <div class="dropdown-content">
            <a href="SgReg.jsp">Add</a>

            <form class="formM" id="vsform" method="post" action="SelectSg.jsp">
                <input type="hidden" name="Action" value="View"/>
                <a onclick="document.getElementById('vsform').submit();">View</a>
            </form>

            <form class="formM" id="esform" method="post" action="SelectSg.jsp">
                <input type="hidden" name="Action" value="Edit"/>
                <a onclick="document.getElementById('esform').submit();">Update</a>
            </form>

        </div>
    </div>

    <div class="dropdown">
        <button class="dropbtn">SK/SR/Pathi</button>
        <div class="dropdown-content">
            <a href="Preacher.jsp">Add</a>

            <form class="formM" id="vpform" method="post" action="SelectPreacher.jsp">
                <input type="hidden" name="Action" value="View"/>
                <a onclick="document.getElementById('vpform').submit();">View</a>
            </form>
            <form class="formM" id="epform" method="post" action="SelectPreacher.jsp">
                <input type="hidden" name="Action" value="Edit"/>
                <a onclick="document.getElementById('epform').submit();">Update</a>
            </form>

        </div>
    </div>


    <div class="dropdown">
        <button class="dropbtn">Sewa Allocation</button>
        <div class="dropdown-content">
            <a href="AllocationForm.jsp">Contributor Allocation</a>
            <a href="AllocationFormCD.jsp">CD Allocation</a>
        </div>
    </div>


    <a href="Attendance.jsp">Un-Availability</a>

    <div class="dropdown">
        <button class="dropbtn">Reports</button>
        <div class="dropdown-content">
            <a href="SgAlloc.jsp">Satsang Ghar Allocation</a>
            <a href="ReportSelectPreacher.jsp">Sewadar Allocation</a>
        </div>
    </div>
         <a href="Attendance1.jsp">Attendance</a>
    <a href="Login.jsp?Action=Logout">Logout</a>

</div>
