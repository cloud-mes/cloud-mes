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

  // Make flash messages disappear
  setTimeout('$(".alert-auto-disappear").slideUp()', 7000);
});

var show_flash = function(type, message) {
  var flash_div = $('.flash.' + type);
  if (flash_div.length === 0) {
    flash_div = $('<div class="alert alert-' + type + '" />');
    $('#content').prepend(flash_div);
  }
  flash_div.html(message).show().delay(15000).slideUp();
};

$(document).ready(function(){
  $('body').on('click', '.delete-resource', function() {
    var el = $(this);
    if (confirm(el.data("confirm"))) {
      $.ajax({
        type: 'POST',
        url: $(this).prop("href"),
        data: {
          _method: 'delete',
          authenticity_token: AUTH_TOKEN
        },
        dataType: 'script',
        success: function(response) {
          el.parents("tr").fadeOut('hide', function() {
            $(this).remove();
          });
        },
        error: function(response, textStatus, errorThrown) {
          show_flash('error', response.responseText);
        }
      });
    }
    return false;
  });

  $('a.dismiss').click(function() {
    $(this).parent().fadeOut();
  });
});
