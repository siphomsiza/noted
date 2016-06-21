$(document).ready(function () {

window.setTimeout(function() {
    $(".alert").fadeTo(1500, 0).slideUp(500, function(){
        $(this).remove();
    });
}, 5000);

});
        $(document).ready(function(){
            $('input[type="checkbox"]').click(function(){

                if($('#kpi_owner_checkbox').prop("checked") == true){
                    $('#kpi_owner_select').show();
                }
                if($('#kpi_owner_checkbox').prop("checked") == false){
                  $("#kpi_owner_select").hide();
                }
                if($('#subdepartmental_administrator_checkbox').prop("checked") == true){
                    $('#subdepartment_select').show();
                }
                if($('#subdepartmental_administrator_checkbox').prop("checked") == false){
                  $("#subdepartment_select").hide();

                }
                if($('#departmental_administrator_checkbox').prop("checked") == true){
                    $("#department_select").show();
                }
                if($('#departmental_administrator_checkbox').prop("checked") == false && $('#kpi_owner_checkbox').prop("checked") == false){
                  $("#department_select").hide();
                }
            });
            toggleFields();
        });

        function toggleFields(){
          $("#kpi_owner_select").hide();
          $("#department_select").hide();
          $("#subdepartment_select").hide();
          $("#update_kpi_owner_select").hide();
          $("#update_department_select").hide();
          $("#update_subdepartment_select").hide();

}

$(document).ready(function() {
  var currentTime = new Date ( );

  var currentHours = currentTime.getHours ( );
  var currentMinutes = currentTime.getMinutes ( );
  var currentSeconds = currentTime.getSeconds ( );
  var currentYear = currentTime.getFullYear();
  var currentDate = currentTime.getDate();

  var d = new Date();
  var weekday = new Array(7);
  weekday[0]=  "Sunday";
  weekday[1] = "Monday";
  weekday[2] = "Tuesday";
  weekday[3] = "Wednesday";
  weekday[4] = "Thursday";
  weekday[5] = "Friday";
  weekday[6] = "Saturday";

  var n = weekday[d.getDay()];

  var date = new Date();
  var month = new Array();
  month[0] = "January";
  month[1] = "February";
  month[2] = "March";
  month[3] = "April";
  month[4] = "May";
  month[5] = "June";
  month[6] = "July";
  month[7] = "August";
  month[8] = "September";
  month[9] = "October";
  month[10] = "November";
  month[11] = "December";
  var currentMonth = month[date.getMonth()];
  // Pad the minutes and seconds with leading zeros, if required
  //currentMinutes = ( currentMinutes < 10 ? "0" : "" ) + currentMinutes;
  //currentSeconds = ( currentSeconds < 10 ? "0" : "" ) + currentSeconds;

  // Choose either "AM" or "PM" as appropriate
  //var timeOfDay = ( currentHours < 12 ) ? "AM" : "PM";

  // Convert the hours component to 12-hour format if needed
  //currentHours = ( currentHours > 12 ) ? currentHours - 12 : currentHours;

  // Convert an hours component of "0" to "12"
  //currentHours = ( currentHours == 0 ) ? 12 : currentHours;


  if(currentSeconds<=9) currentSeconds ="0"+currentSeconds;
  if(currentMinutes<=9) currentMinutes ="0"+ currentMinutes;
  if(currentHours<=9) currentHours ="0"+ currentHours;

  // Compose the string for display
  var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds;// + " " + timeOfDay;
  var currentDateString = n + " " + currentMonth + " " + currentDate + " " +currentYear;
// Update the time display
  document.getElementById("clock").firstChild.nodeValue = currentTimeString;
  // Update the date display
  document.getElementById("date").firstChild.nodeValue = currentDateString;
});

// -->
  $(function() {
    $( "#accordion" ).accordion();
  });


$(document).ready(function() {

	//Setup the plugin, see readme for more examples
	var weather_service = $("#weather").flatWeatherPlugin({
	  location: "Midrand, Johannesburg", //city and region *required
	  country: "South Africa",         //country *required
	  //optional:
	  api: "openweathermap", //default: openweathermap (openweathermap or yahoo)
	  //apikey: "your-api-key",   //optional api key for openweather
	  view : "simple", //default: full (partial, full, simple, today or forecast)
	  displayCityNameOnly : true, //default: false (true/false) if you want to display only city name
	  forecast: 1, //default: 5 (0 -5) how many days you want forecast
	  render: true, //default: true (true/false) if you want plugin to generate markup
	  loadingAnimation: true //default: true (true/false) if you want plugin to show loading animation
	  //units : "metric" or "imperial" default: "auto"
	});

  });
  $(function() {
      $( "#accordion" ).accordion({
        collapsible: true
      });
    });
  
