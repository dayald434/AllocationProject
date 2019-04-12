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
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="com.rssb.common.helper.Util" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.rssb.common.entity.Attendance" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.concurrent.ConcurrentHashMap" %>
<html>

<head>
    <meta charset="utf-8">
    <title>Satsang Ghar Attendance</title>
    <link rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" type="text/css" href="css/common.css"/>

    <style>
        .cl1 {
            background-color: ivory;
            width: 66%;
            height: 35px;
        }

        .cl2 {
            background-color: lightgray;
            border: hidden;
        }

        select {
            text-align-last: left;
        }
.txt11{
width: 328px;
height: 35px;
margin-left: 21px;
}
.txt12{
width: 328px;
height: 35px;
margin-left: 21px;

}
.txt13{
width: 328px;
height: 35px;
margin-left: 21px;
margin-right: 21px;
}
    </style>
  <style>
        .font12 {
            font-size: 20px;
            color: green;
        }
       
    </style>
    <datalist id="Book">
  <option value="santo ki bani ">
  <option value="shabad ki mahima ke shabad">
  <option value="Sar Bachan">
  <option value="chuna huai bhabad">
  
</datalist>
   <datalist id="saint">
  <option value="Sant Namdev Ji ">
  <option value="Sant Tukaram Ji">
  <option value="Sant Kabir Ji">
  <option value="Dhani Dharamdas Ji">
  <option value="Guru Ravidas Ji">
  <option value="Surdas Ji">
  <option value="Goswami Tulsidas Ji">
  <option value="Sant Dadu Dayal Ji">
  <option value="Jagjivan Sahib Ji">
  <option value="Paltu Sahib Ji">
  <option value="Dariya Sahib Ji">
  <option value="Sant Charandas Ji">
  <option value="Sahjobai Ji">
  <option value="Malookdas Ji">
  <option value="Dharnidas Ji">
  <option value="Gareebdas Ji">
  <option value="Sheikh Farid Ji">
  <option value="Guru Nanak Dev Ji">
  <option value="Guru Amar Das Ji">
  <option value="Guru Ramdas Ji">
  <option value="Guru Arjun Dev Ji">
  <option value="Guru Tegh Bahadur Ji">
  <option value="Guru Gobind Singh Ji">
  <option value="Tulsi Sahib Ji">
  <option value="Bani Soami Ji Maharaj">
</datalist>
</head>

<body>

<script>
    function topFunction() {
        document.body.scrollTop = 100; // For Chrome, Safari and Opera
        document.documentElement.scrollTop = 0; // For IE and Firefox
    }

    window.onload = topFunction();

</script>
 <script type="text/Javascript">
function checkDec(el){
 var ex = /^[0-9]+\.?[0-9]*$/;
 if(ex.test(el.value)==false){
   el.value = el.value.substring(0,el.value.length - 1);
  }
}
</script>

<BR><BR>
<center>

    <form class="form1" action="Att.jsp" method="post" cellspacing="3" align="center" style="height:50%; border: none; width:;" >

        <%
            ApiHelper apiHelper = new ApiHelper();
            Map<String, Object> context = new ConcurrentHashMap();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
            String action = request.getParameter("Action");
            if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Load"))
                return;

            Long sgId = getLong(request.getParameter("SgId"));

            if (null == sgId) {
                out.println("Please Select Satsang Ghar name ");
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
<h1 align="center">Attendence Of Satsang</h1>
        <table border="3" style="width:85%;margin-left: 5%;" >

            <tr >
        <tr height="35px"></tr>
                
                
               
            </tr>
            <tr>

            </tr>
            <br></br>
			
            <%
                String td = "<td align=\"center\" nowrap style=\"border: none;\">";
                List<Preacher> pathiList = apiHelper.getPreacherByType(PreacherType.Pathi, isCenterPathi, sgId);
                List<Preacher> preacherList = apiHelper.getPreacherByType(PreacherType.Karta, isCenterKarta, sgId);
                List<Preacher> readerList = apiHelper.getPreacherByType(PreacherType.Reader, isCenterReader, sgId);
                preacherList.addAll(readerList);

                Map<String, Allocation> allocationMap = apiHelper.getAllocationMap(sgId, startDate, endDate);
                Map<String, List<PreacherAllocation>> datePreacherMap = apiHelper.getAllotedPreacherMap(sgId, startDate, endDate);
                Map<String, Schedule> sMap = apiHelper.getScheduleMap(sgId);

                context.put("AllocationMap", allocationMap);

                String dateStrSkeleton = " <input type=\"hidden\"  name=\"Date\" value=\"%s\" style=width:50px readonly >";
                String timeSk = " <input  type=\"hidden\"  name=\"Time\" value=\"%s\" style=width:50px readonly >";
                String sgIdStr = " <input  type=\"hidden\"  name=\"SgId\" value=\"%s\" style=width:50px readonly >";
                String hiddenStage = " <input  type=\"hidden\"  name=\"%s\" value=\"\" style=width:50px >";
                String hiddenLang = " <input  type=\"hidden\"  name=\"Lang%s\" value=\"%s\" style=width:240px >";

                sgIdStr = String.format(sgIdStr, sgId);

                out.println("\n" + String.format(sgIdStr) + "\n");
                out.println("\n" + String.format(pathiCount) + "\n");

                String color1 = "";
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
                    String shabad="<input name=\"shabad\" value=\"\"style=width:100% >";
                    String saint="<input name=\"saint\" value=\"\"style=width:100px list=saint>";
                    String book="<input name=\"book\" value=\"\"style=width:100px list=Book >";
                    String gents="<input name=\"gents\" value=\"\"style=width:100px class=font12 onkeyup=checkDec(this);>";
                    String ladies="<input name=\"ladies\" value=\"\"style=width:100px class=font12 onkeyup=checkDec(this);>";
                    String children="<input name=\"children\" value=\"\"style=width:100px class=font12 onkeyup=checkDec(this);>";
                    String fourwheelers="<input name=\"fourwheelers\" value=\"\"style=width:100px class=font12 onkeyup=checkDec(this);>";
                    String twowheelers="<input  name=\"twowheelers\" value=\"\"style=width:100px class=font12 onkeyup=checkDec(this);>";

                    List<Preacher> filteredPreacher = apiHelper.getFilteredPreacherByLangAndAlloc(preacherList, lang, dateString, time, datePreacherMap);
                    List<Preacher> filteredPathi = apiHelper.getFilteredPreacherByAllocation(pathiList, dateString, time, datePreacherMap);

                    Map<String, List<Leave>> leaveMap = FilterList.getLeaveMap(startDate, endDate);
                    filteredPreacher = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPreacher, leaveMap);
                    filteredPathi = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPathi, leaveMap);

                    filteredPreacher = DayAvailFilter.filter(filteredPreacher, context);
                    filteredPathi = DayAvailFilter.filter(filteredPathi, context);



                    // hidden
                    out.println(String.format(dateStrSkeleton, dateString));
                    out.println(String.format(timeSk, time));

                    // Visible
                    out.println("<TR " + color + " >");
                    out.println(td + dateString + "</TD>");
                    out.println(td + lang + "</TD>");
                    out.println(td + day + "</TD>");

                    
                    %>
             
                <tr height="35px"></tr>
                

                <%

                    String stageHeader = "";

                    int pathIndex = 1;

                    if (satsangGhar.getIsStagePathiAlsoGround()) {
                        out.println(String.format(stageHeader, "Pathi"));
                        pathIndex = 2;
                    } else {
                        out.println(String.format(stageHeader, "Stage Pathi"));
                    }

                    String pathiHeader = " <th align=\"center\">Ground Pathi%s</th>";
                    for (int k = 2; k <= numberOfPathis; k++) {
                        out.println(String.format(pathiHeader, pathIndex++));
                    }

                %>
                  <tr></tr>
 <% out.println(td + week + "-Week Of The Month</TD >");
                              %>
                   <%
					
                    //Preacher

                    if ("CD".equalsIgnoreCase(lang)) {
                        out.println("<TD></TD>");
                    } else {
                        preacherStr = printPreacher("Preacher/SK/SR", dateString, filteredPreacher, cl, oldPreacher, "");
                        out.println(td + preacherStr + "</TD>");
                    }


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
                    %>
                      <tr height="35px"></tr>
                              <TR>
                <TD style="border: none;">
                    <input  name="Shabad" id="shabad" class="txt12"  placeholder="shabad" pattern="[a-zA-Z][.a-zA-Z\s]*" ng-pattern-restrict style="text-transform: capitalize;"/>

                </TD>
                      <TD style="border: none;">
                    <input name="saint" id="Saint" class="txt11" placeholder="Saint" list=saint>

                </TD>

               <TD style="border: none;">
                    <input name="book" id="book" class="txt13" placeholder="Book" list=Book>
                </TD>
            </TR> 
            <TR></TR>   <tr height="35px"></tr><TR> <th align="center" width="100%" style="border: none;"> Gents</th>
                    <th align="center" width="100%"style="border: none;"> Ladies</th>
                    <th align="center" width="100%"style="border: none;"> Children</th></TR>
                    <%
                     out.println(td+gents+"</TD>");
                    out.println(td+ladies+"</TD>");
                    out.println(td+children+"</TD>");
                %>
                 <tr height="35px"></tr> <TR> <th align="center" width="100%" style="border: none;"> Four_wheeler</th>
                    <th align="center" width="100%"style="border: none;"> Two_wheeler</th></TR><%
                    		   out.println(td+fourwheelers+"</TD>");
                    out.println(td+twowheelers+"</TD>");
                    out.println("</TR>");
                }%><tr height="35px"></tr>
       <tr>
       <td style="border: none;"></td>
       <td style="border: none;"> <input type="hidden" name="Action" value="save">
        <input type="Submit" value="Submit" style="margin-left: 150px;"></td></tr>
<tr></tr>
        </Table>
 <br></br>
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
