<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Allocation" %>
<%@ page import="com.rssb.common.entity.Constants" %>
<%@ page import="com.rssb.common.entity.Duty" %>
<%@ page import="com.rssb.common.entity.DutyDetails" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="com.rssb.common.helper.Util" %>
<%@ page import="org.apache.commons.lang.WordUtils" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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

    <%--<style type="text/css" media="print">--%>
    <%--@page {--%>
    <%--size: auto;   /* auto is the initial value */--%>
    <%--margin: 0;  /* this affects the margin in the printer settings */--%>
    <%--}--%>

    <%--body {--%>
    <%--transform: scale(.9);--%>
    <%--}--%>

    <%--</style>--%>

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

            String shortName = request.getParameter("ShortName");

            if (null == shortName) {
                out.println("Please Select Sewadar");
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



            Preacher preacher = apiHelper.getPreacherByShortName(shortName);
            List<Allocation> allocationList =apiHelper.getAllocation(shortName,startDate,endDate);
            Map<String, String> contrMap = apiHelper.getShortNameMap();



            if (allocationList.size() == 0) {
                out.println("There is no sewa alloted between " + startDate + " and " + endDate+" to "+preacher.getName());
                return;
            }

            String heading="<font class=\"header1\"><B class=\"\">  Sewa Allocation For %s(Short Name: %s)  from %s to %s</B></font>";


           out.print(String.format(heading,WordUtils.capitalize(preacher.getName()),preacher.getShortName(),sdf.format( inputFormat.parse(startDate) ),sdf.format( inputFormat.parse(endDate) ) ));
    %>
        <br>
        <br>
        <table border="1" style="width:70%">



            <tr bgcolor="#a9a9a9">
                <th align="center" nowrap> Date</th>
                <th align="center" nowrap> Day/Satsang Time</th>
                <th align="center" nowrap> Satsang Ghar</th>

                <%
                    boolean isPathi = preacher.getType().equalsIgnoreCase("Pathi") ? true : false;
                %>

                <th align="center"><% out.print(isPathi ? "Karta" : "Pathi"); %></th>

                <%
                    if (isPathi) {
                        String header = "<th align=\"center\"> Sewa</th>";
                        out.println(header);
                    }
                %>

            </tr>
            <tr>

            </tr>

            <%

                //            printPathiReport();
//            printKartaReport();
//

                if (isPathi)
                    printPathiReport(out, shortName, allocationList, contrMap);
                else
                    printKartaReport(out, shortName, allocationList, contrMap);

            %>

        </Table>
</div>
<BR>
<center>

    <TABLE align="center">
        <tr>
        </tr>
        <tr><input type="button" value="Print Report" onClick="javascript:printWithSig()">
            <%--<tr><input type="button" value="Print Report" onClick="window.print()">--%>

        </tr>
    </TABLE>

    <BR>
    <BR>
    <BR>


</center>
</body>
</html>
<%!
    private void printKartaReport(JspWriter out, String shortName, List<Allocation> allocationList, Map<String, String> contrMap) throws IOException {

        String td = "<td align=\"left\" nowrap>";
        String shorNameStr = " <input  type=\"hidden\"  name=\"ShortName\" value=\"%s\" readonly >";
        shorNameStr = String.format(shorNameStr, shortName);
        out.println("\n" + String.format(shorNameStr) + "\n");

        String color1 = "bgcolor=\"#d3d3d3\"";
        String color2 = "";
        String color = color1;

        for (int i = 0; i < allocationList.size(); i++) {
            Allocation allocation = allocationList.get(i);
            if (color.equalsIgnoreCase(color1)) {
                color = color2;
            } else {
                color = color1;
            }

            String dateString = allocation.getSatDate();
            String day = WordUtils.capitalize(allocation.getDay());
            String time = allocation.getTime();
            String sg = allocation.getSatsangGharName();

            out.println("<TR " + color + " >");

            String pathi = Util.getPathiName(0, allocation, contrMap);
            if (Strings.isNullOrEmpty(pathi))
                pathi = Constants.NOT_ALLOC;
            out.println(td + dateString + "</TD>");
            out.println(td + day + "(" + time + ")" + "</TD>");
            out.println(td + sg + "</TD>");
            out.println(td + pathi + "</TD>");
            out.println("</TR>");
        }
    }

    private void printPathiReport(JspWriter out, String shortName, List<Allocation> allocationList, Map<String, String> contrMap) throws IOException {

        String td = "<td align=\"left\" nowrap>";
        String shorNameStr = " <input  type=\"hidden\"  name=\"ShortName\" value=\"%s\" readonly >";
        shorNameStr = String.format(shorNameStr, shortName);
        out.println("\n" + String.format(shorNameStr) + "\n");

        String color1 = "bgcolor=\"#d3d3d3\"";
        String color2 = "";
        String color = color1;

        for (int i = 0; i < allocationList.size(); i++) {
            Allocation allocation = allocationList.get(i);
            if (color.equalsIgnoreCase(color1)) {
                color = color2;
            } else {
                color = color1;
            }

            String dateString = allocation.getSatDate();
            String day = WordUtils.capitalize(allocation.getDay());
            String time = allocation.getTime();
            String sg = allocation.getSatsangGharName();

            out.println("<TR " + color + " >");

            String karta = Util.getPreacherName(allocation, contrMap);
            if (Strings.isNullOrEmpty(karta))
                karta = Constants.NOT_ALLOC;

            List<DutyDetails> dutyList = Util.getDutyList(shortName, allocation);

            System.out.println(dutyList);

            for (DutyDetails dutyDetail : dutyList) {

                String kartaToDisplay = Constants.NA;
                if (Duty.STAGE == dutyDetail.getDuty()) {
                    kartaToDisplay = karta;
                }

                out.println(td + dateString + "</TD>");
                out.println(td + day + "(" + time + ")" + "</TD>");
                out.println(td + sg + "</TD>");
                out.println(td + kartaToDisplay + "</TD>");
                out.println(td + dutyDetail.toString() + "</TD>");
                out.println("</TR>");
            }
        }
    }

    public Long getLong(String parameter) {

        System.out.println("Parameter is : " + parameter);
        if (Strings.isNullOrEmpty(parameter))
            return null;
        else
            return Long.parseLong(parameter);
    }

%>

</center>
