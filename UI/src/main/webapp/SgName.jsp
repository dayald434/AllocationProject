<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %><%--
  Created by IntelliJ IDEA.
  User: arun
  Date: 7/8/17
  Time: 12:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    ApiHelper apiHelper = new ApiHelper();
    String name = request.getParameter("SgName");
    out.print(apiHelper.isSGUnique(name));

%>


