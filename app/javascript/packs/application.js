// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'stylesheets/application.scss';
require('./main_vue.js');
import * as $ from 'jquery';
require("bootstrap")
import("@fortawesome/fontawesome-free/js/all");
window.Routes = require('routes');
import 'controllers'

import 'home'
import 'recipes'

window.perPage = function(elem) {
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

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
