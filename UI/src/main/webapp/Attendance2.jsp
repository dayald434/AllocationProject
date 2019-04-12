<%@ page import="com.rssb.api.helper.HtmlGenerator" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.common.base.Strings" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.filter.DayAvailFilter" %>
<%@ page import="com.rssb.api.filter.FilterList" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.Allocation" %>
<%@ page import="com.rssb.common.entity.Leave" %>
<%@ page import="com.rssb.common.entity.Preacher" %>
<%@ page import="com.rssb.common.entity.PreacherAllocation" %>
<%@ page import="com.rssb.common.entity.PreacherType" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.entity.Schedule" %>
<%@ page import="com.rssb.common.helper.Util" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.rssb.common.entity.Attendance" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.concurrent.ConcurrentHashMap" %>
<html>

<head>
    <link rel="stylesheet" type="text/css" href="css/common.css"/>
    <script src="js/common.js"></script>
    <script src="js/city.js"></script>
    

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
            document.PreacherForm.Language3.value == "" ) {
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
            var today = getTodayDate();
            document.getElementById('InitDate').max = today

        }

        window.onload = startUp;

    </script>
     <script type="text/Javascript">
function checkDec(el){
 var ex = /^[0-9]+\.?[0-9]*$/;
 if(ex.test(el.value)==false){
   el.value = el.value.substring(0,el.value.length - 1);
  }
}
</script>
 <style>
        .font12 {
            font-size: 30px;
            color: green;
            width: 200px;
        }
       
    </style>
    <datalist id="Book">
  <option value="santo ki bani ">
  <option value="shabad ki mahima ke shabad">
  <option value="chuna huai bhabad">
  <option value="DDDDDDDDDDDDDD">
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
</head>
<body bgcolor="#fffff0">
<jsp:include page="menu.jsp"/>

<center>

    <form class="form1" action="RegisterSewadar.jsp" method="post" name="PreacherForm" onsubmit="return(validate());">
       
      
              <BR>
        <font class="header1"><B class="">Satsang Attendance</B></font>

        <TABLE cellspacing="3" align="center" style="height:50%; border: none; width: 90%;" class="table1">

            <TR>
                <TD>
                    <input  name="Shabad" id="shabad" class="txt1"  placeholder="shabad" pattern="[a-zA-Z][.a-zA-Z\s]*" ng-pattern-restrict style="text-transform: capitalize;"/>

                </TD>
                      <TD>
                    <input name="saint" id="Saint" class="txt1" placeholder="Saint" list=saint>

                </TD>

               <TD>
                    <input name="book" id="book" class="txt1" placeholder="Book" list=Book>
                </TD>
            </TR>
            <TR>
            <TD>
                    <input name="gents" id="book" placeholder="Gents" width="50%" class=font12 onkeyup=checkDec(this);>
                </TD>
                 <TD>
                    <input name="ladies" id="book" placeholder="Ladies" class=font12 onkeyup=checkDec(this);>

                </TD>
                 <TD>
                    <input name="childrens" id="book" placeholder="Childrens" class=font12 onkeyup=checkDec(this);>

                </TD>
                 <TD>
                    <input name="twowheelers" id="book" placeholder="Two_wheelers" class=font12 onkeyup=checkDec(this);>

                </TD>
                  <TD>
                    <input name="fourwheelers" id="book" placeholder="Four_wheelers" class=font12 onkeyup=checkDec(this);>

                </TD>
                </TR>
        </TABLE>

        <TABLE cellspacing="3" align="center" style=" width: 75%;" class="table1">

            <TR class="blank_row">
                <td>

                </td>

            </TR>

            <TR>
                <TD align="center">
                    <input type="submit" value="Submit"/>
                </TD>
              

            </TR>
            <TR class="blank_row">
                <td>

                </td>

            </TR>
        </TABLE>
    </form>
</center>
<%--<script language="javascript">print_state("State");</script>--%>
</body>

</html>
