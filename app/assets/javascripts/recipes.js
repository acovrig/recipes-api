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

function addUtensil(rid, e) {
  e.preventDefault();
  $.ajax({
    url: '/recipes/' + rid + '/utensils.json',
    type: 'POST',
    data: {
      utf8: $(e.srcElement).find('[name="utf8"]').val(),
      authenticity_token: $(e.srcElement).find('[name="authenticity_token"]').val(),
      utensil: {
        name: $(e.srcElement).find('#name').val(),
        qty: $(e.srcElement).find('#qty').val()
      }
    },
    success: data => {
      $('ul#utensils').append('<li>' + data.qty + ' ' + data.name + '</li>');
      $('#utensilsModal').modal('hide');
      $(e.srcElement).find('#name').val('');
      $(e.srcElement).find('#qty').val('');
      $(e.srcElement).find('input[type="submit"]').removeAttr('disabled');
      return true;
    }, error: data => {
      console.error(data);
      return false;
    }
  });
  return false;
}