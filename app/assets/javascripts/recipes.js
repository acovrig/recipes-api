// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener('turbolinks:load', _ => {
  $('#categoriesModal').on('shown.bs.modal', function () {
    $.ajax({
      url: '/categories.json?rid=' + $('#rid').val(),
      success: data => {
        $('select#cid').empty();
        data.all.forEach(cat => {
          $('select#cid').append('<option value=' + cat.id + '>' + cat.name + '</option>');
        });
        $('select#cid').val(data.match);
      }
    });
  });
  $('#ingredientsModal').on('shown.bs.modal', function () {
    $('#ingredient_qty').trigger('focus');
    $('#ingredient_qty').keyup(function() {
      this.value = this.value.replace(/[^\d\/ ]/, '');
    });
  });
  $('#utensilsModal').on('shown.bs.modal', function () {
    $('#utensil_name').trigger('focus');
  });
  $('#directionsModal').on('shown.bs.modal', function () {
    $('#direction_action').trigger('focus');
  });
});

function editRecipe(elem) {
  form = {recipe: {}};
  form['recipe'][elem.id] = elem.value;
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '.json',
    type: 'PUT',
    data: form,
    success: data => {
      console.log(data);
    }, error: data => {
      console.error(data);
    }
  });
}

function editCategories() {
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '/categories.json',
    type: 'PUT',
    data: {cid: $('#cid').val()},
    success: data => {
      $('ul#categories').empty();
      data.forEach(cat => {
        $('ul#categories').append('<li>' + cat.name + '</li>');
      });
      $('#categoriesModal').modal('hide');
    }, error: data => {
      console.error(data);
    }
  });
}

function addIngredient(e) {
  e.preventDefault();
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '/ingredients.json',
    type: 'POST',
    data: $(e.srcElement).serialize(),
    success: data => {
      note = '';
      if(data.note != '')
        note = ' (' + data.note + ')';
      $('ul#ingredients').append('<li id="ingredient' + data.id + '"><button type="button" class="btn btn-danger" onclick="delIngredient(' + data.id + ')"><i class="fa fa-trash"></i></button>' + data.qty + ' ' + data.unit + ' - ' + data.item + note + '</li>');
      $('#ingredientsModal').modal('hide');
      $(e.srcElement).trigger('reset');
      $(e.srcElement).find('input[type="submit"]').removeAttr('disabled');
      return true;
    }, error: data => {
      console.error(data);
      return false;
    }
  });
  return false;
}

function delIngredient(id) {
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '/ingredients/' + id + '.json',
    type: 'DELETE',
    success: data => {
      $('#ingredient' + id).remove();
    }
  });
}

function addUtensil(e) {
  e.preventDefault();
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '/utensils.json',
    type: 'POST',
    data: $(e.srcElement).serialize(),
    success: data => {
      $('ul#utensils').append('<li id="utensil' + data.id + '"><button type="button" class="btn btn-danger" onclick="delUtensil(' + data.id + ')"><i class="fa fa-trash"></i></button>' + data.qty + ' ' + data.name + '</li>');
      $('#utensilsModal').modal('hide');
      $(e.srcElement).trigger('reset');
      $(e.srcElement).find('input[type="submit"]').removeAttr('disabled');
      return true;
    }, error: data => {
      console.error(data);
      return false;
    }
  });
  return false;
}

function delUtensil(id) {
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '/utensils/' + id + '.json',
    type: 'DELETE',
    success: data => {
      $('#utensil' + id).remove();
    }
  });
}

function addDirection(e) {
  e.preventDefault();
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '/directions.json',
    type: 'POST',
    data: $(e.srcElement).serialize(),
    success: data => {
      $('ol#directions').append('<li id="direction' + data.id + '"><button type="button" class="btn btn-danger" onclick="delDirection(' + data.id + ')"><i class="fa fa-trash"></i></button>' + data.action + '</li>');
      $('#directionsModal').modal('hide');
      $(e.srcElement).trigger('reset');
      $(e.srcElement).find('input[type="submit"]').removeAttr('disabled');
      return true;
    }, error: data => {
      console.error(data);
      return false;
    }
  });
  return false;
}

function delDirection(id) {
  $.ajax({
    url: '/recipes/' + $('#rid').val() + '/directions/' + id + '.json',
    type: 'DELETE',
    success: data => {
      $('#direction' + id).remove();
    }
  });
}
