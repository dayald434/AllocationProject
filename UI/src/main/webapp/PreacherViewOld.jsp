<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
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
            return "\"\"";
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

    SimpleDateFormat inDateFormat = new SimpleDateFormat("dd-MMM-yyyy");
    SimpleDateFormat outDateFormat = new SimpleDateFormat("yyyy-MM-dd");

    ApiHelper apiHelper = new ApiHelper();
    String oldShortName = request.getParameter("ShortName");
    Preacher preacher = apiHelper.getPreacherByShortName(oldShortName);

%>

<center>

    <form class="form1" action="PreacherEdit.jsp" method="post" name="PreacherForm">
        <BR>
        <font class="header1"><B class="">Sewadar Information</B></font>

        <TABLE align="center" style="height:70%; border: none" class="table1">

            <TR>
                <TD>
                    <input readonly <%out.println("value='" + preacher.getName() + "'");%> TITLE="Only Alhabets space and dot (.) " name="Name" id="fullName" class="txt1" MAXLENGTH="40" placeholder="Full Name" pattern="[a-zA-Z][.a-zA-Z\s]*" ng-pattern-restrict style="text-transform: capitalize;"/>

                </TD>
                <TD>
                    <input readonly <%out.println("value='" + preacher.getShortName() + "'");%> TITLE="Only Alphabets" name="ShortName" id="ShortName" class="txt1" MAXLENGTH="4" placeholder="Short Name" pattern="[a-zA-Z][a-zA-Z]+" ng-pattern-restrict style="text-transform:uppercase"/>
                    <input readonly type="hidden" name="OldShortName" id="OldShortName" value='<% out.print(oldShortName);%>'/>

                </TD>

            </TR>

            <TR>
                <TD>
                    <select disabled name="SgId" id="SgId" class="txt1">
                        <option value="">Select Associated Satsang Ghar of Sewadar</option>

                        <%
                            String selected = "selected=\"selected\"";

                            String optionSkeleton = "<option  value=\"%s\" %s >%s</option>";
                            List<SatsangGhar> list = apiHelper.getAllSatsangGhar();
                            for (int i = 0; i < list.size(); i++) {
                                String sel = "";
                                if (list.get(i).getId().equals(preacher.getSgId()))
                                    sel = selected;

                                String s = String.format(optionSkeleton, list.get(i).getId(), sel, list.get(i).getName());
                                out.println(s);
                            }
                        %>
                    </select>
                </TD>
                <TD>
                    <font color="blue">
                        <input readonly <%out.println("value=\""+outDateFormat.format(inDateFormat.parse(preacher.getIniDate()))+"\"");%> TITLE="Enter Initiation Date" class="txt1" name="InitDate" id="InitDate" type="date" max="" placeholder="Select Initiation Date">
                        <small>Initiation Date</small>
                    </font>
                </TD>

            </TR>
            <TR>

                <TD>
                    <input readonly <% out.println("value=" + nullToEmpty(preacher.getMobile1()));%> name="Mobile1" id="Mobile1" class="txt1" maxlength="10" class="field-style field-full align-none" placeholder="Mobile 1"/>

                </TD>
                <TD>
                    <input readonly  <%out.println("value=" + nullToEmpty(preacher.getMobile2()));%> name="Mobile2" id="Mobile2" class="txt1" placeholder="Mobile 2" maxlength="10"/>

                </TD>

            </TR>

            <TR>
                <TD>
                    Sex:
                    <input disabled type="radio" <% out.println(checked(preacher.getSex(),"M"));%> id="Sex" class="radioBtn" name="Sex" value="M" size="10" checked="checked">Male
                    <input disabled type="radio" <% out.println(checked(preacher.getSex(),"F"));%> class="radioBtn" name="Sex" value="F" size="10">Female
                    <input disabled type="radio" <% out.println(checked(preacher.getSex(),"O"));%> class="radioBtn" name="Sex" value="O" size="10">
                    Other
                </TD>
            </TR>
            <TR>
                <TD>
                    Sawadar Type:
                    <input disabled type="radio" <% out.println(checked(preacher.getType(),"Pathi"));%> id="PType" name="Type" value="Pathi" required>
                    Pathi
                    <input disabled type="radio" <% out.println(checked(preacher.getType(),"Karta"));%> name="Type" value="Karta" required>
                    Karta
                    <input disabled type="radio" <% out.println(checked(preacher.getType(),"Reader"));%> name="Type" value="Reader" required>
                    Reader
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
                    <select disabled class="txt1" name="Language1" id="Language1">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage(preacher.getLang()[0]));%>

                    </select>

                </TD>

                <TD>
                    <select disabled class="txt1" name="Language2" id="Language2">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage(preacher.getLang()[1]));%>
                    </select>

                </TD>
            </TR>
            <TR>
                <TD>
                    <select disabled class="txt1" name="Language3" id="Language3">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage(preacher.getLang()[2]));%>

                    </select>

                </TD>
                <TD>
                    <select disabled class="txt1" name="Language4" id="Language4">
                        <option value="">Language</option>
                        <% out.println(HtmlGenerator.getLanguage(preacher.getLang()[3]));%>

                    </select>

                </TD>

            </TR>

            <TR class="blank_row">
                <td>

                </td>

            </TR>

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
