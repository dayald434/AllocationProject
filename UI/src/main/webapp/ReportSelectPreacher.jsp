<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="java.util.List" %>
<html>

<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/common.js"></script>

    <script>

        function resizeIframe(obj) {
            obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
            window.parent.parent.scrollTo(0, 0);
        }
    </script>

    <script type="text/javascript">

        function startUp() {
            var startDate = getDateByYearsOffset1(-1);
            var endDate = getDateByYearsOffset1(2);
            document.getElementById('StartDate').min = startDate;
            document.getElementById('StartDate').max = endDate;
            document.getElementById('EndDate').min = startDate;
            document.getElementById('EndDate').max = endDate;

        }

        window.onload = startUp;


        function compare() {
            var startDt = document.getElementById("StartDate").value;
            var endDt = document.getElementById("EndDate").value;
            startDate = new Date(startDt);
            endDate = new Date(endDt);


            if ((startDate.getTime() > endDate.getTime())) {
                alert("Start Date should be less than or equals to  End Date !!!");
                return false;
            }
            return true;
        }

        function loadSchedule() {

            var shortName = document.getElementById('ShortName').value;
            var startDate = document.getElementById('StartDate').value;
            var endDate = document.getElementById('EndDate').value;

            if (!compare())
                return false;

            var url = "ReportSewadarAlloc.jsp?ShortName=" + shortName + "&StartDate=" + startDate + "&EndDate=" + endDate;
            document.getElementById('sframe').src = url;
            return false;
        }

    </script>

    <%--<style type="text/css" media="print">--%>
        <%--@page {--%>
            <%--size: auto;   /* auto is the initial value */--%>
            <%--margin: 0;  /* this affects the margin in the printer settings */--%>
        <%--}--%>
    <%--</style>--%>

</head>
<body bgcolor="#fffff0">

<%
    String ua = request.getHeader("User-Agent");
    String userName = (String) session.getAttribute("UserName");
    if (ua.indexOf("Chrome") == -1) {
        out.print(" This Application is supported only in Google Chrome !!!");
        return;
    }

    if (Strings.isNullOrEmpty(userName)) {
        response.sendRedirect("../Login.jsp");
        return;
    }

%>

<jsp:include page="menu.jsp"/>

<center>

    <form class="formSmall" action="" onsubmit="return(loadSchedule());">
        <BR>
        <font class="header1"><B class="header1">Sewadar Report</B></font>

        <table class="table1" align="center" style="width:70%">

            <tr>
                <td><I>Satsang Ghar</I></td>
                <td>

                    <select class="txt1" required name="ShortName" id="ShortName" class="txt1">
                        <option value="">Select Sewadar</option>

                        <%

                            String optionSkeleton = "<option value=\"%s\">%s</option>";
                            ApiHelper apiHelper = new ApiHelper();
                            List<Preacher> preacherList = apiHelper.getAllPreacher();
                            for (int i = 0; i < preacherList.size(); i++) {
                                String s = String.format(optionSkeleton, preacherList.get(i).getShortName(),
                                        preacherList.get(i).getName() + "(" + preacherList.get(i).getShortName() + ")");
                                out.println(s);
                            }
                        %>
                    </select>

                </td>
            </tr>

            <tr>
                <td><I>Start Date </I></td>
                <td><input class="txt1" type="date" required id="StartDate" name="StartDate" min="2017-10-02" max="2017-10-02"></td>
            </tr>

            <tr>
                <td><I>End Date</I></td>

                <td><input class="txt1" type="date" required id="EndDate" name="EndDate" min="2017-10-02" max="2017-10-02"></td>
            </tr>

            <tr>
                <td></td>
                <td></td>
            </tr>

            <TR>
                <TD align="center" colspan="2"><input type="submit" value="Start"></td>


            </TR>

        </table>
    </form>

    <iframe src="ReportSewadarAlloc.jsp?Action=Load" id="sframe" frameborder="0" scrolling="no" style="width: 90%" onload="resizeIframe(this)"/>

</center>

</body>
</html>
