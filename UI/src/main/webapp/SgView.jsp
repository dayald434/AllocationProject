<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.helper.StaticContent" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.City" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.rssb.common.helper.Util" %>
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

    <script>

        var weeks = ["W1", "W2", "W3", "W4", "W5"];
        var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];


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


        function goBack() {
            window.history.back();
        }
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
        height: 12px;
        font-size: x-small;
    }

</style>

<center>
    <form class="form1" action="SgEdit.jsp" name="RSSBRegistration" method="post">
        <BR>
        <font class="header1"><B class="header1">Satsang Ghar Information</B></font>
        <input type="hidden" name="SgId" id="SgId" value='<% out.print(sgId);%>'/>

        <table class="table1" style="width: 70%" align="center">

            <tr>
                <td><B>Name: </B> <%out.println(satsangGhar.getName()); %></td>

                <td><B>Type: </B> <%out.println(satsangGhar.getCenterType()); %></td>
            </TR>
            <tr>
                <td><B>Parent Center:</B>
                    <%
                        String parent = "";
                        List<SatsangGhar> result = apiHelper.searchSatsangGharByPredicate("ctype  ='Centre'");
                        Long parentCenter = -1l;
                        if (!satsangGhar.getCenterType().equalsIgnoreCase("Centre")) {
                            parentCenter = satsangGhar.getParentCenterid();
                        }

                        for (SatsangGhar ghar : result) {
                            if (parentCenter == ghar.getId()) {
                                parent = ghar.getName();
                                break;
                            }
                        }

                        out.println(parent);

                    %>

                </td>

            </TR>

            <TR>
                <td><B>Secretary Name: </B> <%out.println(nullToEmpty(satsangGhar.getSecName())); %></td>
                <td>
                    <B>Secretary Contact: </B>
                    <%out.println(nullToEmpty(satsangGhar.getSecMobile())); %></td>
            </TR>
            <TR>
                <TD colspan="2"><B>Address :</B>
                    <%out.println(getAddress(satsangGhar));%>
                    <%--<BR>--%>
                    <%--<%out.println(nullToEmpty(satsangGhar.getAddress2()));%>--%>
                    <%--<BR>--%>
                    <%--<%out.println(nullToEmpty(city.getName()) + " , ");%>--%>
                    <%--<%out.println(nullToEmpty(city.getStateName()));%>--%>
                    <%--<BR>--%>
                    <%--<%out.println(nullToEmpty(satsangGhar.getPinCode()));%>--%>

                </TD>
            </TR>
            <BR>
            <TR valign="middle">
                <td valign="middle">
                    <img src="images/mobile.png" alt="Contact: " style="width:10%;height:8%;" align="center">

                    <%out.println(nullToEmpty(satsangGhar.getMobile1())); %>
                    <%out.println(" " + nullToEmpty(satsangGhar.getMobile2())); %></td>

                <td valign="middle">
                    <img src="images/land.png" alt="Contact: " style="width:15%;height:8%;" align="center">

                    <%out.println(nullToEmpty(satsangGhar.getLandline1())); %>
                    <%out.println(" " + nullToEmpty(satsangGhar.getLandline2())); %></td>

            </TR>

            <TR>
                <td></td>
                <td></td>
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

            <tr align="center">
                <td>
                    Sun
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sun", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sun", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sun", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sun", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sun", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <% out.println(printTime("Sun", scheduleMap));%>

                </td>
            </tr>
            <tr align="center">
                <td> Mon
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Mon", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Mon", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Mon", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Mon", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Mon", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <% out.println(printTime("Mon", scheduleMap));%>
                </td>
            </tr>

            <tr align="center">
                <td>
                    Tue
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Tue", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Tue", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Tue", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Tue", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Tue", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <% out.println(printTime("Tue", scheduleMap));%>
                </td>
            </tr>

            <tr align="center">
                <td>
                    Wed
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Wed", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Wed", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Wed", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Wed", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Wed", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <% out.println(printTime("Wed", scheduleMap));%>
                </td>
            </tr>

            <tr align="center">
                <td>
                    Thu
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Thu", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Thu", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Thu", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Thu", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Thu", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <% out.println(printTime("Thu", scheduleMap));%>
                </td>
            </tr>

            <tr align="center">
                <td>
                    Fri
                </td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Fri", "txt2", "W1", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Fri", "txt2", "W2", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Fri", "txt2", "W3", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Fri", "txt2", "W4", scheduleMap));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Fri", "txt2", "W5", scheduleMap));%></td>
                <td>
                    <% out.println(printTime("Fri", scheduleMap));%>

                </td>
            </tr>

            <tr align="center">
                <TD>
                    Sat
                </TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sat", "txt2", "W1", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sat", "txt2", "W2", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sat", "txt2", "W3", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sat", "txt2", "W4", scheduleMap));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguageToDisplay("Sat", "txt2", "W5", scheduleMap));%></TD>
                <td>
                    <% out.println(printTime("Sat", scheduleMap));%>

                </td>
            </tr>

        </table>

        <BR>
        <button onclick="goBack()">View Other Satsang Ghar</button>

        <input tabindex=-1 type="submit" class="submit1" value="Edit Satsang Ghar"/>
    </form>
</center>

</body>
</html>
<%!

    private String printTime(String day, Map<String, Schedule> scheduleMap) {
        if (scheduleMap.get(day) == null)
            return "";
        return Util.truncateTime(scheduleMap.get(day).getTime());
    }

    public String nullToEmpty(String obj) {
        if (null == obj || "null".equalsIgnoreCase(obj))
            return "";
        return obj.toString();
    }

    public String getAddress(SatsangGhar satsangGhar) {

        String addr1 = satsangGhar.getAddress1();
        String addr2 = satsangGhar.getAddress2();
        City cityObject = StaticContent.getCityObject(satsangGhar.getCity());
        String city = cityObject.getName();
        String state = cityObject.getStateName();
        String pin = satsangGhar.getPinCode();

        String completeAddress = "";
        if (!checkEmpty(addr1)) {
            completeAddress += addr1 + "<BR>";
        }
        if (!checkEmpty(addr2)) {
            completeAddress += addr2 + "<BR>";
        }
        if (!checkEmpty(city) && !checkEmpty(state)) {
            completeAddress += city + ", " + state;
        } else if (!checkEmpty(city)) {
            completeAddress += city;
        } else if (!checkEmpty(state)) {
            completeAddress += state;
        }

        if (!"0".equalsIgnoreCase(pin) && checkEmpty(pin)) {
            completeAddress += "<BR>" + pin;
        }

        System.out.println(completeAddress);
        return completeAddress;
    }

    public boolean checkEmpty(String s) {
        if (null == s)
            return true;
        if ("null".equalsIgnoreCase(s))
            return true;
        return Strings.isNullOrEmpty(s);
    }

    public String nullToEmpty(Long obj) {
        if (null == obj)
            return "";
        return obj.toString();
    }

    public String checked(String type1, String type2) {

        if (type1.equalsIgnoreCase(type2))
            return "checked=\"checked\"";
        return "";
    }
%>