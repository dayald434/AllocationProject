<%@page import="java.awt.print.Book"%>
<%@ page import="com.rssb.api.helper.HtmlGenerator"%>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper"%>
<%@ page import="com.rssb.common.entity.SatsangGhar"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.common.base.Strings"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.common.base.Strings"%>
<%@ page import="com.rssb.api.filter.DayAvailFilter"%>
<%@ page import="com.rssb.api.filter.FilterList"%>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper"%>
<%@ page import="com.rssb.common.entity.Allocation"%>
<%@ page import="com.rssb.common.entity.Leave"%>
<%@ page import="com.rssb.common.entity.Preacher"%>
<%@ page import="com.rssb.common.entity.PreacherAllocation"%>
<%@ page import="com.rssb.common.entity.PreacherType"%>
<%@ page import="com.rssb.common.entity.SatsangGhar"%>
<%@ page import="com.rssb.common.entity.SatsangGhar"%>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper"%>
<%@ page import="com.rssb.common.entity.Schedule"%>
<%@ page import="com.rssb.common.helper.Util"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.rssb.common.entity.Attendance"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.concurrent.ConcurrentHashMap"%>
<html>

<head>
<link rel="stylesheet" type="text/css" href="css/common.css" />
<script src="js/common.js"></script>
<script src="js/city.js"></script>


<style>
.txt1 {
	width: 97%;
	height: 45%;
}

.txt11 {
	width: 42%;
	height: 45%;
	display: inline-block;
}

.blank_row {
	height: 25px
}

.form11 {
	width: 82%;
	margin-top: 2%;
	border-color: lightgrey;
	border-style: outset;
}

.cl1 {
	width: 94%;
	height: 25px;
	margin-top: 0%;
}
</style>
<script type="text/javascript">
    function isNumber(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
    
    </script>
<datalist id="Book">
	<option value="santo ki bani ">
	<option value="shabad ki mahima ke shabad">
	<option value="Sar Bachan">
	<option value="chuna huai bhabad">
</datalist>
<datalist id="saint">
	<option value="Sant Namdev Ji ">
	<option value="Sant Tukaram Ji">
	<option value="Sant Kabir Ji">
	<option value="Dhani Dharamdas Ji">
	<option value="Guru Ravidas Ji">
	<option value="Surdas Ji">
	<option value="Goswami Tulsidas Ji">
	<option value="Sant Dadu Dayal Ji">
	<option value="Jagjivan Sahib Ji">
	<option value="Paltu Sahib Ji">
	<option value="Dariya Sahib Ji">
	<option value="Sant Charandas Ji">
	<option value="Sahjobai Ji">
	<option value="Malookdas Ji">
	<option value="Dharnidas Ji">
	<option value="Gareebdas Ji">
	<option value="Sheikh Farid Ji">
	<option value="Guru Nanak Dev Ji">
	<option value="Guru Amar Das Ji">
	<option value="Guru Ramdas Ji">
	<option value="Guru Arjun Dev Ji">
	<option value="Guru Tegh Bahadur Ji">
	<option value="Guru Gobind Singh Ji">
	<option value="Tulsi Sahib Ji">
	<option value="Bani Soami Ji Maharaj">
</datalist>
<script type="text/javascript">

        function startUp() {
            var today = getTodayDate();
            document.getElementById('InitDate').max = today

        }

        window.onload = startUp;

    </script>

</head>
<body bgcolor="#fffff0">


	<jsp:include page="menu.jsp" />



	<%
		ApiHelper apiHelper = new ApiHelper();
		Map<String, Object> context = new ConcurrentHashMap();
		String action = request.getParameter("Action");
		if (!Strings.isNullOrEmpty(action) && action.equalsIgnoreCase("Load"))
			return;

		Long sgId = getLong(request.getParameter("SgId"));

		if (null == sgId) {
			out.println("Please Select Satsang Ghar name ");
			return;
		}

		String date = request.getParameter("Date");
		if (Strings.isNullOrEmpty(date)) {
			out.println("Please select  Date ");
			return;
		}
		SatsangGhar satsangGhar = apiHelper.getSatsangGharById("" + sgId);
		Map<String, Schedule> sMap = apiHelper.getScheduleMap(sgId);
		
		Attendance attendance = apiHelper.getAttendance(sgId,date);
		
	%>

	<center>

		<form class="form11" action="RegisterAttendance.jsp" method="post"
			name="PreacherForm" onsubmit="return(validate());">
			<BR> <font class="header1"><B class="">Satsang Attendance</B></font>

			<TABLE cellspacing="3" align="center"
				style="height: 50%; border: none; width: 80%; margin: auto; margin-top: 4%;"
				class="table1">
				<TD>SG Name <%
					out.print(satsangGhar.getName());
				%>

				</TD>

				</TD>
				<TD>Date <%
					out.print(date);
				%>

				</TD>
				</TR>
				<TR>


					<TD><input <%out.println("value='" + attendance.getBook() + "'");%> name="book" id="book" class="txt1" 
						placeholder="Book" list=Book value=<%out.print(attendance.getBook()); %>>  ></TD>
				<TR>
					<TD colspan="2"><input name="shabad" id="shabad" class="txt1"
						placeholder="shabad" ng-pattern-restrict
						style="text-transform: capitalize;" /></TD>
					<TD><input  <%out.println("value='" + attendance.getSaint() + "'");%> name="saint" id="Saint" class="txt1"
						placeholder="Saint" list=saint></TD>
					<td><input  <%out.println("value='" + attendance.getGents() + "'");%> name="gents" id="gents" class="txt11"
						placeholder="Gents" onkeypress="return isNumber(event)"></td>
				</TR>
				<TR>
					<TD> <%out.println("value='" + attendance.getLadies() + "'");%><input name="ladies" id="ladies" class="txt11"
						placeholder="Ladies" onkeypress="return isNumber(event)">
					</TD>
					<TD style="border: none;"><input  <%out.println("value='" + attendance.getChildren() + "'");%> name="children" id="children"
						class="txt11" placeholder="Children"
						onkeypress="return isNumber(event)"></TD>
					<td><input  <%out.println("value='" + attendance.getTwo_wheeler() + "'");%> name="two_wheeler" id="twoweeler" class="txt11"
						placeholder="Two_weeler" onkeypress="return isNumber(event)">
					</td>
					<TD style="border: none;"><input  <%out.println("value='" + attendance.getFour_wheeler() + "'");%> name="four_wheeler"
						id="four wheeler" class="txt11" placeholder="Four_weeler"
						onkeypress="return isNumber(event)">
				</TR>
			</TABLE>



			<TABLE cellspacing="3" align="center" style="width: 75%;"
				class="table1">

				<TR class="blank_row">
					<td></td>

				</TR>

				<TR>
					<TD align="center"><input type="submit" value="Submit" /></TD>
					<TD align="center"><input action="action"
						onclick="window.history.go(-1); return false;" type="button"
						value="Back" /></TD>

				</TR>
				<TR class="blank_row">
					<td></td>

				</TR>
			</TABLE>
		</form>
	</center>
	<%--<script language="javascript">print_state("State");</script>--%>
</body>
<%!private String getDisplayedValue(Preacher preacher) {
		String prepend = "";
		if (preacher.getType().equalsIgnoreCase(PreacherType.Pathi.toString()))
			prepend = "P-";
		else if (preacher.getType().equalsIgnoreCase(PreacherType.Karta.toString()))
			prepend = "SK-";
		else if (preacher.getType().equalsIgnoreCase(PreacherType.Reader.toString()))
			prepend = "SR-";

		return prepend + preacher.getName() + "(" + preacher.getShortName() + ")";
	}

	private void appendDefaultPreacher(List<Preacher> list, String defaultValue) throws Exception {

		boolean isPresent = false;
		for (Preacher preacher : list) {
			if (defaultValue.equalsIgnoreCase(preacher.getShortName())) {
				isPresent = true;
				break;
			}
		}
	}

	private String printPreacher(String name, String dateStr, List<Preacher> list, String cl, String defaultValue,
			String disable) throws Exception {
		String start = "<select class=\"" + cl + "\"  name=\"" + name + dateStr + "\"  " + disable + "  >"
				+ "<option value=\"\">Select " + name + "</option>";

		System.out.println("DV: " + defaultValue);
		if ("\"\"".equalsIgnoreCase(defaultValue) || null == defaultValue)
			defaultValue = "";

		if (!Strings.isNullOrEmpty(defaultValue)) {
			appendDefaultPreacher(list, defaultValue);
		}

		String end = "\n</select>";
		String selected = "selected=\"selected\"";
		String optionSkeleton = "\n<option value=\"%s\"  %s >%s</option>\n";

		String output = "";
		for (Preacher preacher : list) {
			String optionList = String.format(optionSkeleton, preacher.getShortName(),
					defaultValue.equalsIgnoreCase(preacher.getShortName()) ? selected : "",
					getDisplayedValue(preacher));
			output += optionList;
		}

		return start + output + end;
	}

	public Long getLong(String parameter) {

		System.out.println("Parameter is : " + parameter);
		if (Strings.isNullOrEmpty(parameter))
			return null;
		else
			return Long.parseLong(parameter);
	}%>
</html>
