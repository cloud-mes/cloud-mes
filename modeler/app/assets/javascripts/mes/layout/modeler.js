var show_flash = function(type, message) {
  'use strict';
  var flash_div = $('.flash.' + type);
  if (flash_div.length === 0) {
    flash_div = $('<div class="alert alert-' + type + '" />');
    $('#content').prepend(flash_div);
  }
  flash_div.html(message).show().delay(10000).slideUp();
};

$(document).ready(function(){
  'use strict';
  // Add some tips
  $('.with-tip').tooltip();

  $('#main-sidebar').find('[data-toggle="collapse"]').on('click', function() {
    if($(this).find('.glyphicon-chevron-left').length === 1) {
      $(this).find('.glyphicon-chevron-left').removeClass('glyphicon-chevron-left').addClass('glyphicon-chevron-down');
    }
    else {
      $(this).find('.glyphicon-chevron-down').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-left');
    }
  });

  $('#sidebar-toggle').on('click', function(){
    var wrapper = $('#wrapper');
    var main    = $('#main-part');

    if(wrapper.hasClass('sidebar-minimized')){
      wrapper.removeClass('sidebar-minimized');
      main
        .removeClass('col-sm-12 col-md-12 sidebar-collapsed')
        .addClass('col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2');
      Cookies.set('sidebar-minimized', 'false', { expires: 7 });
    }
    else {
      wrapper.addClass('sidebar-minimized');
      main
        .removeClass('col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2')
        .addClass('col-sm-12 col-md-12 sidebar-collapsed');
      Cookies.set('sidebar-minimized', 'true', { expires: 7 });
    }
  });

  $('.sidebar-menu-item').hoverIntent(function(){
    if($('#wrapper').hasClass('sidebar-minimized')){
      $(this).toggleClass('menu-active');
      $(this).find('ul.nav').toggleClass('submenu-active');
    }
  });

  // Main menu active item submenu show
  var active_item = $('#main-sidebar').find('.active');
  active_item.parent().addClass('in');
  active_item.parent().prev()
    .find('.glyphicon-chevron-left')
    .removeClass('glyphicon-chevron-left')
    .addClass('glyphicon-chevron-down');

  // Make flash messages disappear
  setTimeout('$(".alert-auto-disappear").slideUp()', 7000);

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

  $('tbody.sortable').sortable({
    handle: '.handle',
    update: function(e, ui) {
      $.each($('tbody.sortable tr'), function(position, obj){
        obj.children[0].value = position + 1;
        obj.children[2].textContent = position + 1;
      });
    }
  });

  $('a.dismiss').click(function() {
    $(this).parent().fadeOut();
  });
});
