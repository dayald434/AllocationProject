<%@page import="java.awt.print.Book"%>
<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.common.base.Strings" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
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
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/common.js"></script>
    <script src="js/city.js"></script>

  
    <style>
        .txt1 {
            width: 97%;
height: 60%;
        }
           .txt12 {
            width: 98%;
height: 60%;
        }
         
         .txt11 {
            width: 97%;
height: 60%;
display: inline-block;

        }

        .blank_row {
            height: 25px
        }
.form11 {
    width: 82%;
    margin-top: 2%;
    border-color: lightgrey;
    border-style: outset;
    
    
}
.cl1{
width: 97%;
height: 25px;
margin-top: 0%;
}
    </style>
    <script type="text/javascript">
    function isNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
    
    </script>
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
    <script type="text/javascript">

        function startUp() {
            var today = getTodayDate();
            document.getElementById('InitDate').max = today

        }

        window.onload = startUp;

    </script>

</head>
<body bgcolor="#fffff0">
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

          
            String startDate = request.getParameter("Date");
            if (Strings.isNullOrEmpty(startDate)) {
                out.println("Please select Start Date ");
                return;
            }

            String endDate = request.getParameter("Date");
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
            String td = "<td nowrap >";
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
                String pathiStr = "";
                String preacherStr = "";

                List<Preacher> filteredPreacher = apiHelper.getFilteredPreacherByLangAndAlloc(preacherList, lang, dateString, time, datePreacherMap);
                List<Preacher> filteredPathi = apiHelper.getFilteredPreacherByAllocation(pathiList, dateString, time, datePreacherMap);

                Map<String, List<Leave>> leaveMap = FilterList.getLeaveMap(startDate, endDate);
                filteredPreacher = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPreacher, leaveMap);
                filteredPathi = FilterList.filterPreacherBasedOnAttendance(dateString, filteredPathi, leaveMap);

                filteredPreacher = DayAvailFilter.filter(filteredPreacher, context);
                filteredPathi = DayAvailFilter.filter(filteredPathi, context);
                String stageHeader = "";

                int pathIndex = 1;

                if (satsangGhar.getIsStagePathiAlsoGround()) {
                    out.println(String.format(stageHeader, "Pathi"));
                    pathIndex = 2;
                } else {
                    out.println(String.format(stageHeader, "Stage Pathi"));
                }

                String pathiHeader = " <th>Ground Pathi%s</th>";
                for (int k = 2; k <= numberOfPathis; k++) {
                    out.println(String.format(pathiHeader, pathIndex++));
                }
                // Visible
                out.println("<TR " + color + " >");
                Long sgIds=getLong(request.getParameter("SgId"));
            	SatsangGhar satsangName=apiHelper.getSatsangGharById(""+ sgIds);
        %>

<jsp:include page="menu.jsp"/>

<center>

    <form class="form11" action="RegisterAttendance.jsp" method="post" name="PreacherForm" onsubmit="return(validate());">
        <BR>
        <font class="header1"><B class="">Satsang Attendance</B></font>
        <TABLE cellspacing="3" align="center" style="height:50%; border: none; width: 80%;margin: auto;margin-top: 4%;" class="table1">
        </TD>
            <%
                out.println("\n" + String.format(sgIdStr) + "\n");
                out.println("\n" + String.format(pathiCount) + "\n");
                    out.println("\n");
                    // hidden
                    out.println(String.format(dateStrSkeleton, dateString));
                    out.println(String.format(timeSk, time));
                	 %>
                	<TD><B>Address : </B><%out.println(satsangName.getName());%></TD>
                	<TD><B>Language : </B><%out.println(lang);%></TD>
                    <TD><B>Date : </B><%out.println(dateString);%></TD>
                    <TD><B>Week:</B><%out.println(week);%></TD>
                   <tr></tr>   <TR>
                <TD height="2">
                    <font color="blue">
                        <small></small>
                    </font>
                </TD>
<td></td>
                <TD height="2">
                    <font color="blue">
                        <small></small>
                    </font>
                </TD>
                <TD height="2">
                    <font color="blue">
                        <small>Book</small>
                    </font>
                </TD>
            </TR>
                      <TD><B>Day : </B><%out.println(day);%></TD>
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
                     <TD >
                    <input  name="book" id="book" class="txt1" placeholder="Book" list=Book>
                </TD>
                <tr></tr>
                 <TR>
                <TD height="2">
                    <font color="blue">
                        <small>Shabad</small>
                    </font>
                </TD>
<td></td>
                <TD height="2">
                    <font color="blue">
                        <small>Saint</small>
                    </font>
                </TD>
                <TD height="2">
                    <font color="blue">
                        <small>No. Of Gents</small>
                    </font>
                </TD>
            </TR>
            <TR >
                 <TD colspan="2">
                    <input  name="shabad" id="shabad"   class="txt12" placeholder="shabad"  ng-pattern-restrict style="text-transform: capitalize;"/>
                </TD>
                <TD>
                    <input name="saint" id="Saint" class="txt1" placeholder="Saint" list=saint>
                </TD>
                  <td> <input name="gents" id="gents" class="txt11" placeholder="Gents"  maxlength="6" onkeypress="return isNumber(event)" >
                  </td>
            </TR> 
            <tr></tr>
                      <TR>

                <TD height="2">
                    <font color="blue">
                        <small>No. Of Ladies</small>
                    </font>
                </TD>
				<td height="2">
                    <font color="blue">
                        <small>No. Of Children</small>
                    </font></td>
                <TD height="2">
                    <font color="blue">
                        <small>No. Of Two_Wheeler</small>
                    </font>
                </TD>
                <TD height="2">
                    <font color="blue">
                        <small>No. Of Four_Wheeler</small>
                    </font>
                </TD>
            </TR>
            <TR>     <TD>
                    <input name="ladies" id="ladies" class="txt11" placeholder="Ladies" maxlength="6" onkeypress="return isNumber(event)">
                </TD>
                  <TD style="border: none;">
                    <input name="children" id="children" class="txt11" placeholder="Children" maxlength="6" onkeypress="return isNumber(event)">
                </TD>
                 <td>
                    <input name="two_wheeler" id="twoweeler" class="txt11" placeholder="Two_weeler" maxlength="6" onkeypress="return isNumber(event)">
               </td>
                  <TD style="border: none;">
                    <input name="four_wheeler" id="four wheeler" class="txt11" placeholder="Four_weeler" maxlength="6" onkeypress="return isNumber(event)">
 <%
                    out.println("</TR>");
                }%>
       <tr>
            </TR>
        </TABLE>

        <TABLE cellspacing="3" align="center" style=" width: 75%;" class="table1">

            <TR class="blank_row">
                <td>
                </td>
            </TR>
            <TR>
                <TD align="center">
                    <input type="submit" value="Submit"/>
                </TD>
                <TD align="center">
                   <input action="action" onclick="window.history.go(-1); return false;" type="button" value="Back" />
                </TD>
            </TR>
            <TR class="blank_row">
                <td>
                </td>
            </TR>
        </TABLE>
    </form>
</center>
<%--<script language="javascript">print_state("State");</script>--%>
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
