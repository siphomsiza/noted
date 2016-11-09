setInterval(function(){
  //script to send reminder email
$.ajax({
  type: "POST",
  url: "/sdbip_time_periods/send_notification",
  success: function (data) {},
  error: function (data) {}
});
  //script to autoclose time period
  $.ajax({
  type: "POST",
  url: "/sdbip_time_periods/update_status",
  success: function (data) {},
  error: function (data) {}
  });
},100000);
