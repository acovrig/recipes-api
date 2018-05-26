// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function addIngredientSearch() {
  id = $('#ingredients').val();
  name = $('#ingredients').find('option[value="' + id + '"]').text();
  $('ul#ingredients').append('<li id="ingredient' + id + '"><button class="btn btn-danger" onclick="delIngredientSearch(' + id + ')"><i class="fa fa-trash"></i></button>' + name + '</li>');
  $('#ingredients').find('option[value="' + id + '"]').remove();
  inventorySearch();
}

function addUtensilSearch() {
  id = $('#utensils').val();
  name = $('#utensils').find('option[value="' + id + '"]').text();
  $('ul#utensils').append('<li id="utensil' + id + '"><button class="btn btn-danger" onclick="delUtensilSearch(' + id + ')"><i class="fa fa-trash"></i></button>' + name + '</li>');
  $('#utensils').find('option[value="' + id + '"]').remove();
  inventorySearch();
}

function delIngredientSearch(id) {
  name = $('ul#ingredients').find('li#ingredient' + id).text();
  $('#ingredients').append('<option value="' + id + '">' + name + '</option>');
  $('ul#ingredients').find('li#ingredient' + id).remove();

  // From https://stackoverflow.com/a/12073377/1188612
  var options = $('select#ingredients option');
  var arr = options.map(function(_, o) { return { t: $(o).text(), v: o.value }; }).get();
  arr.sort(function(o1, o2) { return o1.t > o2.t ? 1 : o1.t < o2.t ? -1 : 0; });
  options.each(function(i, o) {
    o.value = arr[i].v;
    $(o).text(arr[i].t);
  });
  inventorySearch();
}

function delUtensilSearch(id) {
  name = $('ul#utensils').find('li#utensil' + id).text();
  $('#utensils').append('<option value="' + id + '">' + name + '</option>');
  $('ul#utensils').find('li#utensil' + id).remove();

  // From https://stackoverflow.com/a/12073377/1188612
  var options = $('select#utensils option');
  var arr = options.map(function(_, o) { return { t: $(o).text(), v: o.value }; }).get();
  arr.sort(function(o1, o2) {
    var t1 = o1.t.toLowerCase(), t2 = o2.t.toLowerCase();
    return t1 > t2 ? 1 : t1 < t2 ? -1 : 0;
  });
  options.each(function(i, o) {
    o.value = arr[i].v;
    $(o).text(arr[i].t);
  });
  inventorySearch();
}

function inventorySearch() {
  ingredients = [], utensils = [];
  $('#ingredients li').each((i, elem) => {
    ingredients.push($(elem).text());
  });
  $('#utensils li').each((i, elem) => {
    utensils.push($(elem).text());
  });
  $.ajax({
    url: '/search.json?ingredients=' + ingredients + '&utensils=' + utensils,
    type: 'GET',
    success: data => {
      console.log(data);
      $('ul#results').empty();
      data.recipes.forEach(recipe => {
        $('ul#results').append('<li><a href="/recipes/' + recipe.id + '">' + recipe.name + '</li>');
      });
    }, error: data => {
      console.error(data);
    }
  });
}