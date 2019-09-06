$(document).ready(function() {

  var $headline = $('.headline'),
  $inner = $('.inner'),
  $nav = $('nav'),
  navHeight = 75;

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

  $(".preview-signup").change(function() {
    readURL(this, '#img-prev-signup');
  });

  $(".preview-edit-profile").change(function() {
    readURL(this, '.img-circle');
  });

  $(".hide-form-password").css('display', 'none');
  $(".show-form").on('click', function(){
    $(".hide-form-password").toggle();
    $(this).text( $(this).text() == 'More' ? "Hide" : "More");
  });

  $('#search-rooms').autocomplete({
    source:  "/autocomplete.json",
    select: function(){
      $(this).closest('form').trigger('submit');
    }
  });

  if ($('#exampleSlider').length == 1) {
    $(this).multislider({
      interval: 5000,
      slideAll: false
    });
  }

});

function readURL(f, previewId) {
  if (f.files && f.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(previewId).attr('src', e.target.result);
    };
    reader.readAsDataURL(f.files[0]);
  }
}
