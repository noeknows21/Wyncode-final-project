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


/*************** styling nav bar when scrolling *************/

  $('#product-background').mouseenter(function() {
    $('.product').css('color', '#3face2');
  });

  $('#product-background').mouseleave(function() {
        $('.product').css('color', '#fff');
  });

  $('#about-background').mouseenter(function() {
    $('.about').css('color', '#3face2');
  });

  $('#about-background').mouseleave(function() {
        $('.about').css('color', '#fff');
  });

  $('#tecnology-background').mouseenter(function() {
    $('.technology').css('color', '#3face2');
  });

  $('#tecnology-background').mouseleave(function() {
        $('.technology').css('color', '#fff');
  });


  // /*************** click on EMOTRAK on navbar to scroll up *************/
  //
  // $('.title1').click(function(){
  //   ('#video-display').scrolltop();
  // });
  //

 //  $(".title1").on("click", function() {
 //
 //     e.preventDefault();
 //
 //     $('#product-background').animate({
 //         scrollTop: $( $(this).attr('href') ).offset().top
 //     }, 600);
 //
 // });

});
