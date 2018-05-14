// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(_ => {
  $('#addCategoryModal').on('shown.bs.modal', function () {
    $('#category_name').trigger('focus');
  });
  $('input[type="submit"]').on('click', function() {
    $('button.btn-primary[data-toggle="collapse"]').each((i, btn) => {
      if(!$($(btn).attr('data-target')).hasClass('show')) {
        $(btn).click();
      }
    });
  });
});

function addStep() {
  div = $('#collapseDirections > ol > li:last');
  newDir = div.clone();
  num = div.parent().children().length + 1;
  if(div.find('input[type="hidden"]').val() === '') { num = 2; div.find('input[type="hidden"]').val('1'); }
  newDir.find('input[type="hidden"]').val(num).prop('name', 'recipe[directions_attributes][' + (num - 1) + '][step]').prop('id', 'recipe_directions_attributes_' + (num - 1) + '_step');
  newDir.find('input[type="text"]').val('').prop('name', 'recipe[directions_attributes][' + (num - 1) + '][action]').prop('id', 'recipe_directions_attributes_' + (num - 1) + '_action');
  div.after(newDir);
  newDir.find('#recipe_directions_attributes_' + (num - 1) + '_action').focus();
}

function delStep(rid, elem) {
  if($(elem).parent().parent().parent().children().length < 2) {
    $(elem).parent().children('input[type="hidden"]').val('1').prop('name', 'recipe[directions_attributes][0][step]').prop('id', 'recipe_directions_attributes_0_step');
    $(elem).parent().children('input[type="text"]').val('').prop('name', 'recipe[directions_attributes][0][action]').prop('id', 'recipe_directions_attributes_0_action');
  } else {
    num = $(elem).parent().children('input[type="hidden"]').val();
    id = $('#recipe_directions_attributes_' + (parseInt(num) - 1) + '_id').val();
    if(rid == undefined || id == undefined) {
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
  card = $('#collapseIngredients div.card:last');
  new_card = card.clone();
  num = card.parent().children().length + 1;
  new_card.find('input[id$="_qty"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][qty]').prop('id', 'recipe_ingredients_attributes_' + num + '_qty');
  new_card.find('input[id$="_unit"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][unit]').prop('id', 'recipe_ingredients_attributes_' + num + '_unit');
  new_card.find('input[id$="_item"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][item]').prop('id', 'recipe_ingredients_attributes_' + num + '_item');
  new_card.find('input[id$="_note"]').val('').prop('name', 'recipe[ingredients_attributes][' + num + '][note]').prop('id', 'recipe_ingredients_attributes_' + num + '_note');
  card.after(new_card);
  new_card.find('#recipe_ingredients_attributes_' + num + '_qty').focus();
}

function delIngredient(rid, elem) {
  if($(elem).parent().parent().parent().children().length < 4) {
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
        url: '/recipes/' + rid + '/ingredients/' + id + '.json',
        type: 'DELETE',
        success: data => {
          $('#recipe_ingredients_attributes_' + (parseInt(num) - 1) + '_id').remove();
          $(elem).parent().parent().remove();
        }
      });
    }
  }
}

function addUtensil() {
  card = $('#collapseUtensils div.card:last');
  new_card = card.clone();
  num = card.parent().children().length + 1;
  new_card.find('input[id$="_qty"]').val('').prop('name', 'recipe[utensils_attributes][' + num + '][qty]').prop('id', 'recipe_utensils_attributes_' + num + '_qty');
  new_card.find('input[id$="_name"]').val('').prop('name', 'recipe[utensils_attributes][' + num + '][name]').prop('id', 'recipe_utensils_attributes_' + num + '_name');
  card.after(new_card);
  new_card.find('#recipe_utensils_attributes_' + num + '_qty').focus();
}

function delUtensil(rid, elem) {
  if($(elem).parent().parent().parent().children().length < 4) {
    $(elem).parent().parent().find('input[id$="_qty"]').val('').prop('name', 'recipe[utensils_attributes][0][qty]').prop('id', 'recipe_utensils_attributes_0_qty');
    $(elem).parent().parent().find('input[id$="_name"]').val('').prop('name', 'recipe[utensils_attributes][0][name]').prop('id', 'recipe_utensils_attributes_0_name');
  } else {
    num = $(elem).parent().children('input[type="hidden"]').val();
    id = $('#recipe_utensils_attributes_' + (parseInt(num) - 1) + '_id').val();
    if(id == undefined) {
      $(elem).parent().parent().remove();
    } else {
      $.ajax({
        url: '/recipes/' + rid + '/utensils/' + id + '.json',
        type: 'DELETE',
        success: data => {
          $('#recipe_utensils_attributes_' + (parseInt(num) - 1) + '_id').remove();
          $(elem).parent().parent().remove();
        }
      });
    }
  }
}

function addCategory() {
  category = $('#category_name').val();
  $.ajax({
    url: '/categories.json',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    type: 'POST',
    data: {category: {name: category}},
    success: data => {
      id = data.id;
      $('#category_name').val('');
      $('#recipe_categories')
        .append($('<option></option>')
        .attr('value', id)
        .attr('selected', true)
        .text(category));
      $('#addCategoryModal').modal('hide');
    }
  });
}