<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.filter.DayAvailFilter" %>
<%@ page import="com.rssb.api.filter.FilterList" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Allocation" %>
<%@ page import="com.rssb.common.entity.CD" %>
<%@ page import="com.rssb.common.entity.Leave" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="com.rssb.common.entity.PreacherAllocation" %>
<%@ page import="com.rssb.common.entity.PreacherType" %>
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
            width: 60%;
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
            System.out.println(context.get("hello"));
            context.put("hello", "kkk");
            System.out.println(context.get("hello"));

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

                String[] pathis = request.getParameterValues("Pathi");
                String[] preachers = request.getParameterValues("Preacher");
                String[] cdArray = request.getParameterValues("CD");

                for (int i = 0; i < dateArray.length; i++) {
//                    Allocation allocation = Allocation.builder().sgId(sgId).satDate(dateArray[i]).time(timeArray[i]).preacher(preachers[i])
//                            .pathi(pathis[i]).cdId(cdArray[i]).build();
//                    apiHelper.addAllocation(allocation,false);
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
        %>

        <table border="1" style="width:70%">

            <tr bgcolor="#a9a9a9">
                <th align="center"> Week</th>
                <th align="center"> Lang</th>
                <th align="center"> Day</th>
                <th align="center"> Date</th>
                <th align="center"> Pathi</th>
                <th align="center"> Preacher</th>

            </tr>
            <tr>

            </tr>

            <%
                String td = "<td align=\"center\">";
                List<Preacher> pathiList = apiHelper.getPreacherByType(PreacherType.Pathi, isCenterPathi, sgId);
                List<Preacher> preacherList = apiHelper.getPreacherByType(PreacherType.Karta, isCenterKarta, sgId);
                List<Preacher> readerList = apiHelper.getPreacherByType(PreacherType.Reader, isCenterReader, sgId);
                List<CD> cdList = apiHelper.getAllCD();

                preacherList.addAll(readerList);

                Map<String, Allocation> allocationMap = apiHelper.getAllocationMap(sgId, startDate, endDate);
                Map<String, List<PreacherAllocation>> datePreacherMap = apiHelper.getAllotedPreacherMap(sgId, startDate, endDate);
                Map<String, Schedule> sMap = apiHelper.getScheduleMap(sgId);

                context.put("AllocationMap", allocationMap);

                String dateStrSkeleton = " <input type=\"hidden\"  name=\"Date\" value=\"%s\" readonly >";
                String timeSk = " <input  type=\"hidden\"  name=\"Time\" value=\"%s\" readonly >";
                String sgIdStr = " <input  type=\"hidden\"  name=\"SgId\" value=\"%s\" readonly >";

                sgIdStr = String.format(sgIdStr, sgId);

                out.println("\n" + String.format(sgIdStr) + "\n");
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

                    String oldPathi = "";
                    String oldPreacher = "";
                    if (allocation != null) {
                        oldPathi = allocation.getPathi();
                        oldPreacher = allocation.getPreacher();
                    }

                    out.println("\n");

                    String pathiStr = "";
                    String preacherStr = "";
                    String cdStr = "";


                    List<Preacher> filteredPreacher = apiHelper.getFilteredPreacherByLangAndAlloc(preacherList, lang, dateString, time, datePreacherMap);
                    List<Preacher> filteredPathi = apiHelper.getFilteredPreacherByAllocation(pathiList, dateString, time, datePreacherMap);

                    Map<String, List<Leave>> leaveMap = FilterList.getLeaveMap(startDate, endDate);
                    filteredPreacher = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPreacher, leaveMap);
                    filteredPathi = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPathi, leaveMap);

                    filteredPreacher = DayAvailFilter.filter(filteredPreacher, context);
                    filteredPathi = DayAvailFilter.filter(filteredPathi, context);

                    if ("CD".equalsIgnoreCase(lang)) {
                        cdStr = printCD("CD", cdList, cl, oldPathi);
                        pathiStr="";
                        preacherStr = "";
                    } else {
                        pathiStr = printPreacher("Pathi", filteredPathi, cl, oldPathi, "");
                        preacherStr = printPreacher("Preacher", filteredPreacher, cl, oldPreacher, "");
                        out.println(String.format(dateStrSkeleton, dateString));
                        out.println(String.format(timeSk, time));
                    }

                    out.println("<TR " + color + " >");

                    out.println("\n");
                    out.println(td + week + "</TD>");
                    out.println(td + lang + "</TD>");
                    out.println(td + day + "</TD>");
                    out.println(td + dateString + "</TD>");
                    out.println(td + pathiStr + "</TD>");
                    out.println(td + preacherStr + "</TD>");
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

    private String printPreacher(String name, List<Preacher> list, String cl, String defaultValue, String disable) throws Exception {
        System.out.println("DV : " + defaultValue);
        String start = "<select class=\"" + cl + "\"  name=\"" + name + "\"  " + disable + "  >" +
                "<option value=\"\">Select " + name + "</option>";

        if (!Strings.isNullOrEmpty(defaultValue)) {
            appendDefaultPreacher(list, defaultValue);
        }

        String end = "\n</select>";
        String selected = "selected=\"selected\"";
        String optionSkeleton = "\n<option value=\"%s\"  %s >%s</option>\n";

        String output = "";
        for (Preacher preacher : list) {
            String optionList = String.format(optionSkeleton, preacher.getShortName(), defaultValue.equalsIgnoreCase(preacher.getShortName()) ? selected : "", preacher.getShortName() + "(" + preacher.getName() + ")");
            output += optionList;
        }

        return start + output + end;
    }

    private String printCD(String name, List<CD> list, String cl, String defaultValue) throws Exception {
        System.out.println("DV : " + defaultValue);
        String start = "<select class=\"" + cl + "\"  name=\"" + name + "\"    >" +
                "<option value=\"\">Select " + name + "</option>";

        String end = "\n</select>";
        String selected = "selected=\"selected\"";
        String optionSkeleton = "\n<option value=\"%s\"  %s >%s</option>\n";

        String output = "";
        for (CD cd : list) {
            String optionList = String.format(optionSkeleton, cd.getId(), defaultValue.equalsIgnoreCase(cd.getId()) ? selected : "", cd.getId());
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
