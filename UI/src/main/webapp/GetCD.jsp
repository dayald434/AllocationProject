<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.rssb.api.helper.StaticContent" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rssb.common.entity.CD" %><%--
  Created by IntelliJ IDEA.
  User: arun
  Date: 7/8/17
  Time: 12:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<%

    ApiHelper apiHelper = new ApiHelper();
    List<CD> cdList = StaticContent.getCDs();
    Gson gson = new Gson();
    String res = gson.toJson(cdList);
    out.println(res);

%>


