$(document).ready(function() {
  var $headline = $('.headline'),
  $inner = $('.inner'),
  $nav = $('nav'),
  navHeight = 0;

  $(window).scroll(function() {
    var scrollTop = $(this).scrollTop(),
    headlineHeight = $headline.outerHeight() - navHeight,
    navOffset = $nav.offset().top;

    $headline.css({
      'opacity': (1 - scrollTop / headlineHeight)
    });
    $inner.children().css({
      'transform': 'translateY('+ scrollTop * 0.4 +'px)'
    });
    if (navOffset > headlineHeight) {
      $nav.addClass('scrolled');
    } else {
      $nav.removeClass('scrolled');
    }
  });

  $('#myCarousel').carousel({
    interval:   4000
  });

  var clickEvent = false;
  $('#myCarousel').on('click', '.nav a', function() {
    clickEvent = true;
    $('.nav li').removeClass('active');
    $(this).parent().addClass('active');
  }).on('slid.bs.carousel', function(e) {
    if(!clickEvent) {
      var count = $('.nav').children().length -1;
      var current = $('.nav li.active');
      current.removeClass('active').next().addClass('active');
      var id = parseInt(current.data('slide-to'));
      if(count == id) {
        $('.nav li').first().addClass('active');
      }
    }
    clickEvent = false;
  });

  $('#datepicker-1').datepicker({
    format: "dd/mm/yyyy",
    todayHighlight: true
  })

  $('#datepicker-2').datepicker({
    format: "dd/mm/yyyy",
    todayHighlight: true
  })
});
