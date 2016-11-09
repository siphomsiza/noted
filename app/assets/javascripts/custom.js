$(document).ready(function(){
  window.setTimeout(function() {
    $(".alert").fadeTo(1500, 0).slideUp(500, function(){
        $(this).remove();
    });
  }, 5000);
});
// $(document).ready(function(){
//   $('input[type="checkbox"]').click(function(){
//         if($('#disablity_checkbox').prop("checked") === true){
//                   $('#disability_description_fields').show();
//                 }
//                 if($('#disablity_checkbox').prop("checked") === false){
//                   $('#disability_description_fields').hide();
//                 }
//                 if($('#kpi_owner_checkbox').prop("checked") === true){
//                     $('#kpi_owner_select').show();
//                 }
//                 if($('#kpi_owner_checkbox').prop("checked") === false){
//                   $("#kpi_owner_select").hide();
//                 }
//                 if($('#subdepartmental_administrator_checkbox').prop("checked") === true){
//                     $('#subdepartment_select').show();
//                 }
//                 if($('#subdepartmental_administrator_checkbox').prop("checked") === false){
//                   $("#subdepartment_select").hide();
//
//                 }
//                 if($('#departmental_administrator_checkbox').prop("checked") === true){
//                     $("#department_select").show();
//                 }
//                 if($('#departmental_administrator_checkbox').prop("checked") === false && $('#kpi_owner_checkbox').prop("checked") === false){
//                   $("#department_select").hide();
//                 }
//             });
//             toggleFields();
//
//         function toggleFields(){
//           $("#kpi_owner_select").hide();
//           $("#department_select").hide();
//           $("#subdepartment_select").hide();
//           $("#update_kpi_owner_select").hide();
//           $("#update_department_select").hide();
//           $("#update_subdepartment_select").hide();
//           $('#disability_description_fields').hide();
//         }
// });
$(document).ready(function(){
  $(function() {
      $( "#accordion" ).accordion({
        collapsible: true
      });
    });
    });
$(document).ready(function(){
  $(function(){
        $(document).on('change','#selected_department', function(){
           var select_value = $(this).val();
           $('#current_department').val(select_value);

        });
        $(document).on('change','#selected_subdepartment', function(){
           var select_value = $(this).val();
           $('#current_subdepartment').val(select_value);

        });
  });
  });
  $(document).ready(function(){
    $(function() {

    //activate schedule tabs
    // var hash = window.location.hash;
    // hash && $('ul.nav a[href="' + hash + '"]').tab('show');

    //highlight the current nav
    $("#introduction a:contains('INTRODUCTION')").parent().addClass('active');
    $("#dashboard a:contains('DASHBOARD')").parent().addClass('active');
    $("#setup a:contains('SETUP')").parent().addClass('active');
    $("#sdbip a:contains('SDBIP')").parent().addClass('active');
    $("#reports a:contains('REPORTS')").parent().addClass('active');
    $("#users a:contains('USERS')").parent().addClass('active');
    $("#contact a:contains('CONTACT')").parent().addClass('active');


    //make menus drop automatically
    $('ul.nav li.dropdown').hover(function() {
      $('.dropdown-menu', this).fadeIn();
    }, function() {
      $('.dropdown-menu', this).fadeOut('fast');
    });

    //show tooltips
    $("[data-toggle='tooltip']").tooltip({ animation: true});

  }); //jQuery is loaded
});

$(document).ready(function(){
	$("#datepicker1").on("dp.change", function (e) {
	  $('#datepicker2').data("DatePicker").minDate(e.date);
	});
	$("#datepicker2").on("dp.change", function (e) {
	  $('#datepicker1').data("DatePicker").maxDate(e.date);
	});
});
