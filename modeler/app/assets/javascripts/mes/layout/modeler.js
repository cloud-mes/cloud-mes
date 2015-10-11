jQuery(function($) {

  // Add some tips
  $('.with-tip').tooltip();

  $('#sidebar-toggle').on('click', function(){
    var wrapper = $('#wrapper');
    var main    = $('#main-part');

    if(wrapper.hasClass('sidebar-minimized')){
      wrapper.removeClass('sidebar-minimized');
      main
        .removeClass('col-sm-12 col-md-12 sidebar-collapsed')
        .addClass('col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2');
      $.cookie('sidebar-minimized', 'false');
    }
    else {
      wrapper.addClass('sidebar-minimized');
      main
        .removeClass('col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2')
        .addClass('col-sm-12 col-md-12 sidebar-collapsed');
      $.cookie('sidebar-minimized', 'true');
    }
  });

  $('.sidebar-menu-item').mouseover(function(){
    if($('#wrapper').hasClass('sidebar-minimized')){
      $(this).addClass('menu-active');
      $(this).find('ul.nav').addClass('submenu-active');
    }
  });

  $('.sidebar-menu-item').mouseout(function(){
    if($('#wrapper').hasClass('sidebar-minimized')){
      $(this).removeClass('menu-active');
      $(this).find('ul.nav').removeClass('submenu-active');
    }
  });
});

