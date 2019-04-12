<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/common.js"></script>

    <script>function validateUniqueShortName(value) {
        if (value != '') {
            var xmlHttp = new XMLHttpRequest();
            xmlHttp.open("GET", "ShortName.jsp?ShortName=" + value.toUpperCase(), false); // false for synchronous request
            xmlHttp.send(null);
            res = xmlHttp.responseText;
            if (res.trim().toLowerCase() == 'false') {
                alert("Short Name Not Available: " + value);
                document.PreacherForm.ShortName.value = ""
                document.PreacherForm.ShortName.focus();


            }
        }

    }

    function validate() {


        if (document.PreacherForm.SgId.value == "") {
            alert("Please Select Satsang Ghar!");
            document.PreacherForm.SgId.focus();
            return false;
        }


        if (document.PreacherForm.Mobile1.value.localeCompare(document.PreacherForm.Mobile2.value) == 0) {
            alert("Mobile2 should be different from Mobile1");
            document.PreacherForm.Mobile2.focus();
            return false;

        }


        if (document.PreacherForm.Sex.value == "") {
            alert("Please Select sex!");
            document.PreacherForm.Sex.focus();
            return false;
        }


        if (document.PreacherForm.Language1.value == "" && document.PreacherForm.Language2.value == "" &&
            document.PreacherForm.Language3.value == "" && document.PreacherForm.Language4.value == "") {
            alert("Please select at least one Language!");
            document.PreacherForm.Language1.focus();
            return false;
        }
    }

    </script>

    <style>
        .txt1 {
            width: 220px;
            height: 25px;
        }

        .blank_row {
            height: 25px
        }

    </style>
    <script type="text/javascript">
        function startUp() {
            var today = getTodayDate()
            document.getElementById('InitDate').max = today

        }

        window.onload = startUp;

    </script>

</head>
<body bgcolor="#fffff0">

<%!
    public String getAction(HttpServletRequest request) {
        String action = request.getParameter("Action");
        if (action.equalsIgnoreCase("Edit"))
            return "PreacherEdit.jsp";
        return "PreacherView.jsp";
    }
%>

<jsp:include page="menu.jsp"/>

<center>

    <form class="form1" action="<% out.print(getAction(request)); %>" method="post" name="PreacherForm" onsubmit="return(validate());">
        <BR>
        <font class="header1"><B class="">Select Sewadar</B></font>

        <TABLE align="center" style=" border: none" class="table1">

            <TR>

                <TD>
                    <select required name="ShortName" id="ShortName" class="txt1">
                        <option value="">Select Sewadar</option>

                        <%

                            String optionSkeleton = "<option value=\"%s\">%s</option>";
                            ApiHelper apiHelper = new ApiHelper();
                            List<Preacher> preacherList = apiHelper.getAllPreacher();
                            for (int i = 0; i < preacherList.size(); i++) {
                                String s = String.format(optionSkeleton, preacherList.get(i).getShortName(),
                                        preacherList.get(i).getName() + "(" + preacherList.get(i).getShortName() + ")");
                                out.println(s);
                            }
                        %>
                    </select>
                </TD>
            </TR>
            <TR class="blank_row">
                <td></td>
            </TR>

            <TR>
                <TD align="center">
                    <input type="submit" value="Continue"/>
                </TD>

            </TR>
            <TR class="blank_row">
                <td>

                </td>

            </TR>
        </TABLE>
    </form>
</center>

</body>
</html>
