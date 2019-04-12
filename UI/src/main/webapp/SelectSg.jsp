<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/common.js"></script>

    <script>function validateUniqueShortName(value) {
        if (value != '') {
            var xmlHttp = new XMLHttpRequest();
            xmlHttp.open("GET", "ShortName.jsp?ShortName=" + value.toUpperCase(), false); // false for synchronous request
            xmlHttp.send(null);
            res = xmlHttp.responseText;
            if (res.trim().toLowerCase() == 'false') {
                alert("Short Name Not Available: " + value);
                document.Form.ShortName.value = ""
                document.Form.ShortName.focus();


            }
        }

    }

    function validate() {


        if (document.Form.SgId.value == "") {
            alert("Please Select Satsang Ghar!");
            document.Form.SgId.focus();
            return false;
        }


        if (document.Form.Mobile1.value.localeCompare(document.Form.Mobile2.value) == 0) {
            alert("Mobile2 should be different from Mobile1");
            document.Form.Mobile2.focus();
            return false;

        }


        if (document.Form.Sex.value == "") {
            alert("Please Select sex!");
            document.Form.Sex.focus();
            return false;
        }


        if (document.Form.Language1.value == "" && document.Form.Language2.value == "" &&
            document.Form.Language3.value == "" && document.Form.Language4.value == "") {
            alert("Please select at least one Language!");
            document.Form.Language1.focus();
            return false;
        }
    }

    </script>

    <style>
        .txt1 {
            width: 220px;
            height: 25px;
        }

        .blank_row {
            height: 25px
        }

    </style>
    <script type="text/javascript">
        function startUp() {
            var today = getTodayDate()
            document.getElementById('InitDate').max = today

        }

        window.onload = startUp;

    </script>

</head>
<body bgcolor="#fffff0">
<%!
    public String getAction(HttpServletRequest request) {
        String action = request.getParameter("Action");
        if (action.equalsIgnoreCase("Edit"))
            return "SgEdit.jsp";
        return "SgView.jsp";
    }
%>

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

<center>

    <form class="form1" action="<% out.print(getAction(request)); %>" method="post" name="Form" onsubmit="return(validate());">
        <BR>
        <font class="header1"><B class="">Select Satsang Ghar</B></font>

        <TABLE align="center" style=" border: none" class="table1">

            <TR>

                <TD>
                    <select required name="SgId" id="SgId" class="txt1">
                        <option value="">Select Satsang Ghar</option>

                        <%

                            String optionSkeleton = "<option value=\"%s\">%s</option>";

                            ApiHelper apiHelper = new ApiHelper();
                            List<SatsangGhar> list = apiHelper.getAllSatsangGhar();
                            for (int i = 0; i < list.size(); i++) {
                                String s = String.format(optionSkeleton, list.get(i).getId(), list.get(i).getName());
                                out.println(s);
                            }
                        %>
                    </select>
                </TD>
            </TR>

            <TR class="blank_row">
                <td></td>
            </TR>

            <TR>
                <TD align="center">
                    <input type="submit" value="Continue"/>
                </TD>

            </TR>

            <TR class="blank_row">
                <td>

                </td>

            </TR>
        </TABLE>
    </form>
</center>

</body>
</html>
