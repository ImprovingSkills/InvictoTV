$(document).ready(function() {
	$(window).scroll(function() {    
    var scroll = $(window).scrollTop();
    if (scroll > 140) {
      $(".fixed-header").addClass("fixed");
      $(".fixed-logo").removeClass("hidden");
    } else {
      $(".fixed-header").remove	Class("fixed");
      $(".fixed-logo").addClass("hidden");
    }
	});
});