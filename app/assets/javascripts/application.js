// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require turbolinks
//= require_tree .


$(function(){
		if ($('#url').val().length == 0) {
			$('.submit , .submit_type_2').prop('disabled', true);
		}
	$('#url').on('keydown keyup keypress change', function() {
		if ($(this).val().length < 1) {
			$('.submit , .submit_type_2').prop('disabled', true);
		} else {
			$('.submit , .submit_type_2').prop('disabled', false);
		}
	});
});

$(function() {
	$(document).on('click', '.replies_renderer_active span', function(){
			$(this).parents('.replies_renderer').nextAll('section').hide();
			$(this).html('<i class="fas fa-chevron-down"></i> 返信を表示');
			$(this).addClass('close');
	});
	$(document).on('click', '.replies_renderer_active span.close', function(){
		$(this).parents('.replies_renderer').nextAll('section').show();
		$(this).html('<i class="fas fa-chevron-up"></i> 返信を非表示');
		$(this).removeClass('close');
	});
});

$(document).on('click', '.icon--search.type_1', function(){
	console.log("クリック1");
	$('.search').show();
	setTimeout(function(){
		$('.search').toggleClass('focus');
		$('#magnify').toggleClass('clicked');
	},1);
});

$(document).on('click', '.icon--search.type_2', function(){
	$('.search').show().focus();
	setTimeout(function(){
		console.log("クリック2");
		$('.search').toggleClass('focus');
		$('#magnify').toggleClass('clicked');
		if($('.radio-container').hasClass('active')){
			$('.radio-container').removeClass('active');
			$('.radio-container').fadeOut('slow');
			$('.filter').fadeOut();
		}else{
			$('.radio-container').addClass('active');
			$('.radio-container').fadeIn('slow');
			$('.filter').fadeIn();
		}
	},1);
});

$(document).on('click', '.radio-container label', function(){
	$('.search').focus();
});

$(document).on('click', '.submit.type_1', function(){
	console.log('クリック３')
	$('.cv-spinner-large').css('display','flex');
	$('.form_container').fadeOut('slow');
	$(this).removeClass('type_1');
	$(this).addClass('type_2');
	setTimeout(function(){
		$('.form_container').css('top','8%');
		$('.icon--search').removeClass('type_1');
		$('.icon--search').addClass('type_2');
		$('.search').toggleClass('focus');
		$('#magnify').toggleClass('clicked');
	},800);
	setTimeout(function(){
		$('.form_container').fadeIn('slow');
	},1000);
});

$(document).on('click', '.submit.type_2', function(){
	console.log('クリック4')
	$('.cv-spinner-large').css('display','flex');
	setTimeout(function(){
		$('.search').toggleClass('focus');
		$('#magnify').toggleClass('clicked');
		$('.radio-container').fadeOut('slow');
		$('.radio-container').removeClass('active');
	},800);
});

