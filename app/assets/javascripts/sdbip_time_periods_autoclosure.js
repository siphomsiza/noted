setInterval(function(){
  //script to send reminder email
$.ajax({
  type: "GET",
  url: "/send_notification",
  success: function (data) {},
  error: function (data) {}
});
  //script to autoclose time period
  $.ajax({
  type: "GET",
  url: "/update_status",
  success: function (data) {},
  error: function (data) {}
  });
},100000);
