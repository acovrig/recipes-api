// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function addStep() {
  div = $('#collapseDirections > ol > li:last');
  newDir = div.clone();
  num = div.parent().children().length + 1;
  if(div.find('input[type="hidden"]').val() === '') { num = 2; div.find('input[type="hidden"]').val('1'); }
  newDir.find('input[type="hidden"]').val(num).prop('name', 'recipe[directions_attributes][' + (num - 1) + '][step]').prop('id', 'recipe_directions_attributes_' + (num - 1) + '_step');
  newDir.find('input[type="text"]').val('').prop('name', 'recipe[directions_attributes][' + (num - 1) + '][action]').prop('id', 'recipe_directions_attributes_' + (num - 1) + '_action');
  div.after(newDir);
}

function delStep(rid, elem) {
  if($(elem).parent().parent().parent().children().length < 2) {
    $(elem).parent().children('input[type="hidden"]').val('1').prop('name', 'recipe[directions_attributes][0][step]').prop('id', 'recipe_directions_attributes_0_step');
    $(elem).parent().children('input[type="text"]').val('').prop('name', 'recipe[directions_attributes][0][action]').prop('id', 'recipe_directions_attributes_0_action');
  } else {
    num = $(elem).parent().children('input[type="hidden"]').val();
    id = $('#recipe_directions_attributes_' + (parseInt(num) - 1) + '_id').val();
    if(rid == undefined) {
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
}

function addIngredient() {
  tr = $('#collapseIngredients tr:last');
  new_tr = tr.clone();
  num = tr.parent().children().length + 1;
  new_tr.find('input[id$="_qty"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][qty]').prop('id', 'recipe_ingredients_attributes_' + num + '_qty');
  new_tr.find('input[id$="_unit"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][unit]').prop('id', 'recipe_ingredients_attributes_' + num + '_unit');
  new_tr.find('input[id$="_item"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][item]').prop('id', 'recipe_ingredients_attributes_' + num + '_item');
  new_tr.find('input[id$="_note"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][note]').prop('id', 'recipe_ingredients_attributes_' + num + '_note');
  tr.after(new_tr);
}

function delIngredient(rid, elem) {
  if($(elem).parent().parent().parent().children().length < 3) {
    $(elem).parent().parent().find('input[id$="_qty"]').val('').prop('name', 'recipe[ingredients_attributes][0][qty]').prop('id', 'recipe_ingredients_attributes_0_qty');
    $(elem).parent().parent().find('input[id$="_unit"]').val('').prop('name', 'recipe[ingredients_attributes][0][unit]').prop('id', 'recipe_ingredients_attributes_0_unit');
    $(elem).parent().parent().find('input[id$="_item"]').val('').prop('name', 'recipe[ingredients_attributes][0][item]').prop('id', 'recipe_ingredients_attributes_0_item');
    $(elem).parent().parent().find('input[id$="_note"]').val('').prop('name', 'recipe[ingredients_attributes][0][note]').prop('id', 'recipe_ingredients_attributes_0_note');
  } else {
    num = $(elem).parent().children('input[type="hidden"]').val();
    id = $('#recipe_ingredients_attributes_' + (parseInt(num) - 1) + '_id').val();
    if(id == undefined) {
      $(elem).parent().parent().remove();
    } else {
      $.ajax({
        url: '/recipes/' + rid + '/directions/' + id + '.json',
        type: 'DELETE',
        success: data => {
          $('#recipe_ingredients_attributes_' + (parseInt(num) - 1) + '_id').remove();
          $(elem).parent().parent().remove();
        }
      });
    }
  }
}