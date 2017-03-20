$(document).ready(function() {
	$(window).scroll(function() {    
    var scroll = $(window).scrollTop();
    if (scroll > 140) {
      $(".fixed-header").addClass("fixed");
      $(".fixed-logo").removeClass("invisible");
    } else {
      $(".fixed-header").removeClass("fixed");
      $(".fixed-logo").addClass("invisible");
    }
	});
});