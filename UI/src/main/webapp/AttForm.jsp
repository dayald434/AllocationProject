<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Leave" %>
<%@ page import="java.util.List" %>
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

    </style>

</head>

<body>

<script>
    $(document).keypress(
        function (event) {
            if (event.which == '13') {
                event.preventDefault();
            }


        });

    function topFunction() {
        document.body.scrollTop = 100; // For Chrome, Safari and Opera
        document.documentElement.scrollTop = 0; // For IE and Firefox
    }

    window.onload = topFunction();

    function validate() {

        for (i = 1; i < 10000; i++) {

            if (!document.getElementById('StartDate' + i))
                break;


            startDate = document.getElementById('StartDate' + i).value;
            endDate = document.getElementById('EndDate' + i).value;

            j = i ;

            if ((startDate != "") || (endDate != "")) {
                if ((startDate == "")) {
                    alert("Fill Start date for No. " + j);
                    return false;
                }
                if ((endDate == "")) {
                    alert("Fill End date for No. " + j);
                    return false;
                }
            }


            start = new Date(startDate);
            end = new Date(endDate);


            if ((start.getTime() > end.getTime())) {
                alert("Start Date should be less than or equals to  End Date  for Sr. No." + i + " !!!");
                return false;
            }

        }

        return true;


    }

</script>

<BR><BR>
<center>

    <form action="AttForm.jsp" name="LeaveForm" onsubmit="return validate()">

        <%
            ApiHelper apiHelper = new ApiHelper();

            String shortNameSk = " <input  type=\"hidden\"  name=\"ShortName\" value=\"%s\" readonly >";

            String action = request.getParameter("Action");
            if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Load"))
                return;

            String shortName = request.getParameter("ShortName");

            if (null == shortName) {
                out.println("Please Select Name ");
                return;
            }

            if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("SAVE")) {

                String[] idArray = request.getParameterValues("Id");

                String[] startDateArray = request.getParameterValues("StartDate");
                String[] endDateArray = request.getParameterValues("EndDate");

                for (int i = 0; i < startDateArray.length; i++) {

                    Long id = getLong(idArray[i]);
                    String startDate = startDateArray[i];
                    String endDate = endDateArray[i];

                    if (id == null) {
                        if ((Strings.isNullOrEmpty(startDate) || (Strings.isNullOrEmpty(endDate))))
                            continue;
                    }
                    Leave leave = Leave.builder().id(id).shortName(shortName).startDate(startDate).endDate(endDate).build();

                    apiHelper.addLeaves(leave);
                    System.out.println(leave);
                }

                out.println("Leaves Updated !!");
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

        %>

        <table border="1" style="width:50%">

            <tr bgcolor="#a9a9a9">
                <th align="center"> Sr. No.</th>
                <th align="center"> Start Date</th>
                <th align="center"> End Date</th>
            </tr>
            <tr>
            </tr>

            <%

                List<Leave> leaveList = apiHelper.getLeaves(shortName, startDate, endDate);

                String td = "<td align=\"center\">";

                String idSk = "<input type=\"hidden\" name=\"Id\" value=\"%s\">";
                String startDateSk = " <input class=\".txt2\" type=\"date\" " +
                        " name=\"StartDate\" id=\"StartDate%s\" value=\"%s\"  max=" + endDate + " >";
                String endDateSk = " <input class=\".txt2\" type=\"date\" " +
                        " name=\"EndDate\"  id=\"EndDate%s\" value=\"%s\"  min=" + startDate + " >";

                String color1 = "bgcolor=\"#d3d3d3\"";
                String color2 = "";
                String color = color1;

                int srNo = 1;

                for (int i = 0; i < leaveList.size(); i++) {

                    Leave existingLeave = leaveList.get(i);

                    if (i % 2 == 0) {
                        if (color.equalsIgnoreCase(color1)) {
                            color = color2;
                        } else {
                            color = color1;
                        }
                    }

                    String id = String.format(idSk, existingLeave.getId());
                    String sd = String.format(startDateSk, srNo, existingLeave.getStartDate());
                    String ed = String.format(endDateSk, srNo, existingLeave.getEndDate());

                    out.println("\n");
                    out.println("<TR " + color + " >");
                    out.println("\n");
                    out.println(td + srNo++ + "</TD>");

                    out.println(id);

                    out.println(td + sd + "</TD>");
                    out.println(td + ed + "</TD>");
                    out.println("</TR>");
                }

                for (int i = 0; i < 10; i++) {
                    if (i % 2 == 0) {
                        if (color.equalsIgnoreCase(color1)) {
                            color = color2;
                        } else {
                            color = color1;
                        }
                    }

                    String id = String.format(idSk, "");

                    String sd = String.format(startDateSk, srNo, "");
                    String ed = String.format(endDateSk, srNo, "");
                    out.println("\n");
                    out.println("<TR " + color + " >");
                    out.println(id);

                    out.println("\n");
                    out.println(td + srNo++ + "</TD>");
                    out.println(td + sd + "</TD>");
                    out.println(td + ed + "</TD>");
                    out.println("</TR>");
                }

            %>

        </Table>

        <BR>
        <BR>

        <input type="hidden" name="Action" value="save">

        <%
            out.print(String.format(shortNameSk, shortName));
        %>

        <input type="Submit" value="Save">

    </form>
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