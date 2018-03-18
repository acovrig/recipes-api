// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function addStep() {
  div = $('#collapseDirections > ol > li:last');
  newDir = div.clone();
  num = parseInt( div.find('input[type="hidden"]').val()) + 1;
  newDir.find('input[type="hidden"]').val(num);
  newDir.find('input[type="hidden"]').prop('name', 'recipe[directions_attributes][' + num + '][step]').prop('id', 'recipe_directions_attributes_' + num + '_step');
  newDir.find('input[type="text"]').val('');
  newDir.find('input[type="text"]').prop('name', 'recipe[directions_attributes][' + num + '][action]').prop('id', 'recipe_directions_attributes_' + num + '_action');
  div.after(newDir);
}

function delStep(rid, elem) {
  num = $(elem).parent().children('input[type="hidden"]').val();
  id = $('#recipe_directions_attributes_' + (parseInt(num) - 1) + '_id').val();
  if(id == undefined) {
    $(elem).parent().parent().remove();
  } else {
    $.ajax({
      url: '/recipes/' + rid + '/directions/' + id + '.json',
      type: 'DELETE',
      success: data => {
        $('#recipe_directions_attributes_' + (parseInt(num) - 1) + '_id').remove();
        $(elem).parent().parent().remove();
      }
    });
  }
}