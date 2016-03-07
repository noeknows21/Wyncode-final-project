$(document).ready(function(){

  $('.demo-btn').focus(function() {         // Changing the clickon border color from PLAY DEMO Button.
    $(this).css('outline-color', '#ccc');
  });


    $('.demo-btn').mouseenter(function() {
      $(this).text('VIEW APP');
  });                                        //Hover over button and text change.

  $('.demo-btn').mouseleave(function() {
    $(this).text('EMOTRAK');
});


  // $('arrow-down, i').scroll(function() {
  //   $(this).fadeOut('fast');
  // });

  $('#connectLink').focus(function() {        // Changing the clickon border color for buttons in ROOMS.
    $(this).css('outline-color', 'none');
  });

  $('#disconnectLink').focus(function() {
    $(this).css('outline-color', 'none');
  });

  $('#publishLink').focus(function() {
    $(this).css('outline-color', 'none');
  });

  $('#unpublishLink').focus(function() {
    $(this).css('outline-color', 'none');
  });





});
