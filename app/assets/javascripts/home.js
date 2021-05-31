// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener('turbolinks:load', _ => {
});

window.inventorySearch = function() {
  match = $('input[name="match"]:checked').val();
  id = $('#ingredients').val();
  ingredients = $('#ingredients').val()
  utensils = $('#utensils').val()
  if(ingredients !== null)
    ingredients = ingredients.map(id => {
      return $('#ingredients').find('option[value="' + id + '"]').text();
    });

  if(utensils !== null)
    utensils = utensils.map(id => {
      return $('#utensils').find('option[value="' + id + '"]').text();
    });
  $.ajax({
    url: '/search.json?match=' + match + '&ingredients=' + ingredients + '&utensils=' + utensils,
    type: 'GET',
    success: data => {
      if(data.recipes.length > 0)
        $('h2#results').css('display', 'inherit');
      else
        $('h2#results').css('display', 'none');
      $('ul#results').empty();
      data.recipes.forEach(recipe => {
        $('ul#results').append('<li><a href="/recipes/' + recipe.id + '">' + recipe.name + '</li>');
      });
    }, error: data => {
      console.error(data);
    }
  });
}
