$(document).ready(function(){

  $('.demo-btn').focus(function() {         // Changing the clickon border color from PLAY DEMO Button.
    $(this).css('outline-color', '#ccc');
  });


    $('.demo-btn').mouseenter(function() {
      $(this).text('VIEW APP');
  });                                        //Hover over button and text change.

  $('.demo-btn').mouseleave(function() {
    $(this).text('TREMO');
});


  // $('arrow-down, i').scroll(function() {
  //   $(this).fadeOut('fast');
  // });




});
