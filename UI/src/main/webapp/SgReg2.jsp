<%@ page import="com.google.common.base.Strings" %>
<%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
<%@ page import="com.rssb.common.entity.SatsangGhar" %>
<%@ page import="com.rssb.common.helper.HtmlGenerator" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: devi
  Date: 30/7/17
  Time: 5:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <script>
        function validate() {
            if (document.RSSBRegistration.Name.value == "") {
                alert("Please provide your Name!");
                document.RSSBRegistration.Name.focus();
                return false;
            }
            if (( RSSBRegistration.Type[0].checked == false ) && ( RSSBRegistration.Type[1].checked == false ) && ( RSSBRegistration.Type[2].checked == false )) {
                alert("Please must choose your Centre Type");
                return false;
            }
            if ((document.RSSBRegistration.ParentCentre.value == "") && (RSSBRegistration.Type[0].checked == false)) {
                alert("Please provide your ParentCentre!");
                document.RSSBRegistration.ParentCentre.focus();
                return false;
            }

            return ( true );

            if (document.RSSBRegistration.Address1.value == "") {
                alert("Please provide Centre Address!");
                document.RSSBRegistration.Address1.focus();
                return false;
            }

            if (document.RSSBRegistration.City.value == "-1") {
                alert("Please provide your City!");
                document.RSSBRegistration.City.focus();
                return false;
            }
            if (document.RSSBRegistration.State.value == "-1") {
                alert("Please provide State!");

                return false;
            }

        }
    </script>

    <script type="text/javascript">
        function disablefield() {
            if (document.getElementById('no_radio').checked == 1) {
                document.getElementById('ParentCentre').disabled = 'disabled';
                document.getElementById('ParentCentre').value = '';
            } else {
                document.getElementById('ParentCentre').disabled = '';
            }
        }

        function disablefield1() {
            document.getElementById('ParentCentre').disabled = 'disabled';
        }

        window.onload = disablefield1
    </script>

    <script>
        $(document).ready(function () {
            $('#RSSBRegistration').formValidation({
                framework: 'bootstrap',
                icon: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    message: {
                        // The messages for this field are shown as usual
                        validators: {
                            notEmpty: {
                                message: 'The message is required'
                            },
                            stringLength: {
                                min: 20,
                                max: 500,
                                message: 'The message must be more than 20 and less than 500 characters long'
                            }
                        }
                    },
                    name: {
                        // Show the message in a tooltip
                        err: 'tooltip',
                        validators: {
                            notEmpty: {
                                message: 'The Name  is required'
                            }

                        }
                    }
                }
            });
        });
    </script>

</head>
<body>

<style>
    .txt1 {
        width: 220px;
        height: 27px;
    }

    .txt2 {
        width: 80%;
        border: hidden;
        background-color: ivory;
    }

    .txt3 {
        width: 80%;
        border: hidden;
        background-color: ivory;

        /*height: 27px;*/
    }

    .cl1 {
        background-color: ivory;
        border: hidden;
    }

    .cl2 {
        background-color: lightgray;
        border: hidden;
    }

</style>

<center><H2>Satsang Ghar Registration</H2></center>
<BR>
<%
    String userName = (String) session.getAttribute("UserName");
    if (Strings.isNullOrEmpty(userName)) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<form action="SgSave.jsp" name="RSSBRegistration" onsubmit="return(validate());">

    <center>

        <table align="center" style="width:50%">

            <%-- Item 1--%>
            <tr>
                <td colspan="2">
                    <input name="Name" id="Name" class="txt1" placeholder="Name*" tabindex=1/>
                </td>
            </tr>

            <%-- Item 2--%>
            <TR>
                <td>
                    <input tabindex=2 type="radio" class="radioBtn" id="no_radio" name="Type" value="Centre"
                           size="10" onChange="disablefield();" checked="checked">Centre
                    <input type="radio" class="radioBtn" id="yes_radio" name="Type" value="Sub-Centre" size="10"
                           onChange="disablefield();">Sub-Centre
                    <input type="radio" class="radioBtn" id="yes_radio1" name="Type" value="Point" size="10"
                           onChange="disablefield();">Point
                </td>
                <td>
                    <%
                        ApiHelper apiHelper = new ApiHelper();
                        List<SatsangGhar> result = apiHelper.searchSatsangGharByPredicate("ctype  ='Centre'");

                        String start = "<select  class=\"txt1\" tabindex=3  id=\"ParentCentre\"  name=\"ParentCentre\"   " +
                                "class=\"field-style field-split align-right\" " +
                                " placeholder=\"Parent Centre*\"/>     >" +
                                "<option value=\"\">Select Parent Centre</option>";

                        String end = "\n</select>";
                        String optionSkeleton = "\n<option value=\"%s\"  %s >%s</option>\n";

                        String output = "";
                        for (SatsangGhar ghar : result) {
                            String optionList = String.format(optionSkeleton, ghar.getId(), "", ghar.getName());
                            output += optionList;
                        }

                        out.println(start + output + end);

                    %>

                </td>

            </TR>

            <%-- Item 3--%>

            <TR>
                <TD>
                    <input tabindex=8 name="Address1" id="Address1" class="txt1" placeholder="Address1"/>
                </TD>
                <TD>
                    <input tabindex=9 type="text" name="Address2" id="Address2" class="txt1" placeholder="Address2"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input tabindex=10 type="text" name="City" id="City" class="txt1" placeholder="City"/>
                </TD>
                <TD>
                    <input tabindex=11 type="text" name="State" id="State" class="txt1" placeholder="State"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input tabindex=6 type="number" name="Mobile1" id="Mobile1" class="txt1" placeholder="Mobile1" maxlength="13"/>

                </TD>
                <TD>
                    <input tabindex=7 type="Number" name="Mobile2" id="Mobile2"
                           class="txt1"
                           placeholder="Mobile2" maxlength="13"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input tabindex=4 type="number" name="Landline1" id="Landline1"
                           class="txt1" placeholder="Phone1" maxlength="13"/>
                </TD>
                <TD>
                    <input tabindex=5 type="number" name="Landline2" id="Landline2"
                           class="txt1" placeholder="Phone2" maxlength="13"/>
                </TD>

            </TR>

            <TR>
                <TD>
                    <input tabindex=13 type="text" name="SecretaryName" id="SecretaryName"
                           class="txt1"
                           placeholder="Secretary/Incharge/Care Taker Name"/>
                </TD>
                <TD>
                    <input tabindex=14 type="text" name="SecretaryMobile" id="SecretaryMobile" class="txt1" placeholder="Secretary Mobile"/>

                </TD>

            </TR>

            <TR>
                <TD>
                    <input tabindex=12 type="text" name="MapLink" id="MapLink"
                           class="txt1" placeholder="Map Link"/>

                </TD>
                <TD>

                </TD>

            </TR>

        </table>

        <BR>
        <BR>
        <BR>

        <table style="width:70%">

            <tr>
                <th>Day</th>
                <th>Week1</th>
                <th>Week2</th>
                <th>Week3</th>
                <th>Week4</th>
                <th>Week5</th>
                <th>Time</th>
            </tr>

            <tr>
                <td><input type="checkbox" name="day" value="Sun">Sun</td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Sun", "txt2", "W5"));%></td>
                <td><input type="time" name="SunTime"></td>
            </tr>

            <tr>
                <td><input type="checkbox" name="day" value="Mon">Mon</td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt3", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt3", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt3", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt3", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Mon", "txt3", "W5"));%></td>
                <td><input type="time" name="MonTime"></td>
            </tr>

            <tr>
                <td><input type="checkbox" name="day" value="Tue">Tue</td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Tue", "txt2", "W5"));%></td>
                <td><input type="time" name="TueTime"></td>
            </tr>

            <tr>
                <td><input type="checkbox" name="day" value="Wed">Wed</td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt3", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt3", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt3", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt3", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Wed", "txt3", "W5"));%></td>
                <td><input type="time" name="WedTime"></td>
            </tr>

            <tr>
                <td><input type="checkbox" name="day" value="Thu">Thu</td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Thu", "txt2", "W5"));%></td>
                <td><input type="time" name="ThuTime"></td>
            </tr>

            <tr>
                <td><input type="checkbox" name="day" value="Fri">Fri</td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt3", "W1"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt3", "W2"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt3", "W3"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt3", "W4"));%></td>
                <td><% out.println(HtmlGenerator.getweeklyLanguage("Fri", "txt3", "W5"));%></td>
                <td><input type="time" name="FriTime"></td>
            </tr>

            <tr>
                <TD><input type="checkbox" name="day" value="Sat">Sat</TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W1"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W2"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W3"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W4"));%></TD>
                <TD><% out.println(HtmlGenerator.getweeklyLanguage("Sat", "txt2", "W5"));%></TD>
                <td><input type="time" name="SatTime"></td>
            </tr>

        </table>

        <BR>
        <input tabindex=-1 type="submit" value="submit"/>
        <input tabindex=-1 type="reset" name="reset" value="reset"/>
    </center>
</form>
</body>
</html>
