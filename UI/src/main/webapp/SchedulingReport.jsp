<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.StaticContent" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Allocation" %>
<%@ page import="com.rssb.common.entity.CD" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="com.rssb.common.helper.Util" %>
<%@ page import="org.apache.commons.lang.WordUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>

<head>
    <meta charset="utf-8">

    <link rel="stylesheet" href="css/style.css"/>
    <script src="js/common.js"></script>


    <style>
        .cl1 {
            background-color: ivory;
            border: hidden;
        }

        .cl2 {
            background-color: lightgray;
            border: hidden;
        }

    </style>

    <style type="text/css" media="print">
        /*@page {*/
        /*size: auto;   !* auto is the initial value *!*/
        /*margin: 0;  !* this affects the margin in the printer settings *!*/
        /*}*/

        /*body {*/
        /*transform: scale(.9);*/
        /*}*/

        .onlyprint {
            display: none;
        }

        @media print {
            .onlyprint {
                display: block;
            }
        }

    </style>


<script>




</script>

</head>

<body>




<script>
    function topFunction() {
        document.body.scrollTop = 100; // For Chrome, Safari and Opera
        document.documentElement.scrollTop = 0; // For IE and Firefox
    }

    window.onload = topFunction();

</script>

<div id="print">
    <br>

    <center>

        <%
            ApiHelper apiHelper = new ApiHelper();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");

            String action = request.getParameter("Action");
            if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Load"))
                return;

            Long sgId = getLong(request.getParameter("SgId"));

            if (null == sgId) {
                out.println("Please  Satsang Ghar name ");
                return;
            }

            String startDate = request.getParameter("StartDate");
            if (Strings.isNullOrEmpty(startDate)) {
                out.println("Please select Start Date ");
                return;
            }

            String endDate = request.getParameter("EndDate");
            if (Strings.isNullOrEmpty(endDate)) {
                out.println("Please select End Date ");
                return;
            }

            List<Date> dateList = apiHelper.getDates(sgId, startDate, endDate);

            if (dateList.size() == 0) {
                out.println("No Satsang day between " + startDate + " and " + endDate);
                return;
            }

            SatsangGhar sg = apiHelper.searchSatsangGharByid(sgId);

            String sgNameHt = "<font class=\"header1\"><B class=\"\">  Satsang Schedule For %s from %s to %s </B></font>";

            out.print(String.format(sgNameHt, WordUtils.capitalize(sg.getName()), sdf.format(inputFormat.parse(startDate)), sdf.format(inputFormat.parse(endDate))));
            int numberOfPathis = sg.getNumberOfPathis();
            boolean isStagePathiAlsoGround = sg.getIsStagePathiAlsoGround();

            int colspan = numberOfPathis;
            if (isStagePathiAlsoGround)
                colspan++;

        %>
        <br>
        <br>

        <table border="1" style="width:70%">

            <tr bgcolor="#a9a9a9">
                <th align="center"> Date</th>
                <th align="center"> Day/Time</th>
                <th align="center"> Lang</th>
                <th align="center"> Preacher</th>

                <%
                    String th = "<th align=\"center\">%s</th>\n";
                    out.println(String.format(th, "Stage Pathi "));

                    int startInd = 1;
                    if (sg.getIsStagePathiAlsoGround()) {
                        out.println(String.format(th, "Ground Pathi " + startInd++));
                    }

                    for (int i = 2; i <= numberOfPathis; i++) {
                        out.println(String.format(th, "Ground Pathi " + startInd++));
                    }

                %>

            </tr>
            <tr>

            </tr>

            <%
                String td = "<td align=\"left\" nowrap>";
                Map<String, String> contrMap = apiHelper.getShortNameMap();
                Map<String, Allocation> allocationMap = apiHelper.getAllocationMap(sgId, startDate, endDate);
                Map<String, Schedule> sMap = apiHelper.getScheduleMap(sgId);

                String color1 = "bgcolor=\"#d3d3d3\"";
                String color2 = "";

                int lastWeek = 0;
                String color = color1;

                for (int i = 0; i < dateList.size(); i++) {
                    Date date = dateList.get(i);
                    int week = Util.getWeek(date.getDate());
                    if (lastWeek != week) {
                        if (color.equalsIgnoreCase(color1)) {
                            color = color2;
                        } else {
                            color = color1;
                        }
                        lastWeek = week;
                    }

                    String dateString = sdf.format(date);
                    String day = Util.dateToDayMap.get(dateString);
                    Schedule schedule = sMap.get(day);
                    String lang = schedule.getLang()[week - 1];
                    Allocation allocation = allocationMap.get(dateString);
                    String preacher = Util.getPreacherName(allocation, contrMap);
                    if (Strings.isNullOrEmpty(preacher))
                        preacher = "Not Allocated";

                    out.println("<TR " + color + " >");
                    out.println(td + dateString + "</TD>");
                    out.println(td + day + "(" + schedule.getTime().substring(0, 5) + ")" + "</TD>");
                    out.println(td + lang + "</TD>");

                    if ("CD".equalsIgnoreCase(lang)) {
                        CD cd = Util.getCD(allocation, StaticContent.cdMap);
                        if (cd != null) {
                            out.println("<TD colspan=2>" + cd.getId() + "/" + cd.getDesc2() + "</TD>");
                        } else {
                            out.println("<TD colspan=2></TD>");
                        }
                    } else {
                        out.println(td + preacher + "</TD>");
                    }
                    //Stage Pathi

                    String stagePathi = Util.getPathiName(0, allocation, contrMap);
                    if (Strings.isNullOrEmpty(stagePathi))
                        stagePathi = "Not Allocated";
                    if (!"CD".equalsIgnoreCase(lang))
                        out.println(td + stagePathi + "</TD>");

                    //Special Ground Pathi
                    if (isStagePathiAlsoGround)
                        out.println(td + stagePathi + "</TD>");

                    //Ground Pathi
                    for (int k = 1; k < numberOfPathis; k++) {

                        String pathi = Util.getPathiName(k, allocation, contrMap);
                        if (Strings.isNullOrEmpty(pathi))
                            pathi = "Not Allocated";
                        out.println(td + pathi + "</TD>");
                    }

                    out.println("</TR>");
                }

            %>

        </Table>
    </center>

</div>
<BR>
<center>
    <TABLE align="center">
        <tr>
        </tr>
        <tr><input type="button" value="Print Report" onClick="javascript:printWithSig()">

        </tr>
    </TABLE>
</center>



</body>
</html>
<%!

    public Long getLong(String parameter) {

        System.out.println("Parameter is : " + parameter);
        if (Strings.isNullOrEmpty(parameter))
            return null;
        else
            return Long.parseLong(parameter);
    }

%>


