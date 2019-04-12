function getTodayDate() {
    var today = dateF(new Date());
    return today;
}


function getDateByYearsOffset(years) {
    var date = new Date();
    var year = date.getFullYear();
    year = year + (years);
    date.setFullYear(year);
    return dateF(date);
}


function getDateByYearsOffset1(years) {
    var date = new Date();
    var year = date.getFullYear();
    year = year + (years);
    date.setFullYear(year);
    return dateF(date);
}


function dateF(dateObject) {
    var dd = dateObject.getDate();
    var mm = dateObject.getMonth() + 1;
    var yyyy = dateObject.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }
    return yyyy + "-" + mm + "-" + dd;
}


function print_desc(name, value) {

    var descName = name + "Desc";

    if (print_desc.jsonData == "") {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("GET", "GetCD.jsp", false); // false for synchronous request
        xmlHttp.send(null);
        json = xmlHttp.responseText;
        print_desc.jsonData = JSON.parse(json);
    }


    var jsonData = print_desc.jsonData;

    for (var i = 0; i < jsonData.length; i++) {
        if (jsonData[i].id == value) {

            document.getElementById(descName).innerHTML = jsonData[i].desc1+" / "+jsonData[i].desc2;
            return;
        }

    }
    document.getElementById(descName).innerHTML = "";


}


print_desc.jsonData = ""


function print_desc2() {

    alert("in print desc");

}


function printWithSig() {
    var divID = "print";
    //Get the HTML of div
    var divElements = document.getElementById(divID).innerHTML;

    //Get the HTML of whole page
    var oldPage = document.body.innerHTML;

    var sig = " <BR><BR><BR><BR><B><p align=\"right\" class=\"onlyprint\">\n" + "Authorized Signatory</p></B>";

    //Reset the page's HTML with div's HTML only
    document.body.innerHTML =
        "<html><head><title></title></head><body>" + divElements + sig + "</body>";

    //Print Page
    window.print();

    //Restore orignal HTML
    document.body.innerHTML = oldPage;


}