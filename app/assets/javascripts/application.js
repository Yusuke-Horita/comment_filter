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
		if ($("#url").val().length == 0) {
			$(".submit , .submit_type_2").prop("disabled", true);
		}
	$("#url").on("keydown keyup keypress change", function() {
		if ($(this).val().length < 1) {
			$(".submit , .submit_type_2").prop("disabled", true);
		} else {
			$(".submit , .submit_type_2").prop("disabled", false);
		}
	});
});

$(function() {
	$(document).on('click', ".submit", function(){
		console.log("クリック")
		$(this).removeClass('submit');
		$(this).addClass('submit_type_2');
		$('.cv-spinner').css('display', 'flex');
		$('.search-wrapper').fadeOut('slow');
		$('.toppage_text').remove()
		setTimeout(function(){
			$('.search-wrapper').removeClass('active');
			$('.search-wrapper').addClass('type_2');
			$('.search-wrapper').css({
				'position':'fixed',
				'transform':'translate(-120%, -50%)',
				'top':'8%',
				'left':'98%'
			});
			$('fieldset').addClass('active');
		},1000);
		setTimeout(function(){
			$('.search-wrapper').fadeIn('slow');
    },2000);
	});
});

$(function() {
	$(document).on('click', ".submit_type_2", function(){
		$('.filter .cv-spinner').css('display', 'flex');
		setTimeout(function(){
			$('.search-wrapper').removeClass('active');
			$('fieldset.active').fadeOut();
		},1000);
	});
});

$(function() {
	$(document).on('click', ".replies_renderer_active span", function(){
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

function searchToggle(obj, evt){
	var container = $(obj).closest('.search-wrapper , .search-wrapper-first');
			if(!container.hasClass('active')){
					container.addClass('active');
					evt.preventDefault();
					$('.submit').fadeIn();
					$('fieldset.active').fadeIn();
					$('.toppage_text').fadeOut();
					$('.filter').fadeIn();
					$('.filter').css('display','flex');
			}
			else if(container.hasClass('active') && $(obj).closest('.input-holder').length == 0){
					container.removeClass('active');
					$('.submit').fadeOut();
					$('fieldset.active').fadeOut();
					$('.toppage_text').fadeIn();
					$('.filter').fadeOut();
			}
}

var startPos = 0,winScrollTop = 0;
$(window).on('scroll',function(){
		winScrollTop = $(this).scrollTop();
		if (!$('.search-wrapper').hasClass('active')) {
			if (winScrollTop > startPos) {
				$('.search-wrapper').fadeOut();
    	} else {
        $('.search-wrapper').fadeIn();
    	}
		}
    startPos = winScrollTop;
});
