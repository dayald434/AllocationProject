<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.filter.DayAvailFilter" %>
<%@ page import="com.rssb.api.filter.FilterList" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Allocation" %>
<%@ page import="com.rssb.common.entity.Leave" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="com.rssb.common.entity.PreacherAllocation" %>
<%@ page import="com.rssb.common.entity.PreacherType" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="com.rssb.common.helper.Util" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.concurrent.ConcurrentHashMap" %>
<html>

<head>
    <meta charset="utf-8">
    <title>Satsang Ghar registration</title>
    <link rel="stylesheet" href="css/style.css"/>

    <style>
        .cl1 {
            background-color: ivory;
            border: hidden;
        }

        .cl2 {
            background-color: lightgray;
            border: hidden;
        }

        select {
            width: 80%;
            text-align-last: left;
        }

    </style>

</head>

<body>

<script>
    function topFunction() {
        document.body.scrollTop = 100; // For Chrome, Safari and Opera
        document.documentElement.scrollTop = 0; // For IE and Firefox
    }

    window.onload = topFunction();

</script>

<BR><BR>
<center>

    <form action="Scheduling.jsp" method="post">

        <%
            ApiHelper apiHelper = new ApiHelper();
            Map<String, Object> context = new ConcurrentHashMap();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            String action = request.getParameter("Action");
            if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Load"))
                return;

            Long sgId = getLong(request.getParameter("SgId"));

            if (null == sgId) {
                out.println("Please Enter Satsang Ghar name ");
                return;
            }

            if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("SAVE")) {

                String[] dateArray = request.getParameterValues("Date");
                String[] timeArray = request.getParameterValues("Time");

                if (null == dateArray)
                    return;
                for (int i = 0; i < dateArray.length; i++) {
                    String date = dateArray[i];

                    String preacher = request.getParameter("Preacher" + date);
                    String[] pathi = request.getParameterValues("Pathi" + date);
                    String lang = request.getParameter("Lang" + date);

                    boolean isCD = false;
                    if ("CD".equalsIgnoreCase(lang)) {
                        isCD = true;
                    }

                    Allocation allocation = Allocation.builder().sgId(sgId).satDate(dateArray[i])
                            .time(timeArray[i]).preacher(preacher).pathi(pathi).isCD(isCD).build();
                    apiHelper.addAllocation(allocation, false);
                }

                out.println("Schedule Saved !!");
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

            Boolean isCenterPathi = Boolean.parseBoolean(request.getParameter("IsCenterPathi"));
            Boolean isCenterReader = Boolean.parseBoolean(request.getParameter("IsCenterReader"));
            Boolean isCenterKarta = Boolean.parseBoolean(request.getParameter("IsCenterKarta"));

            List<Date> dateList = apiHelper.getDates(sgId, startDate, endDate);

            if (dateList.size() == 0) {
                out.println("No Satsang day between " + startDate + " and " + endDate);
                return;
            }
            SatsangGhar satsangGhar = apiHelper.getSatsangGharById("" + sgId);

            int numberOfPathis = satsangGhar.getNumberOfPathis();
            System.out.println("Number of Pathis : " + numberOfPathis);
            String pathiCount = " <input  type=\"hidden\"  name=\"PathiCount\" value=\"" + numberOfPathis + "\" readonly >";
            out.println(pathiCount);

        %>

        <table border="1" style="width:90%">

            <tr bgcolor="#a9a9a9">
                <th align="center"> Week</th>
                <th align="center"> Lang</th>
                <th align="center"> Day</th>
                <th align="center"> Date</th>
                <th align="center"> Preacher</th>

                <%

                    String stageHeader = "<th align=\"center\"> %s</th>";

                    int pathIndex = 1;

                    if (satsangGhar.getIsStagePathiAlsoGround()) {
                        out.println(String.format(stageHeader, "Stage/Ground Pathi1"));
                        pathIndex = 2;
                    } else {
                        out.println(String.format(stageHeader, "Stage Pathi"));
                    }

                    String pathiHeader = " <th align=\"center\">Ground Pathi%s</th>";
                    for (int k = 2; k <= numberOfPathis; k++) {
                        out.println(String.format(pathiHeader, pathIndex++));
                    }

                %>

            </tr>
            <tr>

            </tr>

            <%
                String td = "<td align=\"center\" nowrap>";
                List<Preacher> pathiList = apiHelper.getPreacherByType(PreacherType.Pathi, isCenterPathi, sgId);
                List<Preacher> preacherList = apiHelper.getPreacherByType(PreacherType.Karta, isCenterKarta, sgId);
                List<Preacher> readerList = apiHelper.getPreacherByType(PreacherType.Reader, isCenterReader, sgId);
                preacherList.addAll(readerList);

                Map<String, Allocation> allocationMap = apiHelper.getAllocationMap(sgId, startDate, endDate);
                Map<String, List<PreacherAllocation>> datePreacherMap = apiHelper.getAllotedPreacherMap(sgId, startDate, endDate);
                Map<String, Schedule> sMap = apiHelper.getScheduleMap(sgId);

                context.put("AllocationMap", allocationMap);

                String dateStrSkeleton = " <input type=\"hidden\"  name=\"Date\" value=\"%s\" readonly >";
                String timeSk = " <input  type=\"hidden\"  name=\"Time\" value=\"%s\" readonly >";
                String sgIdStr = " <input  type=\"hidden\"  name=\"SgId\" value=\"%s\" readonly >";
                String hiddenStage = " <input  type=\"hidden\"  name=\"%s\" value=\"\"  >";
                String hiddenLang = " <input  type=\"hidden\"  name=\"Lang%s\" value=\"%s\"  >";

                sgIdStr = String.format(sgIdStr, sgId);

                out.println("\n" + String.format(sgIdStr) + "\n");
                out.println("\n" + String.format(pathiCount) + "\n");

                String color1 = "bgcolor=\"#d3d3d3\"";
                String color2 = "";

                int lastWeek = 0;
                String color = color1;
                String cl = "cl1";

                for (int i = 0; i < dateList.size(); i++) {
                    Date date = dateList.get(i);
                    int week = Util.getWeek(date.getDate());
                    if (lastWeek != week) {
                        if (color.equalsIgnoreCase(color1)) {
                            color = color2;
                            cl = "cl1";
                        } else {
                            color = color1;
                            cl = "cl2";
                        }
                        lastWeek = week;
                    }

                    String dateString = sdf.format(date);
                    context.put("DateString", dateString);

                    String day = Util.dateToDayMap.get(dateString);
                    Schedule schedule = sMap.get(day);
                    String lang = schedule.getLang()[week - 1];
                    String time = schedule.getTime();

                    Allocation allocation = allocationMap.get(dateString);

                    String[] oldPathiArray = new String[numberOfPathis];
                    String oldPreacher = "";
                    if (allocation != null) {
                        oldPathiArray = allocation.getPathi();
                        oldPreacher = allocation.getPreacher();
                    }

                    out.println("\n");

                    String pathiStr = "";
                    String preacherStr = "";

                    List<Preacher> filteredPreacher = apiHelper.getFilteredPreacherByLangAndAlloc(preacherList, lang, dateString, time, datePreacherMap);
                    List<Preacher> filteredPathi = apiHelper.getFilteredPreacherByAllocation(pathiList, dateString, time, datePreacherMap);

                    Map<String, List<Leave>> leaveMap = FilterList.getLeaveMap(startDate, endDate);
                    filteredPreacher = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPreacher, leaveMap);
                    filteredPathi = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPathi, leaveMap);

                    filteredPreacher = DayAvailFilter.filter(filteredPreacher, context);
                    filteredPathi = DayAvailFilter.filter(filteredPathi, context);

//                    if ("CD".equalsIgnoreCase(lang)) {
//
//                        out.println("<TR " + color + " >");
//
//                        out.println(td + week + "</TD>");
//                        out.println(td + lang + "</TD>");
//                        out.println(td + day + "</TD>");
//                        out.println(td + dateString + "</TD>");
//                        //Preacher
//                        out.println("<TD></TD>");
//
//                        //Pathis
//                        for (int k = 1; k <= numberOfPathis; k++) {
//                            out.println("<TD></TD>");
//                        }
//
//                        out.println("</TR>");
//
//
//                    }


                    /*
                    Form Elements
                     Date, Time, Preacher, Path1, Path2 ...
                     D1, T1,     PR-D1, P-D1, P-D1, P-D1
                     */

                    // hidden
                    out.println(String.format(dateStrSkeleton, dateString));
                    out.println(String.format(timeSk, time));

                    // Visible
                    out.println("<TR " + color + " >");

                    out.println(td + week + "</TD>");
                    out.println(td + lang + "</TD>");
                    out.println(td + day + "</TD>");
                    out.println(td + dateString + "</TD>");

                    //Preacher

                    if ("CD".equalsIgnoreCase(lang)) {
                        out.println("<TD></TD>");
                    } else {
                        preacherStr = printPreacher("Preacher", dateString, filteredPreacher, cl, oldPreacher, "");
                        out.println(td + preacherStr + "</TD>");
                    }

                    //Stage Pathi

//                    if ("CD".equalsIgnoreCase(lang) && !satsangGhar.getIsStagePathiAlsoGround()) {
//                        out.println("<TD></TD>");
//                    } else {
//                        String oldPathi = Util.getPathi(0, oldPathiArray);
//                        pathiStr = printPreacher("Pathi", dateString, filteredPathi, cl, oldPathi, "");
//                        out.println(td + pathiStr + "</TD>");
//                    }

                    String oldPathi = "";

                    out.println(String.format(hiddenLang, dateString, lang));
                    //Pathis
                    for (int k = 0; k < numberOfPathis; k++) {
                        if (k == 0 && "CD".equalsIgnoreCase(lang) && !satsangGhar.getIsStagePathiAlsoGround()) {
                            out.println(String.format(hiddenStage, "Pathi" + dateString));
                            out.println("<TD></TD>");
                        } else {
                            oldPathi = Util.getPathi(k, oldPathiArray);
                            pathiStr = printPreacher("Pathi", dateString, filteredPathi, cl, oldPathi, "");
                            out.println(td + pathiStr + "</TD>");
                        }
                    }

                    out.println("</TR>");
                }

            %>

        </Table>

        <BR>
        <BR>
        <BR>

        <input type="hidden" name="Action" value="save">
        <input type="Submit" value="Submit">

    </form>
</center>
</body>
<%!

    private String getDisplayedValue(Preacher preacher) {
        String prepend = "";
        if (preacher.getType().equalsIgnoreCase(PreacherType.Pathi.toString()))
            prepend = "P-";
        else if (preacher.getType().equalsIgnoreCase(PreacherType.Karta.toString()))
            prepend = "SK-";
        else if (preacher.getType().equalsIgnoreCase(PreacherType.Reader.toString()))
            prepend = "SR-";

        return prepend + preacher.getName() + "(" + preacher.getShortName() + ")";
    }

    private void appendDefaultPreacher(List<Preacher> list, String defaultValue) throws Exception {

        boolean isPresent = false;
        for (Preacher preacher : list) {
            if (defaultValue.equalsIgnoreCase(preacher.getShortName())) {
                isPresent = true;
                break;
            }
        }
        if (!isPresent) {
            ApiHelper apiHelper = new ApiHelper();
            Preacher preacher = apiHelper.getPreacherByShortName(defaultValue);
            list.add(preacher);
        }
    }

    private String printPreacher(String name, String dateStr, List<Preacher> list, String cl, String defaultValue, String disable) throws Exception {
        String start = "<select class=\"" + cl + "\"  name=\"" + name + dateStr + "\"  " + disable + "  >" +
                "<option value=\"\">Select " + name + "</option>";

        System.out.println("DV: " + defaultValue);
        if ("\"\"".equalsIgnoreCase(defaultValue) || null == defaultValue)
            defaultValue = "";

        if (!Strings.isNullOrEmpty(defaultValue)) {
            appendDefaultPreacher(list, defaultValue);
        }

        String end = "\n</select>";
        String selected = "selected=\"selected\"";
        String optionSkeleton = "\n<option value=\"%s\"  %s >%s</option>\n";

        String output = "";
        for (Preacher preacher : list) {
            String optionList = String.format(optionSkeleton, preacher.getShortName(), defaultValue.equalsIgnoreCase(preacher.getShortName()) ? selected : "", getDisplayedValue(preacher));
            output += optionList;
        }

        return start + output + end;
    }

    public Long getLong(String parameter) {

        System.out.println("Parameter is : " + parameter);
        if (Strings.isNullOrEmpty(parameter))
            return null;
        else
            return Long.parseLong(parameter);
    }

%>

</html>
