$(document).ready(function () {
  'use strict';

  $('#new_workflow_step').on('change', function () {
    var new_step = $('#new_workflow_step option:selected');
    var id = new_step.attr('value');
    var name = new_step.text().split(' - ')[0];
    var description = new_step.text().split(' - ')[1];
    var seq = $('#workflow_steps > tr').length;
    $('#workflow_steps').append(
      $.parseHTML('<tr><input value="'+seq+'" name="workflow[steps_attributes]['+seq+'][sequence]" type="hidden">' +
        '<td class="move-handle"><span class="glyphicon glyphicon-sort handle ui-sortable-handle"></span></td>' +
        '<td>'+(seq+1)+'</td>' +
        '<td>'+name+'</td>' +
        '<td>'+description+'</td>' +
        '<td><input name="workflow[steps_attributes]['+seq+'][active]" value="0" type="hidden"><input value="1" checked="checked" name="workflow[steps_attributes]['+seq+'][active]" type="checkbox"></td>' +
        '<td>0</td><td>0</td><td>0</td>' +
        '<td class="actions"><input name="workflow[steps_attributes]['+seq+'][_destroy]" value="0" type="hidden"><input value="1" name="workflow[steps_attributes]['+seq+'][_destroy]" type="checkbox"></td>' +
        '<input value="'+id+'" name="workflow[steps_attributes]['+seq+'][step_code_id]" type="hidden"></tr>'));
  });
});
