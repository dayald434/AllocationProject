<!DOCTYPE html>
<html lang="en-US">
  <head>
    <script>$(document).ready(function() {
        $(".link1").click(function(event){
            event.preventDefault();
            var url =$(this).attr("href");
            $('#right-pane').load(url);
        });
    });</script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RSSB</title>
    <link rel="stylesheet" href="css/components.css">
    <link rel="stylesheet" href="css/icons.css">
    <link rel="stylesheet" href="css/responsee.css">
    <link rel="stylesheet" href="owl-carousel/owl.carousel.css">
    <link rel="stylesheet" href="owl-carousel/owl.theme.css">
    <link rel="stylesheet" href="css/template-style.css">
    <link href='https://fonts.googleapis.com/css?family=Playfair+Display&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
  </head>

    <!-- HEADER -->
    <header role="banner" class="position-absolute">
      <!-- Top Navigation -->
      <nav class="background-transparent background-transparent-hightlight full-width sticky">
        <div class="s-12 l-2">
          <a href="index.jsp" class="logo">
            <!-- Logo White Version -->
            <img class="logo-white" src="img/logo.png" alt="">
            <!-- Logo Dark Version -->
            <img class="logo-dark" src="img/logo.png" alt="">
          </a>
        </div>
        <div class="top-nav s-12 l-10">
          <p class="nav-text"></p>
          <ul class="right chevron">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="OrgRegister.jsp">Registration</a></li>
            <li><a>Services</a>
              <ul>
                <li><a>Service 1</a>
                  <ul>
                    <li><a>Service 1 A</a></li>
                    <li><a>Service 1 B</a></li>
                  </ul>
                </li>
                <li><a>Service 2</a></li>
              </ul>
            </li>
            <li><a href="about.html">About</a></li>
            <li><a href="gallery.html">Gallery</a></li>
            <li><a href="contact.html">Contact</a></li>
          </ul>
        </div>
      </nav>
    </header>

    <!-- MAIN -->
    <main role="main">
      <!-- Content -->
      <article>
        <header class="section background-dark">
          <div class="line">
            <h2> <%@ page import="com.rssb.api.satsangGhar.ApiHelper" %>
              <%@ page import="com.rssb.common.entity.SatsangGhar" %>
              <%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: devi
  Date: 30/7/17
  Time: 5:29 AM
  To change this template use File | Settings | File Templates.
--%>
              <%@ page contentType="text/html;charset=UTF-8" language="java" %>
              <html>
              <head>
                <title>Title</title>
                <link href="StyleRegister3.css" rel="stylesheet" type="text/css">
                <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
                <script type="text/javascript">
                    var tabIndex1 = 20;
                    var tabIndex2 = 21;

                    $(document).ready(function () {

                        var maxField = 7; //Input fields increment limitation
                        var addButton = $('.add_button'); //Add button selector
                        var wrapper = $('.field_wrapper'); //Input field wrapper
                        var fieldHTML = '<div><select tabindex=' + tabIndex1 + ' name="day">\n' +
                            '                        <option value="">Select Day</option>\n' +
                            '                        <option value="Sun">Sunday</option>\n' +
                            '                        <option value="Mon">Monday</option>\n' +
                            '                        <option value="Tue">Tuesday</option>\n' +
                            '                        <option value="Wed">Wednesday</option>\n' +
                            '                        <option value="Thu">Thursday</option>\n' +
                            '                        <option value="Fri">Friday</option>\n' +
                            '                        <option value="Sat">Saturday</option>\n' +
                            '\n' +
                            '\n' +
                            '                        </select>' +
                            ' <input tabindex=' + tabIndex2 + ' type="time" name="Time">' +
                            '<a  tabindex=-1  href="javascript:void(0);" class="remove_button" title="Remove field"> <img align="center"  height="25" width="25" src=images/delete.png></a>';

                        tabIndex1++;
                        tabIndex2++;
                        var x = 1; //Initial field counter is 1
                        $(addButton).click(function () { //Once add button is clicked
                            if (x < maxField) { //Check maximum number of input fields
                                x++; //Increment field counter
                                $(wrapper).append(fieldHTML); // Add field html
                            }
                        });
                        $(wrapper).on('click', '.remove_button', function (e) { //Once remove button is clicked
                            e.preventDefault();
                            $(this).parent('div').remove(); //Remove field html
                            x--; //Decrement field counter
                        });
                    });
                </script>

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
                            document.getElementById('ParentCentre').value = '';
                        }
                    }

                    function disablefield1() {
                        document.getElementById('ParentCentre').disabled = 'disabled';
                    }

                    window.onload = disablefield1
                </script>

                <style>
                  .field_wrapper {
                    margin-left: 60%;
                  }
                </style>
              </head>
              <body bgcolor="#fbf9cd">

              <form class="form-style-9" action="Register.jsp" method="get" name="RSSBRegistration" onsubmit="return(validate());">
                <header>
                  <h1>Satsang Ghar Registration</h1>
                </header>
                <ul>
                  <li>
                    <input type="text" name="Name" id="Name" class="field-style field-full align-none" placeholder="Name*"
                           tabindex=1/>

                  </li>
                  <li>

                    Type*: <input tabindex=2 type="radio" class="radioBtn" id="no_radio" name="Type" value="Centre" size="10"
                                  onChange="disablefield();" checked="checked">Centre
                    <input type="radio" class="radioBtn" id="yes_radio" name="Type" value="Sub-Centre" size="10"
                           onChange="disablefield();">Sub-Centre
                    <input type="radio" class="radioBtn" id="yes_radio1" name="Type" value="Point" size="10"
                           onChange="disablefield();">Point


                    <input tabindex=3 type="text" name="ParentCentre" id="ParentCentre"
                           class="field-style field-split align-right"
                           placeholder="Parent Centre*"/>

                    <%
                      ApiHelper apiHelper = new ApiHelper();
                      List<SatsangGhar> result = apiHelper.searchSatsangGharByPredicate("ctype  ='Centre'");


                    %>



                  </li>
                  <li>
                    <input tabindex=4 type="number" name="Landline1" id="Landline1" class="field-style field-split align-left"
                           placeholder="Phone1" maxlength="13"/>
                    <input tabindex=5 type="number" name="Landline2" id="Landline2" class="field-style field-split align-right"
                           placeholder="Phone2" maxlength="13"/>
                  </li>
                  <li>
                    <input tabindex=6 type="number" name="Mobile1" id="Mobile1" class="field-style field-split align-left"
                           placeholder="Mobile1" maxlength="13"/>
                    <input tabindex=7 type="Number" name="Mobile2" id="Mobile2" class="field-style field-split align-right"
                           placeholder="Mobile2" maxlength="13"/>
                  </li>
                  <li>
                    <input tabindex=8 type="text" name="Address1" id="Address1" class="field-style field-split align-left"
                           placeholder="Address1"/>
                    <input tabindex=9 type="text" name="Address2" id="Address2" class="field-style field-split align-right"
                           placeholder="Address2"/>

                  </li>
                  <li>
                    <input tabindex=10 type="text" name="City" id="City" class="field-style field-split align-left"
                           placeholder="City"/>
                    <input tabindex=11 type="text" name="State" id="State" class="field-style field-split align-right"
                           placeholder="State"/>

                  </li>
                  <li>
                    <input tabindex=12 type="text" name="MapLink" id="MapLink" class="field-style field-split align-left"
                           placeholder="Map Link"/>
                    <input tabindex=13 type="text" name="SecretaryName" id="SecretaryName"
                           class="field-style field-split align-right"
                           placeholder="Secretary/Incharge/Care Taker Name"/>


                  </li>
                  <li>
                    <input tabindex=14 type="text" name="SecretaryMobile" id="SecretaryMobile"
                           class="field-style field-split align-left"
                           placeholder="Secretary Mobile"/>

                  <li>
                    <input tabindex=-1 type="submit" value="submit"/> <input tabindex=-1 type="reset" name="reset"
                                                                             value="reset"/>
                  </li>

                  <div class="field_wrapper">
                    <div>
                      <select tabindex=15 name="day">
                        <option value="">Select Day</option>
                        <option value="Sun">Sunday</option>
                        <option value="Mon">Monday</option>
                        <option value="Tue">Tuesday</option>
                        <option value="Wed">Wednesday</option>
                        <option value="Thu">Thursday</option>
                        <option value="Fri">Friday</option>
                        <option value="Sat">Saturday</option>
                      </select>

                      <input tabindex=16 type="time" name="Time">
                      <a tabindex=17 href="javascript:void(0);" class="add_button" title="Add field"><img align="center"
                                                                                                          height="20"
                                                                                                          width="20"
                                                                                                          src=images/add.png></a>
                    </div>
                  </div>
                  </li>


                </ul>

              </form>
              </body>
              </html>
            </h2>
          </div>
        </header>
      </article>
    </main>

    <!-- FOOTER -->
    <footer>
      <!-- Contact Us -->
      <div class="background-primary padding text-center">
        <p class="h1">Contact Us: 0800 787 787</p>
      </div>

      <!-- Main Footer -->
      <section class="background-dark full-width">
        <!-- Map -->
        <div class="s-12 m-12 l-6 margin-m-bottom-2x">
          <div class="s-12 grayscale center">
            <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d1459734.5702753505!2d16.91089086619977!3d48.577103681657675!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1ssk!2ssk!4v1457640551761" width="100%" height="450" frameborder="0" style="border:0"></iframe>
          </div>
        </div>

        <!-- Collumn 2 -->
        <div class="s-12 m-12 l-6 margin-m-bottom-2x">
          <div class="padding-2x">
            <div class="line">
              <div class="float-left">
                  <i class="icon-sli-location-pin text-primary icon3x"></i>
                </div>
                <div class="margin-left-70 margin-bottom-30">
                  <h3 class="margin-bottom-0">Radha Soami Satsang Beas</h3>
                  <p>Indria Nagar<br>
                     Bangalore / Karnataka / India
                  </p>
                </div>
                <div class="float-left">
                  <i class="icon-sli-envelope text-primary icon3x"></i>
                </div>
                <div class="margin-left-70 margin-bottom-30">
                  <h3 class="margin-bottom-0">E-mail</h3>
                  <p>contact@sampledomain.com<br>
                     office@sampledomain.com
                  </p>
                </div>
                <div class="float-left">
                  <i class="icon-sli-phone text-primary icon3x"></i>
                </div>
                <div class="margin-left-70">
                  <h3 class="margin-bottom-0">Phone Numbers</h3>
                  <p>0800 4521 800 50<br>
                     0450 5896 625 16<br>
                     0798 6546 465 15
                  </p>
                </div>
            </div>
          </div>
        </div>
      </section>
      <hr class="break margin-top-bottom-0" style="border-color: rgba(0, 38, 51, 0.80);">

      <!-- Bottom Footer -->
      <section class="padding background-dark full-width">
        <div class="s-12 l-6">
          <p class="text-size-12">Radha Soami Satsang Beas © Bangalore</p>
        </div>
      </section>
    </footer>
    <script type="text/javascript" src="js/responsee.js"></script>
    <script type="text/javascript" src="owl-carousel/owl.carousel.js"></script>
    <script type="text/javascript" src="js/template-scripts.js"></script>
  </body>
</html>