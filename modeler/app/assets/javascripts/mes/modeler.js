//= require jquery
//= require js.cookie
//= require jquery.hoverIntent
//= require select2
//= require jquery_ujs
//= require jquery-ui/sortable
//= require bootstrap-sprockets
//= require mes/layout/modeler
//= require mes/modeler/workflows

$(document).ready(function() {
  $("select.select2").select2({
    theme: "bootstrap",
    width: 'resolve'
  });
});
