// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener('turbolinks:load', _ => {
  $('.custom-select').multiselect({
    enableFiltering: true,
    templates: {
        li: '<li><a href="javascript:void(0);"><label class="pl-2"></label></a></li>',
        filter: '<li class="multiselect-item filter"><div class="input-group m-0 mb-1"><input class="form-control multiselect-search" type="text"></div></li>',
        filterClearBtn: '<div class="input-group-append"><button class="btn btn btn-outline-secondary multiselect-clear-filter" type="button"><i class="fa fa-close"></i></button></div>'
    },
    selectedClass: 'bg-light'
  });
});

function inventorySearch() {
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