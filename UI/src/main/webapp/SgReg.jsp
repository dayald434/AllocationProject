<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: devi
  Date: 30/7/17
  Time: 5:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/city.js"></script>
    <script src="js/common.js"></script>

    <script>

        var weeks = ["W1", "W2", "W3", "W4", "W5"];
        var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];



         function validateUnique(value) {
            if (value != '') {
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("POST", "SgName.jsp?SgName=" + value.toUpperCase(), false); // false for synchronous request
                xmlHttp.send(null);
                res = xmlHttp.responseText;
                if (res.trim().toLowerCase() == 'false') {
                    alert("Satsang Ghar " + value +" is already registered !!");
                    document.RSSBRegistration.Name.value = ""
                    document.RSSBRegistration.Name.focus();


                }
            }

        }


        function validate() {
            var satsangGharName = document.RSSBRegistration.Name.value;
            if (satsangGharName == null || satsangGharName == "") {
                alert("Please Enter Satsang Ghar Name");
                document.RSSBRegistration.Name.focus();
                return false;
            }
            var letterNumber = "^[a-zA-z][0-9a-zA-Z\s]";
            if (!satsangGharName.match(letterNumber) && satsangGharName.length >= 100) {
                alert("Please Enter Correct Satsang Ghar Name");
                document.RSSBRegistration.Name.focus();
                return false;
            }

            if (( RSSBRegistration.Type[0].checked == false ) && ( RSSBRegistration.Type[1].checked == false ) && ( RSSBRegistration.Type[2].checked == false )) {
                alert("Please must choose your Centre Type");
                return false;
            }
            if ((document.RSSBRegistration.ParentCentre.value == "") && (RSSBRegistration.Type[0].checked == false)) {
                alert("Please provide your ParentCentre!");
                document.RSSBRegistration.ParentCentre.focus();
                return false;
            }

            var satsangAddress1 = document.RSSBRegistration.Address1.value;
            if (satsangAddress1 == null || satsangAddress1 == "") {
                alert("Please provide Centre Address!");
                document.RSSBRegistration.Address1.focus();
                return false;
            }
            var letterNumber = "^[a-zA-Z0-9.#,@;]";
            if (!satsangAddress1.match(letterNumber) || satsangAddress1.length >= 100) {
                alert("Please Enter Correct Address:1");
                document.RSSBRegistration.Address1.focus();
                return false;
            }

            var satsangGharCity = document.RSSBRegistration.City.value;
            if (satsangGharCity == null || satsangGharCity == "") {
                alert("Please provide your City!");
                document.RSSBRegistration.City.focus();
                return false;
            }
            var letterNumber = "[a-zA-Z]";
            if (!satsangGharCity.match(letterNumber) || satsangGharCity.length >= 100) {
                alert("Please provide Correct City!");
                document.RSSBRegistration.City.focus();
                return false;
            }

            var satsangGharState = document.RSSBRegistration.State.value;
            if (satsangGharState == null || satsangGharState == "") {
                alert("Please provide State!");
                document.RSSBRegistration.State.focus();
                return false;
            }
            var letterNumber = "[a-zA-z]";
            if (!satsangGharState.match(letterNumber) || satsangGharState.length >= 100) {
                alert("Please provide Correct State!");
                document.RSSBRegistration.State.focus();
                return false;
            }

            var mobileNumber = document.RSSBRegistration.Mobile1.value;
            if (mobileNumber == null || mobileNumber == "") {
                alert("Please Provide Mobile:1");
                document.RSSBRegistration.Mobile1.focus();
                return false;
            }
            var mobileNumber1 = document.RSSBRegistration.Mobile2.value;
            var letterNumber = "[0-9]";
            if (mobileNumber.match(letterNumber) && mobileNumber.length != 10) {
                alert("Please Provide Correct Mobile Number");
                document.RSSBRegistration.Mobile2.focus();
                return false;
            }

            var letterNumber = "[0-9]";
            if (mobileNumber.match(letterNumber) && mobileNumber.length != 10) {
                alert("Please Provide Correct Mobile Number");
                document.RSSBRegistration.Mobile1.focus();
                return false;
            }


            var secretaryName = document.RSSBRegistration.SecretaryName.value;
            if (secretaryName == null || secretaryName == "") {
                alert("Please provide Secretary Name");
                document.RSSBRegistration.SecretaryName.focus();
                return false;
            }

            var letterNumber = "[a-zA-Z]";
            if (!secretaryName.match(letterNumber)) {
                alert("Please Provide Correct Secretary Name");
                document.RSSBRegistration.SecretaryName.focus();
                return false;
            }

            var secretaryMobile = document.RSSBRegistration.SecretaryMobile.value;
            if (secretaryMobile == null || secretaryMobile == "") {
                alert("Please Enter Secretary Mobile Number");
                document.RSSBRegistration.SecretaryMobile.focus();
                return false;
            }

            var letterNumber = "[0-9]";
            if (secretaryMobile.match(letterNumber) && mobileNumber.length != 10) {
                var letterNumber = "[0-9]";
                if (secretaryMobile.match(letterNumber) || secretaryMobile.length < 10 || secretaryMobile.length > 10) {
                    alert("Please Enter Correct Secretary Mobile Number");
                    document.RSSBRegistration.SecretaryMobile.focus();
                    return false;
                }
            }


            var daysCount = 0;

            for (i = 0; i < days.length; i++) {
                if (document.getElementById(days[i]).checked == '1') {
                    daysCount++;
                }
            }

            if (daysCount == 0) {
                alert("Select at least One Satsang day");
                return false;
            }


            for (i = 0; i < days.length; i++) {
                if (document.getElementById(days[i]).checked == '1') {
                    for (j = 0; j < weeks.length; j++) {
                        {

                            if (document.getElementById(days[i] + weeks[j]).value == '') {
                                alert("Select Language for Week " + weeks[j] + " of the " + days[i]);
                                return false;
                            }


                        }
                    }
                }
            }


        }


        function enableLanguage(day) {


            if (document.getElementById(day).checked == 1) {
                document.getElementById(day + "W1").disabled = '';
                document.getElementById(day + "W2").disabled = '';
                document.getElementById(day + "W3").disabled = '';
                document.getElementById(day + "W4").disabled = '';
                document.getElementById(day + "W5").disabled = '';
                document.getElementById(day + "Time").disabled = '';

            }
            else {
                document.getElementById(day + "W1").disabled = 'disabled';
                document.getElementById(day + "W2").disabled = 'disabled';
                document.getElementById(day + "W3").disabled = 'disabled';
                document.getElementById(day + "W4").disabled = 'disabled';
                document.getElementById(day + "W5").disabled = 'disabled';
                document.getElementById(day + "Time").disabled = 'disabled';

            }


        }

        function disablefield() {
            if (document.getElementById('no_radio').checked == 1) {
                document.getElementById('ParentCentre').disabled = 'disabled';
                document.getElementById('ParentCentre').value = '';
            } else {
                document.getElementById('ParentCentre').disabled = '';
            }
        }

        function disablefield1() {
            document.getElementById('ParentCentre').disabled = 'disabled';

            for (i = 0; i < days.length; i++) {
                for (j = 0; j < weeks.length; j++) {
                    document.getElementById(days[i] + weeks[j]).disabled = 'disabled';
                }
                document.getElementById(days[i] + "Time").disabled = 'disabled';
            }

        }

        window.onload = disablefield1
    </script>

    <script>
        $(document).ready(function () {
            $('#RSSBRegistration').formValidation({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    message: {
                        // The messages for this field are shown as usual
                        validators: {
                            notEmpty: {
                                message: 'The message is required'
                            },
                            stringLength: {
                                min: 20,
                                max: 500,
                                message: 'The message must be more than 20 and less than 500 characters long'
                            }
                        }
                    },
                    name: {
                        // Show the message in a tooltip
                        err: 'tooltip',
                        validators: {
                            notEmpty: {
                                message: 'The Name  is required'
                            }

                        }
                    }
                }
            });
        });
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

<style>
    .txt1 {
        width: 200px;
        height: 20px;
    }

    .txt2 {
        height: 20px;
        font-size: small;
    }

</style>

<center>
    <form class="form1" action="SgSave.jsp" name="RSSBRegistration" method="post" onsubmit="return(validate());">
        <BR>
        <font class="header1"><B class="header1">Satsang Ghar Registration</B></font>

        <table class="table1" style="width: 70%" align="center">

            <%-- Item 1--%>
            <tr>
                <td colspan="2">
                    <input required TITLE="Only Alphbets, Numerals, space , dot(.),  underscore(_) "
                           name="Name" id="Name" class="txt1" placeholder="Name*" onchange="validateUnique(value)" pattern="[a-zA-Z]{1}[a-zA-Z0-9\s_.]*" minlength="2" maxlength="70" style="text-transform: capitalize;">
                </td>
            </tr>

            <%-- Item 2--%>
            <TR>
                <td>
                    <input type="radio" class="radioBtn" id="no_radio" name="Type" value="Centre"
                           size="10" onChange="disablefield();" checked="checked">Centre
                    <input type="radio" class="radioBtn" id="yes_radio" name="Type" value="Sub-Centre" size="10"
                           onChange="disablefield();">Sub-Centre
                    <input type="radio" class="radioBtn" id="yes_radio1" name="Type" value="Point" size="10"
                           onChange="disablefield();">Point
                </td>
                <td>
                    <%
                        ApiHelper apiHelper = new ApiHelper();
                        List<SatsangGhar> result = apiHelper.searchSatsangGharByPredicate("ctype  ='Centre'");

                        String start = "<select required pattern=\"[a-zA-Z]+\" class=\"txt1\"  id=\"ParentCentre\"  name=\"ParentCentre\"   " +
                                "class=\"field-style field-split align-right\" " +
                                " placeholder=\"Parent Centre*\"/>     >" +
                                "<option value=\"\">Select Parent Centre</option>";

                        String end = "\n</select>";
                        String optionSkeleton = "\n<option value=\"%s\"  %s >%s</option>\n";

                        String output = "";
                        for (SatsangGhar ghar : result) {
                            String optionList = String.format(optionSkeleton, ghar.getId(), "", ghar.getName());
                            output += optionList;
                        }

                        out.println(start + output + end);

                    %>

                </td>

            </TR>

            <%-- Item 3--%>

            <TR>
                <TD>
                    <input required name="Address1" id="Address1" class="txt1" placeholder="Address1" maxlength="300">
                </TD>
                <TD>
                    <input name="Address2" id="Address2" class="txt1" placeholder="Address2" maxlength="300">
                </TD>

            </TR>

            <TR>

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
                    <TD>
                        <input required name="Pincode" title="Please Enter Numbers only. Maximum 6 digits" id="Pincode" class="txt1" placeholder="Pincode" pattern="[0-9]*"  maxlength="6">
                    </TD>
                    <TD>
                    </TD>

                </TR>

            <TR>
                <TD>
                    <input required name="Mobile1" id="Mobile1" title="Please Enter 10 digit mobile number(without prefix 0))" class="txt1" pattern="[1-9]{1}[0-9]{9}" placeholder="Mobile1" minlength="10" maxlength="10"/>

                </TD>
                <TD>
                    <input name="Mobile2" id="Mobile2" title="Please Enter 10 digit mobile number(without prefix 0)" class="txt1" pattern="[1-9]{1}[0-9]{9}" minlength="10" maxlength="10" placeholder="Mobile2"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input name="Landline1" id="Landline1" class="txt1" placeholder="Landline1" pattern="[0-9]*" maxlength="13"/>
                </TD>
                <TD>
                    <input name="Landline2" id="Landline2" class="txt1" placeholder="Landline2" pattern="[0-9]*" maxlength="13"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input REQUIRED TITLE="Only Alphbets, space , dot(.)" name="SecretaryName" id="SecretaryName" class="txt1" placeholder="Secretary/Incharge/Care Taker Name" pattern="[a-zA-Z][.a-zA-Z\s]+" MAXLENGTH="40">
                </TD>
                <TD>
                    <input required title="Please Enter 10 digit mobile number(without prefix 0))" pattern="[1-9]{1}[0-9]{9}" name="SecretaryMobile" id="SecretaryMobile" class="txt1" placeholder="Secretary Mobile" MAXLENGTH="10">

                </TD>

            </TR>

        </table>

        <table class="table2" style="width:96%; align-content: center; ">

            <tr bgcolor="#d3d3d3">
                <th class="header2">Day</th>
                <th class="header2">Week1</th>
                <th class="header2">Week2</th>
                <th class="header2">Week3</th>
                <th class="header2">Week4</th>
                <th class="header2">Week5</th>
                <th class="header2">Time</th>
            </tr>

            <tr>
                <td class="txt2">
                    <input class="txt2" type="checkbox" name="day" id="Sun" value="Sun" onreset="enableLanguage(value)" onchange="enableLanguage(value)">Sun
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W5"));%></td>
                <td><input class="txt2" type="time" required id="SunTime" name="SunTime"></td>
            </tr>
            <tr>
                <td class="txt2">
                    <input class="txt2" type="checkbox" name="day" id="Mon" value="Mon" onclick="enableLanguage(value)">Mon
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W5"));%></td>
                <td><input class="txt2" type="time" required id="MonTime" name="MonTime"></td>
            </tr>

            <tr>
                <td class="txt2"><input type="checkbox" name="day" value="Tue" id="Tue" onclick="enableLanguage(value)">Tue
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W5"));%></td>
                <td><input class="txt2" type="time" required id="TueTime" name="TueTime"></td>
            </tr>

            <tr>
                <td class="txt2">
                    <input class="txt2" type="checkbox" name="day" id="Wed" value="Wed" onclick="enableLanguage(value)">Wed
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W5"));%></td>
                <td><input class="txt2" type="time" required id="WedTime" name="WedTime"></td>
            </tr>

            <tr>
                <td class="txt2">
                    <input class="txt2" type="checkbox" name="day" value="Thu" id="Thu" onclick="enableLanguage(value)">Thu
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W5"));%></td>
                <td><input class="txt2" type="time" required name="ThuTime" id="ThuTime"></td>
            </tr>

            <tr>
                <td class="txt2">
                    <input class="txt2" type="checkbox" name="day" id="Fri" value="Fri" onclick="enableLanguage(value)">Fri
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W5"));%></td>
                <td><input class="txt2" type="time" required id="FriTime" name="FriTime"></td>
            </tr>

            <tr>
                <TD class="txt2">
                    <input class="txt2" type="checkbox" name="day" value="Sat" id="Sat" onclick="enableLanguage(value)">Sat
                </TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W1"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W2"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W3"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W4"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W5"));%></TD>
                <td><input class="txt2" type="time" required name="SatTime" id="SatTime"></td>
            </tr>

        </table>

        <BR>
        <input tabindex=-1 type="submit" class="submit1" value="submit"/>
        <input tabindex=-1 type="reset" class="submit1" name="reset" value="reset" onclick="disablefield1()"/>
    </form>
</center>

</body>
</html>
