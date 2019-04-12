<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
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
            var endDate = getDateByYearsOffset(2);
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

            var pathi = false;
            var reader = false;
            var karta = false;
            if (document.getElementById('Pathi').checked)
                pathi = "true";
            if (document.getElementById('Karta').checked)
                karta = "true";
            if (document.getElementById('Reader').checked)
                reader = "true";

            if (!compare())
                return false;

            var url = "Scheduling.jsp?SgId=" + sgId + "&StartDate=" + startDate + "&EndDate=" + endDate + "&IsCenterPathi=" + pathi +
                "&IsCenterKarta=" + karta + "&IsCenterReader=" + reader;
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
        response.sendRedirect("Login.jsp");
        return;
    }

%>

<jsp:include page="menu.jsp"/>

<center>

    <form class="formSmall" action="" onsubmit="return(loadSchedule());">
        <BR>
        <font class="header1"><B class="header1">Sewa Allotment</B></font>

        <table class="table1" align="center" style="width:70%">

            <tr>
                <td><I>Satsang Ghar</I></td>
                <td>
                    <select class="txt1" required name="SgId" id="SgId">
                        <option value="">Select Satsang Ghar</option>

                        <%
                            String option = "<option value=\"%s\">%s</option>";

                            ApiHelper apiHelper = new ApiHelper();
                            List<SatsangGhar> list = apiHelper.getAllSatsangGhar();
                            for (SatsangGhar satsangGhar : list) {

                                out.println(String.format(option, satsangGhar.getId(), satsangGhar.getName()));
                            }

                        %>

                    </select>
                </td>
            </tr>

            <tr>
                <td><I>Start Date </I></td>
                <td><input class="txt1" type="date" required id="StartDate" name="StartDate" min="2017-10-02"
                           max="2017-10-02"></td>
            </tr>

            <tr>
                <td><I>End Date</I></td>

                <td><input class="txt1" type="date" required id="EndDate" name="EndDate" min="2017-10-02"
                           max="2017-10-02"></td>

            </tr>
        </TABLE>


        <table class="table1" align="center" style="width:70%">

            <tr>
                <td colspan="3">

                    <font color="blue">
                        <small>Show Sewadar Only Attached to the Center</small>
                    </font>
                </td>
            </tr>


            <td><input type="checkbox" name="Pathi" value="Pathi" id="Pathi"><label for="Pathi">Pathi</label>
            </td>
            <td><input type="checkbox" name="Karta" value="Karta" id="Karta"><label for="Karta">Karta</label>
            </td>
            <td><input type="checkbox" name="Reader" value="Reader" id="Reader"><label
                    for="Reader">Reader</label></td>
            </tr>
            <TR>
            </TR>

            <TR>
                <TD align="center" colspan="5"><input type="submit" value="Start" style="height:20px; width:50px">
            </TR>
        </TABLE>

    </form>
    <iframe src="Scheduling.jsp?Action=Load" id="sframe" frameborder="0" scrolling="no" style="width: 90%"
            onload="resizeIframe(this)"/>

</center>

</body>
</html>
