



function print_city(cityId, state) {

    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", "GetCities.jsp?StateCode=" + state.toUpperCase(), false); // false for synchronous request
    xmlHttp.send(null);
    json = xmlHttp.responseText;


    // var json = "[{\"code\":\"BLR\",\"name\":\"Bangalore\",\"stateCode\":\"KA\"},{\"code\":\"MYS\",\"name\":\"MYSURU\",\"stateCode\":\"KA\"},{\"code\":\"TUM\",\"name\":\"TUMKUR\",\"stateCode\":\"KA\"}]";
    var jsonData = JSON.parse(json);


    var option_str = document.getElementById(cityId);
    option_str.length=0;
    option_str.options[0] = new Option('Select City','');
    option_str.selectedIndex = 0;
    for (var i=0; i<jsonData.length; i++) {

        option_str.options[option_str.length] = new Option(jsonData[i].name,jsonData[i].code);
    }
}

function print_state(country_id){
    var option_str = document.getElementById(country_id);
    option_str.length=0;
    option_str.options[0] = new Option('Select State','');
    option_str.selectedIndex = 0;
    for (var i=0; i<stateArr.length; i++) {
        option_str.options[option_str.length] = new Option(stateArr[i],stateArr[i]);
    }
}

// function print_city(cityId, index){
//     var option_str = document.getElementById(cityId);
//     option_str.length=0;
//     option_str.options[0] = new Option('Select City','');
//     option_str.selectedIndex = 0;
//     var cityArray = cityArr[index].split("|");
//     for (var i=0; i<cityArray.length; i++) {
//         var city=cityArray[i];
//         var tokens=city.split(",");
//
//         option_str.options[option_str.length] = new Option(tokens[0],tokens[1]);
//     }
// }