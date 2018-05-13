// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require popper
//= require bootstrap
//= require_tree .

// $(document).ready(_ => {
//   $('#search').on('keyup', _ => {
//     if($('#search').val().length > 3) {
//       $.ajax({
//         url: '/search.json',
//         type: 'POST',
//         data: {search: $('#search').val()},
//         success: function(data) {
//           console.log(data);
//         }
//       })
//     }
//   })
// })

function perPage(elem) {
  var uri=window.location.href;
  var val = $(elem).val();
  if(uri.includes('per_page=')) {
    var new_uri = uri.replace(/per_page=(\d*)/, 'per_page=' + val);
  } else if(window.location.search == '') {
    var new_uri = uri + '?per_page=' + val;
  } else {
    var new_uri = uri + '&per_page=' + val;
  }
  window.location = new_uri;
}