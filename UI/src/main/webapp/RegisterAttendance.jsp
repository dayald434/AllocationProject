<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Attendance" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
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

            try {

                if (!request.getMethod().equalsIgnoreCase("POST")) {
                    out.print("This Way is not allowed !!!");
                    return;
                }

                ApiHelper apiHelper = new ApiHelper();
                Long sgId = getLong(request.getParameter("SgId"));



                    String[] dateArray = request.getParameterValues("Date");

                    if (null == dateArray)
                        return;
                    for (int i = 0; i < dateArray.length; i++) {
                        String date = dateArray[i];

                        String Preacher = request.getParameter("Preacher"+date);
                        String pathi = request.getParameter("Pathi"+date);
                        String lang = request.getParameter("Lang");
    					String book=request.getParameter("book");
    					String saint=request.getParameter("saint");
    					Long gents = getLong(request.getParameter("gents"));
    					Long ladies = getLong(request.getParameter("ladies"));
    					Long children = getLong(request.getParameter("children"));
    					Long four_wheeler = getLong(request.getParameter("four_wheeler"));
    					Long two_wheeler = getLong(request.getParameter("two_wheeler"));
    					String shabad=request.getParameter("shabad");
                        boolean isCD = false;
                        if ("CD".equalsIgnoreCase(lang)) {
                            isCD = true;
                        }

                        
                        Attendance attendance=Attendance.builder().sgId(sgId).date(date).preacher(Preacher).pathi(pathi)
                        		.book(book).saint(saint).gents(gents).ladies(ladies).children(children)
                        		.four_wheeler(four_wheeler).two_wheeler(two_wheeler).shabad(shabad).build();
                        apiHelper.addAttendance(attendance);
                        		
                    }

            } catch (Exception e) {
                out.print(e.getMessage());
                return;
            }

        %>

        Sewadar Added to System Sucessfully!!!

    </font>

</CENTER>
</body>
</html>
<%!
    private Long getLong(String parameter) {

        System.out.println("Paramer is : " + parameter);
        if (Strings.isNullOrEmpty(parameter) || "null".equalsIgnoreCase(parameter))
            return null;
        else
            return Long.parseLong(parameter);
    }
%>
