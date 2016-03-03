$(document).ready(function(){

  $('.demo-btn').focus(function() {         // Changing the clickon border color from PLAY DEMO Button.
    $(this).css('outline-color', '#ccc');
  });


    $('.demo-btn').mouseenter(function() {
      $(this).text('EMOTRAK');
  });

  $('.demo-btn').mouseleave(function() {
    $(this).text('VIEW APP');
});
  // $('.demo-btn').hover(function() {
  //   $(this).replaceWith('VIEW APP');
  // });


  // $('arrow-down, i').scroll(function() {
  //   $(this).fadeOut('fast');
  // });




});
