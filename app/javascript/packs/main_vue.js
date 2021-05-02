/* eslint no-console: 0 */
import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import VueTagsInput from '@johmun/vue-tags-input';
import axios from 'axios';

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#vue_app',
    components: {
      VueTagsInput,
      // App,
    },
    data: () => {
      return {
        message: "Can you say hello?",
        tag: '',
        tags: [],
        autocompleteItems: [],
        debounce: null,
      }
    },
    watch: {
      'tag': 'initItems',
    },
    methods: {
     update(newTags) {
       this.autocompleteItems = [];
       this.tags = newTags;
     },
     initItems() {
       if (this.tag.length < 2) return;
       // const url = Routes.tags_path({format: 'json', only: 'name', all: 'true', q: this.tag});
       const url = '';

       clearTimeout(this.debounce);
       this.debounce = setTimeout(() => {
         axios.get(url).then(response => {
           this.autocompleteItems = response.data.map(a => {
             return { text: a.name };
           });
         }).catch(() => console.warn('Oh. Something went wrong'));
       }, 600);
     },
    },
  })
})
