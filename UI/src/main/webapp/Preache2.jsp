<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <script>function validateUnique(value) {
        if (value != '') {
            var xmlHttp = new XMLHttpRequest();
            xmlHttp.open("GET", "ShortName.jsp?ShortName=" + value.toUpperCase(), false); // false for synchronous request
            xmlHttp.send(null);
            res = xmlHttp.responseText;
            if (res.trim().toLowerCase() == 'false') {
                alert("Short Name Not Available: " + value);
                document.PreacherForm.ShortName.value = ""
                document.PreacherForm.ShortName.focus();


            }
        }

    }

    function validate() {

        if (document.PreacherForm.fullName.value == "") {
            alert("Please provide your fullName!");
            document.PreacherForm.fullName.focus();
            return false;
        }
        if (document.PreacherForm.ShortName.value == "") {
            alert("Please provide your Short Name!");
            document.PreacherForm.ShortName.focus();
            return false;
        }
        if (document.PreacherForm.Sex.value == "") {
            alert("Please Select sex!");
            document.PreacherForm.Sex.focus();
            return false;
        }
        if (document.PreacherForm.InitDate.value == "") {
            alert("Please provide Initiation Date!");
            document.PreacherForm.InitDate.focus();
            return false;
        }
        if (document.PreacherForm.SgId.value == "") {
            alert("Please select satsang ghar!");
            document.PreacherForm.SgId.focus();
            return false;
        }
        if (document.PreacherForm.Language1.value == "" && document.PreacherForm.Language2.value == "" && document.PreacherForm.Language3.value == "") {
            alert("Please select at least one Language!");
            document.PreacherForm.Language1.focus();
            return false;
        }
    }

    </script>

    <style>
        .txt1 {
            width: 260px;
            height: 25px;
        }

        .blank_row {
            height: 25px
        }

    </style>
    <script type="text/javascript">
        function startUp() {
            var today = dateF(new Date());
            document.getElementById('InitDate').max = today

        }

        window.onload = startUp;

        function dateF(dateO) {
            var dd = dateO.getDate();
            var mm = dateO.getMonth() + 1;
            var yyyy = dateO.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }

            if (mm < 10) {
                mm = '0' + mm;
            }
            return yyyy + "-" + mm + "-" + dd;
        }
    </script>
    <link rel="stylesheet" href="css/style.css"/>

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

<center>
    <H2> Sewadar Registartion</H2>

    <form style=" border-color: lightgrey;width: 80%; border-style: outset" action="RegisterSewadar.jsp" name="PreacherForm" onsubmit="return(validate());" wi>
        <TABLE align="center" style="height:60%;">

            <TR>
                <TD>
                    <input name="Name" id="fullName" class="txt1" MAXLENGTH="32" placeholder="Full Name" pattern="[a-z A-Z]+" ng-pattern-restrict style="text-transform: capitalize;"/>

                </TD>
                <TD>
                    <input name="ShortName" id="ShortName" class="txt1" MAXLENGTH="6" onchange="validateUnique(value)" placeholder="Short Name" pattern="[a-z A-Z" ng-pattern-restrict style="text-transform:uppercase"/>

                </TD>

            </TR>

            <TR>
                <TD>
                    <select name="SgId" id="SgId" class="txt1">
                        <option value="">Select Associated Satsang Ghar of Sewadar</option>

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
                <TD>
                    <font color="blue">
                        <input class="txt1" name="InitDate" id="InitDate" type="date" max="" placeholder="Select Initiation Date">
                        <small>Initiation Date</small>
                    </font>
                </TD>

            </TR>
            <TR>

                <TD>
                    <input name="Mobile1" id="Mobile1" class="txt1" pattern="[1-9]{1}[0-9]{9}" maxlength="10" class="field-style field-full align-none" placeholder="Mobile 1"/>

                </TD>
                <TD>
                    <input name="Mobile2" id="Mobile2" class="txt1" placeholder="Mobile 2" pattern="[1-9]{1}[0-9]{9}" maxlength="10"/>

                </TD>

            </TR>

            <TR>
                <TD>
                    Sex:
                    <input type="radio" id="Sex" class="radioBtn" name="Sex" value="M" size="10" checked="checked">Male
                    <input type="radio" class="radioBtn" name="Sex" value="F" size="10">Female
                    <input type="radio" class="radioBtn" name="Sex" value="O" size="10"> Other
                </TD>
            </TR>
            <TR>
                <TD>
                    Sawadar Type:
                    <input type="radio" id="type1" name="Type" value="Pathi" checked="checked"> Pathi
                    <input type="radio" name="Type" value="Karta"> Karta
                    <input type="radio" name="Type" value="Reader"> Reader
                </TD>
            </TR>

            <TR>
                <TD height="3">
                    <font color="blue">
                        <small>Languages</small>
                    </font>
                </TD>

            </TR>

            <TR>
                <TD>
                    <select class="txt1" name="Language1" id="Language1">
                        <option value="">Language</option>

                        <% out.println(HtmlGenerator.getLanguage());%>

                    </select>

                </TD>

                <TD>
                    <select class="txt1" name="Language2" id="Language2">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage());%>
                    </select>

                </TD>
            </TR>
            <TR>
                <TD>
                    <select class="txt1" name="Language3" id="Language3">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage());%>

                    </select>

                </TD>
                <TD>
                    <select class="txt1" name="Language4" id="Language4">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage());%>

                    </select>

                </TD>

            </TR>

            <TR class="blank_row">
                <td>

                </td>

            </TR>

        </TABLE>

        <TABLE width="38%">
            <TR>
                <TD align="center">
                    <input type="submit" value="Submit"/>
                </TD>
                <TD align="center">
                    <input type="reset" value="Reset">

                </TD>

            </TR>
        </TABLE>
</center>
</form>

</body>
</html>
