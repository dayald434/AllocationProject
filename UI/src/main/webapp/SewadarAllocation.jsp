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
            var startDate = getTodayDate()
            var endDate = getDateByYearsOffset(1);
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

            var sgId = document.getElementById('SgId').value;
            var startDate = document.getElementById('StartDate').value;
            var endDate = document.getElementById('EndDate').value;

            if (!compare())
                return false;

            var url = "Scheduling.jsp?SgId=" + sgId + "&StartDate=" + startDate + "&EndDate=" + endDate;
            document.getElementById('sframe').src = url;
            return false;
        }

    </script>

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
        <font class="header1"><B class="header1">Sewadar Sewa Report</B></font>

        <table class="table1" align="center" style="width:70%">

            <tr>
                <td><I>Sewadar Short-ID</I></td>
                <td>
                    <select required name="SgId" id="SgId">
                        <option value="">Select Sewadar</option>

                        <%
                            String option = "<option value=\"%s\">%s(%s)</option>";

                            ApiHelper apiHelper = new ApiHelper();
                            List<Preacher> list = apiHelper.getAllPreacher();
                            for (Preacher preacher : list) {

                                out.println(String.format(option, preacher.getShortName(), preacher.getShortName(), preacher.getName()));
                            }

                        %>

                    </select>
                </td>
            </tr>

            <tr>
                <td><I>Start Date </I></td>
                <td><input type="date" required id="StartDate" name="StartDate" min="2017-10-02" max="2017-10-02"></td>
            </tr>

            <tr>
                <td><I>End Date</I></td>

                <td><input type="date" required id="EndDate" name="EndDate" min="2017-10-02" max="2017-10-02"></td>
            </tr>

            <tr>
                <td></td>
                <td></td>
            </tr>

            <TR>
                <TD align="center" colspan="2"><input type="submit" value="Start">
            </TR>

        </table>
    </form>
    <iframe src="Scheduling.jsp?Action=Load" id="sframe" frameborder="0" scrolling="no" style="width: 90%" onload="resizeIframe(this)"/>

    <%--<iframe id="sframe" src="Scheduling.jsp"  style="width: 90%" frameborder=""--%>
    <%--onload="window.parent.parent.scrollTo(0,0)"></iframe>--%>
</center>

</body>
</html>
