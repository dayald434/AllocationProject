<%@page import="java.util.Collections"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="com.google.common.base.Strings"%>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper"%>
<%@ page import="com.rssb.common.entity.SatsangGhar"%>
<%@ page import="java.util.List"%>
<html>

<head>
<meta charset="utf-8">
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />
<script src="js/common.js"></script>

<script>
	function resizeIframe(obj) {
		obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
		window.parent.parent.scrollTo(0, 0);
	}
</script>
<style type="text/css">
.txt11 {
    width: 79%;
    height: 63%;
}
</style>

<link rel="stylesheet"
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script>
	$(document).ready(
			function() {
				$('#startDate').datepicker(
						{
							dateFormat : 'dd-mm-yy',
							onSelect : function() {
								var weeks = $('#weeks').val();

								var startDate = $('#startDate').datepicker(
										'getDate');
								var d = new Date(startDate);

								var newDate = new Date(d.getFullYear(), d
										.getMonth(), d.getDate() - weeks * 7);

								$('#endDate').datepicker('setDate', newDate);
							}
						});
				$('#endDate').datepicker({
					dateFormat : 'dd-mm-yy'
				});
			});
	function loadSchedule() {

		var sgId = document.getElementById('SgId').value;
		var startDate = document.getElementById('StartDate').value;
		var endDate = document.getElementById('EndDate').value;

		if (!compare())
			return false;

		var url = "Att.jsp?SgId=" + sgId + "&StartDate=" + startDate
				+ "&EndDate=" + endDate;
		document.getElementById('sframe').src = url;
		return false;
	}
</script>

</head>
<body bgcolor="#fffff0">

	<%
		/* String ua = request.getHeader("User-Agent");
		 String userName = (String) session.getAttribute("UserName");
		 if (ua.indexOf("Chrome") == -1) {
		 out.print(" This Application is supported only in Google Chrome !!!");
		 return;
		 }
		
		 if (Strings.isNullOrEmpty(userName)) {
		 response.sendRedirect("Login.jsp");
		 return;
		 }*/
	%>

	<jsp:include page="menu.jsp" />

	<center>

		<form class="formSmall" action="Att11.jsp" method="get">
			<BR> <font class="header1"><B class="header1">Satsang
					Attendance</B></font>

			<table class="table1" align="center" style="width: 70%">

				<tr>
					<td><I> Date</I></td>
					<td><select class="txt11" required name="Date" id="SgId">
							<option value="">Select Date</option>

							<%
								String sgId = request.getParameter("SgId");

								String option = "<option value=\"%s\">%s</option>";

								ApiHelper apiHelper = new ApiHelper();
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								SimpleDateFormat displayFormat = new SimpleDateFormat("dd-MMM-yyyy  (EEEE)");

								Date today = new Date();
								Calendar cal = Calendar.getInstance();
								cal.add(Calendar.MONTH, -3);
								Date startDate = cal.getTime();

								List<Date> list = apiHelper.getDates(Long.parseLong(sgId), sdf.format(startDate), sdf.format(today));
								Collections.sort(list, Collections.reverseOrder());

								for (Date date : list) {

									out.println(String.format(option, sdf.format(date), displayFormat.format(date)));
								}
							%>

					</select></td>
				</tr>

<input name="SgId" type="hidden" value="<% out.print(sgId); %>" >
<tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr>
				<TR>
				
					<TD align="center" colspan="5">
					
					<input type="submit"
						value="Continue" style="height: 20%;">
				</TR>
			</TABLE>

		</form>

	</center>
</body>
</html>
