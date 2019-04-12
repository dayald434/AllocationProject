<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.common.base.Strings" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/common.js"></script>
    <script src="js/city.js"></script>

    <script>function validateUniqueShortName(value) {
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


        if (document.PreacherForm.SgId.value == "") {
            alert("Please Select Satsang Ghar!");
            document.PreacherForm.SgId.focus();
            return false;
        }


        if (document.PreacherForm.Mobile1.value.localeCompare(document.PreacherForm.Mobile2.value) == 0) {
            alert("Mobile2 should be different from Mobile1");
            document.PreacherForm.Mobile2.focus();
            return false;

        }


        if (document.PreacherForm.Sex.value == "") {
            alert("Please Select sex!");
            document.PreacherForm.Sex.focus();
            return false;
        }


        if (document.PreacherForm.Language1.value == "" && document.PreacherForm.Language2.value == "" &&
            document.PreacherForm.Language3.value == "" ) {
            alert("Please select at least one Language!");
            document.PreacherForm.Language1.focus();
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
            var today = getTodayDate();
            document.getElementById('InitDate').max = today

        }

        window.onload = startUp;

    </script>

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

    <form class="form1" action="RegisterSewadar.jsp" method="post" name="PreacherForm" onsubmit="return(validate());">
        <BR>
        <font class="header1"><B class="">Sewadar Registration</B></font>

        <TABLE cellspacing="3" align="center" style="height:50%; border: none; width: 90%;" class="table1">

            <TR>
                <TD>
                    <input required TITLE="Only Alhbets space and dot (.) " name="Name" id="fullName" class="txt1" MAXLENGTH="40" placeholder="Full Name" pattern="[a-zA-Z][.a-zA-Z\s]*" ng-pattern-restrict style="text-transform: capitalize;"/>

                </TD>
                <TD>
                    <input required TITLE="Only Alphabets" name="ShortName" id="ShortName" class="txt1" MAXLENGTH="4" onchange="validateUniqueShortName(value)" placeholder="Short Name" pattern="[a-zA-Z][a-zA-Z]+" ng-pattern-restrict style="text-transform:uppercase"/>

                </TD>

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
            </TR>

            <TR>

                <TD>
                    <input required name="Mobile1" id="Mobile1" class="txt1" pattern="[1-9]{1}[0-9]{9}" maxlength="10" class="field-style field-full align-none" placeholder="Mobile 1"/>

                </TD>
                <TD>
                    <input name="Mobile2" id="Mobile2" class="txt1" placeholder="Home/Mobile 2" pattern="[1-9]{1}[0-9]{9}" maxlength="10"/>

                </TD>
                <TD>
                    <font color="blue">
                        <input required TITLE="Enter Initiation Date" class="txt1" name="InitDate" id="InitDate" type="date" max="" placeholder="Select Initiation Date">
                        <font color="blue">
                            <small>Initiation Date</small>
                        </font>
                    </font>
                </TD>

            </TR>

            <TR>

                <TD>
                    Sex:
                    <input type="radio" id="Sex" class="radioBtn" name="Sex" value="M" size="10" checked="checked">Male
                    <input type="radio" class="radioBtn" name="Sex" value="F" size="10">Female
                    <input type="radio" class="radioBtn" name="Sex" value="O" size="10"> Other
                </TD>

                <TD>
                    Sawadar Type:
                    <input type="radio" id="PType" name="Type" value="Pathi" required> Pathi
                    <input type="radio" name="Type" value="Karta" required> Karta
                    <input type="radio" name="Type" value="Reader" required> Reader
                </TD>
                <TD>
                    <select required name="Tp" id="Tp" class="txt1">
                        <option value="">Select Transport Profile</option>
                        <option value="TP1">TP1</option>
                        <option value="TP2">TP2</option>
                        <option value="TP3">TP3</option>
                        <option value="TP4">TP4</option>
                    </select>

                </TD>
            </TR>

            <TR>

                <TD height="2">
                    <font color="blue">
                        <small>Current Address</small>
                    </font>
                </TD>

                <TD height="2">
                    <font color="blue">
                        <small>Current State</small>
                    </font>
                </TD>
                <TD height="2">
                    <font color="blue">
                        <small>Current City</small>
                    </font>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input name="Address" id="Address" class="txt1" MAXLENGTH="400" placeholder="Address"/>

                </TD>

                <TD><select required class="txt1" name="State" id="State" onchange="print_city('City', value);">

                    <option value="">Select State</option>

                    <% out.println(HtmlGenerator.getStates(null));%>

                </select>

                </TD>

                <TD>
                    <select required class="txt1" name="City" id="City">
                    </select>

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

                <TD>
                    <select class="txt1" name="Language3" id="Language3">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage());%>

                    </select>

                </TD>

            </TR>
        </TABLE>

        <TABLE cellspacing="3" align="center" style=" width: 75%;" class="table1">
            <TR>
                <TD colspan="4">
                    <font color="blue">
                        <small>Available days of week</small>
                    </font>
                </TD>
            </TR>

            <TR>
                <td>
                    <input type="checkbox" checked name="Avail" value="Mon">Mon<br>
                </td>
                <td>
                    <input type="checkbox" checked name="Avail" value="Tue">Tue<br>
                </td>
                <td>
                    <input type="checkbox" checked name="Avail" value="Wed">Wed<br>
                </td>
                <td>
                    <input type="checkbox" checked name="Avail" value="Thu">Thu<br>
                </td>
                <td>
                    <input type="checkbox" checked name="Avail" value="Fri">Fri<br>
                </td>
                <td>
                    <input type="checkbox" checked name="Avail" value="Sat">Sat<br>
                </td>
                <td>
                    <input type="checkbox" checked name="Avail" value="Sun">Sun<br>
                </td>

            </TR>

        </TABLE>

        <TABLE cellspacing="3" align="center" style=" width: 75%;" class="table1">

            <TR class="blank_row">
                <td>

                </td>

            </TR>

            <TR>
                <TD align="center">
                    <input type="submit" value="Submit"/>
                </TD>
                <TD align="center">
                    <input type="reset" value="Reset">

                </TD>

            </TR>
            <TR class="blank_row">
                <td>

                </td>

            </TR>
        </TABLE>
    </form>
</center>
<%--<script language="javascript">print_state("State");</script>--%>
</body>
</html>
