<%@ page import="com.google.common.base.Strings" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="Menu_Style.css" />
</head>

<body bgcolor="#fffff0">


<script>

    function loadUrl(url) {
        document.getElementById('sframe').src = url;
    }

</script>

<style>
     {
        margin-left: 391px;
        font-size: 27px;
        font-style: italic;
        color: blue;
    }

</style>
<table width="100%" bgcolor="gray" border="2" >
    <tr>
        <td>

            <div class="main_menu">
                <ul>
                    <li><div class="s-12 l-2">
                        <a href="Index.jsp" class="logo">
                            <!-- Logo White Version -->
                            <img class="logo-white" src="img/logo.png" alt="">
                        </a>
                    </div></li>
                    <li><a onclick="loadUrl('SgReg.jsp')" name="SG" value="SG" >Registration </a></li>
                    <li><a onclick="loadUrl('Preacher.jsp' )" name="PR" value="PR">Preacher</a></li>
                    <li><a onclick="loadUrl('AllocationForm.jsp')" name="AL" value="AL">Allocation</a></li>

                    <li><a href="#">Search</a>
                        <ul>
                            <li><a href="#">Review</a></li>
                            <li><a href="#">Remark</a></li>
                        </ul></li>

                    <li><a href="#">Allocation</a></li>
                    <li><%
                        String userName = (String) session.getAttribute("UserName");
                        if (Strings.isNullOrEmpty(userName)) {
                            response.sendRedirect("Login.jsp");
                        } else {

                            out.println("<A href=\"Login.jsp?Action=Logout\">Logout</A>");
                        }

                    %>
                    </li>
                </ul>
            </div>
        </td>
    </tr>
</table>
<table width="15%" bgcolor="gray" border="2">
    <tr>
        <td>
            <div class="menu">
                <ul>
                    <li><a onclick="loadUrl('Register3.jsp')" name="SG" value="SG" >Registration </a></li>
                    <li><a onclick="loadUrl('Preacher.jsp' )" name="PR" value="PR">Preacher</a></li>
                    <li><a onclick="loadUrl('AllocationForm.jsp')" name="AL" value="AL">Allocation</a></li>

                    <li><a href="#">Search</a>
                        <ul>
                            <li><a href="#">Review</a></li>
                            <li><a href="#">Remark</a></li>
                        </ul></li>

                    <li><a href="#">Allocation</a></li>

                </ul>
            </div>
        </td>
    </tr>
</table>
<iframe id="sframe" class="frame" src="Hello.html" height="800" width="1035" frameborder="0"
        onload="window.parent.parent.scrollTo(0,0)" ></iframe>

</body>