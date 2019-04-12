<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.helper.StaticContent" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Allocation" %>
<%@ page import="com.rssb.common.entity.CD" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="com.rssb.common.helper.Util" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.concurrent.ConcurrentHashMap" %>
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

    <form action="SchedulingCD.jsp" method="post">

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
                    String cd = request.getParameter("CD" + date);
                    Allocation allocation = Allocation.builder().sgId(sgId).satDate(date).time(timeArray[i]).cdId(cd).isCD(true).build();
                    apiHelper.addAllocation(allocation, true);
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

            List<Date> dateList = apiHelper.getDates(sgId, startDate, endDate);

            if (dateList.size() == 0) {
                out.println("No Satsang day between " + startDate + " and " + endDate);
                return;
            }
        %>

        <table border="1" style="width:85%">

            <tr style="height: 100%" bgcolor="#a9a9a9">
                <th align="center"> Week</th>
                <th align="center"> Lang</th>
                <th align="center"> Day</th>
                <th align="center"> Date</th>
                <th align="center"> CD</th>
                <th align="center" width="50%"> Shabad Details</th>

            </tr>
            <tr>

            </tr>

            <%
                String td = "<td nowrap align=\"center\">";

                List<CD> cdList = apiHelper.getAllCD();

                Map<String, Allocation> allocationMap = apiHelper.getAllocationMap(sgId, startDate, endDate);

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

                    String dateString = sdf.format(date);
                    context.put("DateString", dateString);

                    String day = Util.dateToDayMap.get(dateString);
                    Schedule schedule = sMap.get(day);
                    String lang = schedule.getLang()[week - 1];

                    if (!"CD".equalsIgnoreCase(lang))
                        continue;

                    String time = schedule.getTime();

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

                    Allocation allocation = allocationMap.get(dateString);

                    String oldCD = "";
                    String oldDesc = "";
                    System.out.println("existing allo: " + allocation);

                    if (allocation != null && allocation.getCdId() != null) {
                        oldCD = allocation.getCdId();
                        CD cd = StaticContent.getCdMap().get(oldCD);
                        if (null != cd)
                            oldDesc = cd.getDesc1() + "/" + cd.getDesc2();
                    }

                    System.out.println(oldDesc);
                    out.println("\n");

                    String cdStr = printCD("CD", dateString, cdList, cl, oldCD);
                    String descStr = "<div id=\"CD" + dateString + "Desc\"> " + oldDesc + " </div>\n";

                    out.println(String.format(dateStrSkeleton, dateString));
                    out.println(String.format(timeSk, time));

                    out.println("<TR " + color + " >");

                    out.println("\n");
                    out.println(td + week + "</TD>");
                    out.println(td + lang + "</TD>");
                    out.println(td + day + "</TD>");
                    out.println(td + dateString + "</TD>");
                    out.println(td + cdStr + "</TD>");
                    out.println(td + descStr + "</TD>");
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

    private String printCD(String name, String dateString, List<CD> list, String cl, String defaultValue) throws Exception {
        System.out.println("Def Value : " + defaultValue);
        String start = "<select class=\"" + cl + "\"  name=\"" + name + dateString + "\"  onchange=\"print_desc(name,value);\"    >" +
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
