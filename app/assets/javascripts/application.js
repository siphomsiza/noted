// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

$(function() {

	//activate schedule tabs
	var hash = window.location.hash;
	hash && $('ul.nav a[href="' + hash + '"]').tab('show');

	//controlling opening of accordions
	//$('#monday.accordion-body').addClass('in');

	//$('#artists #tuesday.accordion-body').addClass('in');
	//$('#artists #wednesday.accordion-body').addClass('in');
	//$('#artists #thursday.accordion-body').addClass('in');
	//$('#artists #friday.accordion-body').addClass('in');

	//add bootstrap classes to photos
	//$('.abouttheartists img').addClass('img-circle');
	//$('aside.photosfromlastyear img').addClass('img-thumbnail');
	//$('.artistinfo .photogrid img').addClass('img-circle');


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
	});//hover

	//show tooltips
	$("[data-toggle='tooltip']").tooltip({ animation: true});

	//show modals

	//$('.modalphotos img').on('click', function() {
	//	$('#modal').modal({
	//		show: true,
	//	})

	//	var mysrc = this.src.substr(0, this.src.length-7) + '.jpg';
	//	$('#modalimage').attr('src', mysrc);
	//	$('#modalimage').on('click', function(){
	//			$('#modal').modal('hide');
	//	})//hide modal
	//});//show modal


}); //jQuery is loaded
