<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register New SG</title>
</head>
<body>

<%
    String userName = (String) session.getAttribute("UserName");
    if (Strings.isNullOrEmpty(userName)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<%


    ApiHelper apiHelper = new ApiHelper();

    String name = request.getParameter("Name");

    if (!apiHelper.isSGUnique(name)) {
        out.print("We have SG of name " + name);
        out.print("<A href=\"registerForm.jsp\"> Back</A>");
        return;
    }

    String type = request.getParameter("Type");
    String address1 = request.getParameter("Address1");
    String address2 = request.getParameter("Address2");
    Long parentCentre = getLong(request.getParameter("ParentCentre"));

    String city = request.getParameter("City");
    String state = request.getParameter("State");
    String pin = request.getParameter("pin");
    String mapLink = request.getParameter("MapLink");
    String landline1 = request.getParameter("Landline1");
    String landline2 = request.getParameter("Landline2");
    Long mobile1 = getLong(request.getParameter("Mobile1"));
    Long mobile2 = getLong(request.getParameter("Mobile2"));
    String secretaryName = request.getParameter("SecretaryName");
    Long secretaryMobile = getLong(request.getParameter("SecretaryMobile"));

    String[] day = request.getParameterValues("day");
    String[] time = request.getParameterValues("Time");

    List<Schedule> scheduleList = new ArrayList<Schedule>();


    if (day[0].equalsIgnoreCase("")) {

        out.print(" Please selecddt Satsang Day");
        response.sendRedirect("Register3.jsp");
        return;
    }


    for (int i = 0; i < day.length; i++) {
        Schedule schedule = Schedule.builder().day(day[i]).time(time[i]).build();
        scheduleList.add(schedule);
    }

    SatsangGhar satsangGhar = SatsangGhar.builder().name(name).centerType(type).parentCenterid(parentCentre).address1(address1)
            .address2(address2).city(city).state(state).pinCode(pin).map(mapLink).landline1(landline1).landline2(landline2)
            .mobile1(mobile1).mobile2(mobile2).secName(secretaryName).secMobile(secretaryMobile).build();
    apiHelper.addSatsangGhar(satsangGhar, scheduleList);
%>
registration done

<A href="Register3.jsp"> add more SG</A>

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
