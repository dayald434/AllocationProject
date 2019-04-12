<%--
  Created by IntelliJ IDEA.
  User: arun
  Date: 7/8/17
  Time: 2:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" language="javascript">
        function disableBackButton()
        {
            alert("Hello");
            window.history.forward();
        }
        disableBackButton();
        window.onload=disableBackButton();
        window.onpageshow=function() {  disableBackButton(); }
        window.onunload=function() { void(0) }
    </script>
</head>

<body onLoad="noBack();" onpageshow="noBack();" onUnload="">
<jsp:include page="menu.jsp"/>

Success !!

</body>
</html>
