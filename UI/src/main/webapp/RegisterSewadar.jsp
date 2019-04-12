<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
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
                String shortName = request.getParameter("ShortName");
                String oldShortName = request.getParameter("OldShortName");
                List<Preacher> pr = apiHelper.getPreacher("upper(short_name)=upper('" + shortName + "') ");

                if (Strings.isNullOrEmpty(oldShortName)) {
                    if (pr.size() > 0)
                        throw new RuntimeException("Short Name is already being used for" + pr.get(0).getName() + "!!!!!");
                }

                if (!Strings.isNullOrEmpty(oldShortName) && !oldShortName.equalsIgnoreCase(shortName)) {
                    if (pr.size() > 0)
                        throw new RuntimeException("Short Name is already being used for" + pr.get(0).getName() + "!!!!!");
                }

                String name = request.getParameter("Name");
                String initDate = request.getParameter("InitDate");
                String type = request.getParameter("Type");
                String sex = request.getParameter("Sex");

                Long sgId = getLong(request.getParameter("SgId"));

                Long mobile1 = getLong(request.getParameter("Mobile1"));
                Long mobile2 = getLong(request.getParameter("Mobile2"));
                String city = request.getParameter("City");
                String address = request.getParameter("Address");
                String tp = request.getParameter("Tp");

                String[] availDays = request.getParameterValues("Avail");

                String language1 = request.getParameter("Language1");
                String language2 = request.getParameter("Language2");
                String language3 = request.getParameter("Language3");
                String language4 = request.getParameter("Language4");

                String lang[] = {language1, language2, language3, ""};

                Preacher preacher = Preacher.builder().name(name).shortName(shortName).iniDate(initDate).sgId(sgId).
                        sex(sex).type(type).mobile1(mobile1).mobile2(mobile2).lang(lang).city(city).tp(tp).availableDays(availDays).address(address).city(city).build();

                System.out.println(preacher);
                if (Strings.isNullOrEmpty(oldShortName))
                    apiHelper.addPreacher(preacher);
                else
                    apiHelper.updatePreacher(preacher, oldShortName);
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
