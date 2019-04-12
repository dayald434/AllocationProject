<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.helper.StaticContent" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.City" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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
                    alert("Satsang Ghar " + value + " is already registered !!");
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
<jsp:include page="menu.jsp"/>
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

    if (!request.getMethod().equalsIgnoreCase("POST")) {
        out.print("This Way is not allowed !!!");
        return;
    }

%>

<%
    ApiHelper apiHelper = new ApiHelper();
    String sgId = request.getParameter("SgId");
    SatsangGhar satsangGhar = apiHelper.getSatsangGharById(sgId);
    Map<String, Schedule> scheduleMap = apiHelper.getScheduleMap(Long.parseLong(sgId));
    City city = StaticContent.getCityObject(satsangGhar.getCity());

%>

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
        <input type="hidden" name="SgId" id="SgId" value='<% out.print(sgId);%>'/>

        <table class="table1" style="width: 70%" align="center">

            <tr>
                <td colspan="2">
                    <input  <%out.println("value='" + satsangGhar.getName() + "'");%> required TITLE="Only Alphbets, Numerals, space , dot(.),  underscore(_) "
                                                                                      name="Name" id="Name" class="txt1" placeholder="Name*" onchange="validateUnique(value)" pattern="[a-zA-Z]{1}[a-zA-Z0-9\s_.]*" minlength="2" maxlength="70" style="text-transform: capitalize;">
                </td>
            </tr>

            <TR>
                <td>
                    <input type="radio" <% out.println(checked(satsangGhar.getCenterType(),"Centre"));%> class="radioBtn" id="no_radio" name="Type" value="Centre"
                           size="10" onChange="disablefield();">Centre
                    <input type="radio" <% out.println(checked(satsangGhar.getCenterType(),"Sub-Centre"));%> class="radioBtn" id="yes_radio" name="Type" value="Sub-Centre" size="10" onChange="disablefield();">Sub-Centre
                    <input type="radio" <% out.println(checked(satsangGhar.getCenterType(),"Point"));%> class="radioBtn" id="yes_radio1" name="Type" value="Point" size="10"
                           onChange="disablefield();">Point
                </td>
                <td>
                    <%
                        List<SatsangGhar> result = apiHelper.searchSatsangGharByPredicate("ctype  ='Centre'");

                        String disabled = "disabled";
                        Long parentCenter = -1l;
                        if (!satsangGhar.getCenterType().equalsIgnoreCase("Centre")) {
                            disabled = "";
                            parentCenter = satsangGhar.getParentCenterid();
                        }

                        String start = "<select " + disabled + " required pattern=\"[a-zA-Z]+\" class=\"txt1\"  id=\"ParentCentre\"  name=\"ParentCentre\"   " +
                                "class=\"field-style field-split align-right\" " +
                                " placeholder=\"Parent Centre*\"/>     >" +
                                "<option value=\"\">Select Parent Centre</option>";

                        String end = "\n</select>";
                        String optionSkeleton = "\n<option %s value=\"%s\"  %s >%s</option>\n";

                        String output = "";
                        for (SatsangGhar ghar : result) {
                            String selected = "";
                            if (parentCenter == ghar.getId())
                                selected = "selected";

                            String optionList = String.format(optionSkeleton, selected, ghar.getId(), "", ghar.getName());
                            output += optionList;
                        }

                        out.println(start + output + end);

                    %>

                </td>

            </TR>

            <TR>
                <TD>
                    <input <%out.println("value='" + satsangGhar.getAddress1() + "'");%> required name="Address1" id="Address1" class="txt1" placeholder="Address1" maxlength="300">
                </TD>
                <TD>
                    <input <%out.println("value='" + satsangGhar.getAddress2() + "'");%> name="Address2" id="Address2" class="txt1" placeholder="Address2" maxlength="300">
                </TD>

            </TR>

            <TR>
                <TD><select required class="txt1" name="State" id="State" onchange="print_city('City', value);">

                    <option value="">Select State</option>

                    <% out.println(HtmlGenerator.getStates(city.getStateCode()));%>

                </select>

                </TD>

                <TD>
                    <select required class="txt1" name="City" id="City">
                        <% out.println(HtmlGenerator.getCities(city));%>
                    </select>

                </TD>

            </TR>

            <TR>
                <TD>
                    <input <%out.println("value='" + satsangGhar.getPinCode() + "'");%> required name="Pincode" title="Please Enter Numbers only. Maximum 6 digits" id="Pincode" class="txt1" placeholder="Pincode" pattern="[0-9]*" maxlength="6">
                </TD>
                <TD>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input <%out.println("value=" + nullToEmpty(satsangGhar.getMobile1()));%> required name="Mobile1" id="Mobile1" title="Please Enter 10 digit mobile number(without prefix 0))" class="txt1" pattern="[1-9]{1}[0-9]{9}" placeholder="Mobile1" minlength="10" maxlength="10"/>

                </TD>
                <TD>
                    <input <%out.println("value=" + nullToEmpty(satsangGhar.getMobile2()));%> name="Mobile2" id="Mobile2" title="Please Enter 10 digit mobile number(without prefix 0)" class="txt1" pattern="[1-9]{1}[0-9]{9}" minlength="10" maxlength="10" placeholder="Mobile2"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input <%out.println("value=" + nullToEmpty(satsangGhar.getLandline1()));%> name="Landline1" id="Landline1" class="txt1" placeholder="Landline1" pattern="[0-9]*" maxlength="13"/>
                </TD>
                <TD>
                    <input <%out.println("value=" + nullToEmpty(satsangGhar.getLandline2()));%> name="Landline2" id="Landline2" class="txt1" placeholder="Landline2" pattern="[0-9]*" maxlength="13"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input <%out.println("value='" + nullToEmpty(satsangGhar.getSecName())+"'");%> REQUIRED TITLE="Only Alphbets, space , dot(.)" name="SecretaryName" id="SecretaryName" class="txt1" placeholder="Secretary/Incharge/Care Taker Name" pattern="[a-zA-Z][.a-zA-Z\s]+" MAXLENGTH="40">
                </TD>
                <TD>
                    <input <%out.println("value=" + nullToEmpty(satsangGhar.getSecMobile()));%> required title="Please Enter 10 digit mobile number(without prefix 0))" pattern="[1-9]{1}[0-9]{9}" name="SecretaryMobile" id="SecretaryMobile" class="txt1" placeholder="Secretary Mobile" MAXLENGTH="10">

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
                    <input  <%out.println( checkSatDay(scheduleMap,"Sun"));%> class="txt2" type="checkbox" name="day" id="Sun" value="Sun" onreset="enableLanguage(value)" onchange="enableLanguage(value)">Sun
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <input  <% out.println(timeValue("Sun",  scheduleMap));%> class="txt2" type="time" required id="SunTime" name="SunTime">
                </td>
            </tr>
            <tr>
                <td class="txt2">
                    <input <%out.println( checkSatDay(scheduleMap,"Mon"));%> class="txt2" type="checkbox" name="day" id="Mon" value="Mon" onclick="enableLanguage(value)">Mon
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <input <% out.println(timeValue("Mon",  scheduleMap));%> class="txt2" type="time" required id="MonTime" name="MonTime">
                </td>
            </tr>

            <tr>
                <td class="txt2">
                    <input <%out.println( checkSatDay(scheduleMap,"Tue"));%> type="checkbox" name="day" value="Tue" id="Tue" onclick="enableLanguage(value)">Tue
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <input <% out.println(timeValue("Tue",  scheduleMap));%> class="txt2" type="time" required id="TueTime" name="TueTime">
                </td>
            </tr>

            <tr>
                <td class="txt2">
                    <input <%out.println( checkSatDay(scheduleMap,"Wed"));%> class="txt2" type="checkbox" name="day" id="Wed" value="Wed" onclick="enableLanguage(value)">Wed
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <input <% out.println(timeValue("Wed",  scheduleMap));%> class="txt2" type="time" required id="WedTime" name="WedTime">
                </td>
            </tr>

            <tr>
                <td class="txt2">
                    <input <%out.println( checkSatDay(scheduleMap,"Thu"));%> class="txt2" type="checkbox" name="day" value="Thu" id="Thu" onclick="enableLanguage(value)">Thu
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <input <% out.println(timeValue("Thu",  scheduleMap));%> class="txt2" type="time" required name="ThuTime" id="ThuTime">
                </td>
            </tr>

            <tr>
                <td class="txt2">
                    <input <%out.println( checkSatDay(scheduleMap,"Fri"));%> class="txt2" type="checkbox" name="day" id="Fri" value="Fri" onclick="enableLanguage(value)">Fri
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <input <% out.println(timeValue("Fri",  scheduleMap));%> class="txt2" type="time" required id="FriTime" name="FriTime">
                </td>
            </tr>

            <tr>
                <TD class="txt2">
                    <input <%out.println( checkSatDay(scheduleMap,"Sat"));%> class="txt2" type="checkbox" name="day" value="Sat" id="Sat" onclick="enableLanguage(value)">Sat
                </TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W1", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W2", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W3", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W4", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W5", scheduleMap));%></TD>
                <td>
                    <input <% out.println(timeValue("Sat",  scheduleMap));%> class="txt2" type="time" required name="SatTime" id="SatTime">
                </td>
            </tr>

        </table>

        <BR>
        <input tabindex=-1 type="submit" class="submit1" value="submit"/>
        <input tabindex=-1 type="reset" class="submit1" name="reset" value="reset" onclick="disablefield1()"/>
    </form>
</center>

</body>
</html>
<%!
    private String timeValue(String day, Map<String, Schedule> scheduleMap) {
        if (scheduleMap.get(day) == null)
            return " disabled ";
        return "value=" + scheduleMap.get(day).getTime();
    }

    private String checkSatDay(Map<String, Schedule> scheduleMap, String day) {
        if (scheduleMap.get(day) != null)
            return "checked";
        else
            return "";
    }

    public String nullToEmpty(Object obj) {
        System.out.println(obj);
        if (null == obj)
            return "\"\"";
        if ("".equalsIgnoreCase(obj.toString()))
            return "\"\"";
        return obj.toString();
    }

    public String checked(String type1, String type2) {

        if (type1.equalsIgnoreCase(type2))
            return "checked=\"checked\"";
        return "";
    }
%>