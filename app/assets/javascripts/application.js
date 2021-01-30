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

$(function() {
	$(document).on('click', ".replies_renderer_active span", function(){
			$(this).parents('.replies_renderer').nextAll('section').hide();
			$(this).html('<i class="fas fa-chevron-down"></i> 返信を表示');
			$(this).addClass('close');
	});
	$(document).on('click', '.replies_renderer_active span' + '.close', function(){
		$(this).parents('.replies_renderer').nextAll('section').show();
		$(this).html('<i class="fas fa-chevron-up"></i> 返信を非表示');
		$(this).removeClass('close');
	});
});

$(function() {
	var textHeight = $('.yyy').height();
	var lineHeight = parseFloat($('.yyy').css('line-height'));
	var lineNum = 2;
	var textNewHeight = lineHeight * lineNum;

	if (textHeight > textNewHeight) {
		$('.yyy').css({
				'height': textNewHeight,
				'overflow':'hidden'
		 });
		$('.comment_body_renderer span').show();
		$(document).on('click', '.comment_body_renderer span', function(){
			$(this).addClass('active');
			$(this).text('一部を表示')
			$('.yyy').css({
				'height': textHeight,
				'overflow':'visible'
			 });
		});
		$(document).on('click', '.comment_body_renderer .active', function(){
			$(this).removeClass('active');
			$(this).text('続きを見る');
			$('.yyy').css({
				'height': textNewHeight,
				'overflow':'hidden'
			 });
		});
	};
});