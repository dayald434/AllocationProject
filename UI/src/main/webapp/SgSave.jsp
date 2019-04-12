<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="com.rssb.common.helper.Util" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>

</head>
<body>

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

<CENTER>
    <BR>
    <BR>
    <BR><BR>
    <BR>
    <BR><BR>
    <BR>
    <BR>
    <font class="header1">

            <%

    if (!request.getMethod().equalsIgnoreCase("POST")) {
        out.print("This Way is not allowed !!!");
        return;
    }

    String sgId = request.getParameter("SgId");



    ApiHelper apiHelper = new ApiHelper();

    String name = request.getParameter("Name");

    if (Strings.isNullOrEmpty(sgId)&&!apiHelper.isSGUnique(name)) {
        out.print("We have SG of name " + name);
        return;
    }



    String type = request.getParameter("Type");
    String address1 = request.getParameter("Address1");
    String address2 = request.getParameter("Address2");
    Long parentCentre = getLong(request.getParameter("ParentCentre"));

    String city = request.getParameter("City");
    String state = request.getParameter("State");
    String mapLink = request.getParameter("MapLink");
    String landline1 = request.getParameter("Landline1");
    String landline2 = request.getParameter("Landline2");
    Long mobile1 = getLong(request.getParameter("Mobile1"));
    Long mobile2 = getLong(request.getParameter("Mobile2"));
    String secretaryName = request.getParameter("SecretaryName");
    Long secretaryMobile = getLong(request.getParameter("SecretaryMobile"));
    String pincode = request.getParameter("Pincode");


    String[] day = request.getParameterValues("day");

    List<Schedule> scheduleList = new ArrayList<Schedule>();

    for (int i = 0; i < day.length; i++) {

        System.out.println("++++" + day[i] + "W1");

        String w1Lang = request.getParameter(day[i] + "W1");
        System.out.println("+++++++++" + w1Lang);

        String w2Lang = request.getParameter(day[i] + "W2");
        String w3Lang = request.getParameter(day[i] + "W3");
        String w4Lang = request.getParameter(day[i] + "W4");
        String w5Lang = request.getParameter(day[i] + "W5");
        String time = request.getParameter(day[i] + "Time");

        String lang[] = {w1Lang, w2Lang, w3Lang, w4Lang, w5Lang};


        if (Strings.isNullOrEmpty(time))
            time = "00:00";

        Schedule schedule = Schedule.builder().day(day[i]).time(time).lang(lang).build();
        scheduleList.add(schedule);
    }

    SatsangGhar satsangGhar = SatsangGhar.builder().name(name).centerType(type).parentCenterid(parentCentre).address1(address1)
            .address2(address2).city(city).state(state).pinCode(pincode).map(mapLink).landline1(landline1).landline2(landline2)
            .mobile1(mobile1).mobile2(mobile2).secName(secretaryName).secMobile(secretaryMobile).build();
    if (!Strings.isNullOrEmpty(sgId))
        satsangGhar.setId(getLong(sgId));
    apiHelper.addSatsangGhar(satsangGhar, scheduleList);
%>
        Satsang Ghar Added/Updated Successfully !!!
</body>
</html>
<%!
    private Long getLong(String parameter) {

        System.out.println("Paramer is : " + parameter);
        if (Strings.isNullOrEmpty(parameter))
            return null;
        else
            return Long.parseLong(parameter);
    }
%>
