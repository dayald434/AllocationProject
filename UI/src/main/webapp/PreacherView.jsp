<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.StaticContent" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.City" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="com.rssb.common.entity.Attendance" %>

<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/common.js"></script>

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

        function goBack() {
            window.history.back();
        }

    </script>

</head>
<body bgcolor="#fffff0">
<jsp:include page="menu.jsp"/>
<%!
    public String checked(String sex1, String sex2) {

        if (sex1.equalsIgnoreCase(sex2))
            return "checked=\"checked\"";
        return "";
    }

    public String nullToEmpty(Object obj) {
        if (null == obj)
            return "";
        return obj.toString();
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

    if (!request.getMethod().equalsIgnoreCase("POST")) {
        out.print("This Way is not allowed !!!");
        return;
    }


    ApiHelper apiHelper = new ApiHelper();
    String oldShortName = request.getParameter("ShortName");
    Preacher preacher = apiHelper.getPreacherByShortName(oldShortName);
    City city = StaticContent.getCityObject(preacher.getCity());
    SatsangGhar sg = apiHelper.getSatsangGharById("" + preacher.getSgId());

%>

<center>

    <form class="form1" action="PreacherEdit.jsp" method="post" name="PreacherForm">
        <BR>
        <font class="header1"><B class="">Sewadar Information</B></font>

        <TABLE cellspacing="3" align="center" style="height:50%; border: none; width: 90%;" class="table1">

            <TR>
                <TD><B>Name :</B> <%out.println(preacher.getName());%>

                    <%--<input readonly <%out.println("value='" + preacher.getName() + "'");%> TITLE="Only Alhabets space and dot (.) " name="Name" id="fullName" class="txt1" MAXLENGTH="40" placeholder="Full Name" pattern="[a-zA-Z][.a-zA-Z\s]*" ng-pattern-restrict style="text-transform: capitalize;"/>--%>

                </TD>
                <TD><B>Short Name : </B><%out.println(preacher.getShortName());%>
                    <input readonly type="hidden" <%out.println("value='" + preacher.getShortName() + "'");%> name="ShortName" id="ShortName"/>
                    <input readonly type="hidden" name="OldShortName" id="OldShortName" value='<% out.print(oldShortName);%>'/>

                </TD>

                <TD><B>Associated Satasang Ghar :</B> <%out.println(sg.getName());%>

                    </select>
                </TD>
            </TR>

            <TR>

                <TD><B>Mobile 1:</B> <I><%out.println(nullToEmpty(preacher.getMobile1())); %></I>
                    <%--<input readonly <%out.println("value='" + nullToEmpty(preacher.getMobile1()) + "'"); %> name="Mobile1" id="Mobile1" class="txt1" maxlength="10" class="field-style field-full align-none" placeholder="Mobile 1"/>--%>

                </TD>
                <TD><B>Home/Mobile 2:</B><I></I> <%out.println(nullToEmpty(preacher.getMobile2())); %></I>
                    <%--<input readonly  <%out.println("value='" + nullToEmpty(preacher.getMobile2()) + "'"); %> name="Mobile2" id="Mobile2" class="txt1" placeholder="Home/Mobile 2" maxlength="10"/>--%>

                </TD>

                <TD><B>Initiation Date: </B><%out.println(nullToEmpty(preacher.getIniDate())); %>
                    <font color="blue">
                        <%--<input readonly <%out.println("value=\""+outDateFormat.format(inDateFormat.parse(preacher.getIniDate()))+"\"");%> TITLE="Enter Initiation Date" class="txt1" name="InitDate" id="InitDate" type="date" max="" placeholder="Select Initiation Date">--%>
                        <%--<small>Initiation Date</small>--%>
                    </font>
                </TD>

            </TR>

            <TR>
                <TD>
                    <B>Sex: </B><% out.println(preacher.getSex());%>

                </TD>

                <TD>
                    <B>Sawadar Type:</B> <% out.println(preacher.getType());%>
                </TD>
                <TD>
                    <B> Transport Profile: </B><%out.println(nullToEmpty(preacher.getTp())); %>
                </TD>
            </TR>

            <%--<TR>--%>

            <%--<TD height="2">--%>
            <%--<font color="blue">--%>
            <%--<small>Current Address</small>--%>
            <%--</font>--%>
            <%--</TD>--%>

            <%--<TD height="2">--%>
            <%--<font color="blue">--%>

            <%--</font>--%>
            <%--</TD>--%>
            <%--<TD height="2">--%>
            <%--<font color="blue">--%>
            <%--<small>Current City</small>--%>
            <%--</font>--%>
            <%--</TD>--%>

            <%--</TR>--%>

            <TR>
                <TD colspan="3"><B>Address :</B>

                    <%--<font color="blue">--%>
                    <%--<small>Current Address</small>--%>
                    <%--</font>--%>
                    <%out.println(nullToEmpty(preacher.getAddress()));%>
                    <BR>

                    <%out.println(nullToEmpty(city.getName() + " , "));%>

                    <%out.println(nullToEmpty(city.getStateName()));%>

                    <%--<input name="Address" readonly <%out.println("value='" + nullToEmpty(preacher.getAddress()) + "'");%> id="Address" class="txt1" MAXLENGTH="400" placeholder="Address"/>--%>

                    <%--</TD>--%>

                    <%--<TD>--%>
                    <%--<input name="State" readonly <%out.println("value='" + nullToEmpty(city.getStateName()) + "'");%> id="State" class="txt1" MAXLENGTH="400" placeholder="State"/>--%>

                    <%--</TD>--%>

                    <%--<TD>--%>
                    <%--<input name="City" readonly <%out.println("value='" + nullToEmpty(city.getName()) + "'");%> id="City" class="txt1" MAXLENGTH="400" placeholder="City"/>--%>

                </TD>
            </TR>

            <%--<TR>--%>
            <%--<TD height="3">--%>
            <%--<font color="blue">--%>
            <%--<small>Languages</small>--%>
            <%--</font>--%>
            <%--</TD>--%>

            <%--</TR>--%>

            <TR>
                <TD colspan="3"><B>Languages: </B> <%
                    for (String lang : preacher.getLang()) {
                        if (!Strings.isNullOrEmpty(lang) && !lang.equalsIgnoreCase("\"\""))
                            out.println(lang + " ");
                    }
                %>
                    <%--<select disabled class="txt1" name="Language1" id="Language1">--%>
                    <%--<option value="">Language</option>--%>
                    <%--<% out.println(HtmlGenerator.getLanguage(preacher.getLang()[0]));%>--%>

                    <%--</select>--%>

                    <%--</TD>--%>

                    <%--<TD>--%>
                    <%--<select disabled class="txt1" name="Language2" id="Language2">--%>
                    <%--<option value="">Language</option>--%>
                    <%--<% out.println(HtmlGenerator.getLanguage(preacher.getLang()[1]));%>--%>
                    <%--</select>--%>

                    <%--</TD>--%>

                    <%--<TD>--%>
                    <%--<select disabled class="txt1" name="Language3" id="Language3">--%>
                    <%--<option value="">Language</option>--%>
                    <%--<% out.println(HtmlGenerator.getLanguage(preacher.getLang()[2]));%>--%>

                    <%--</select>--%>

                </TD>

            </TR>

            <%--</TABLE>--%>

            <%--<TABLE cellspacing="3" align="center" style=" width: 75%;" class="table1">--%>
            <%--<TR>--%>
            <%--<TD colspan="3">--%>
            <%--<font color="blue">--%>
            <%--<small>Available days of week</small>--%>
            <%--</font>--%>
            <%--</TD>--%>
            <%--</TR>--%>

            <TR>
                <TD colspan="3"><B> Available days of week </B>
                    <%
                        out.print("<PRE>");
                        String[] days = preacher.getAvailableDays();
                        if (days != null)
                            for (String day : days) {
                                System.out.println(day);
                                if (!Strings.isNullOrEmpty(day)) {
                                    out.print(day + "   ");
                                }
                            }
                        else
                            out.println("None of the days");
                    %>
                </TD>

            </TR>

        </TABLE>

        <TABLE cellspacing="3" align="center" style=" width: 75%;" class="table1">

            <TR>
                <TD align="center">
                    <button onclick="goBack()">View Other Preacher</button>

                </TD>
                <TD align="center">
                    <input tabindex="-1" type="submit" value="Edit Preacher">

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
