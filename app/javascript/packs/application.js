/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

window.store = {}
document.addEventListener("turbolinks:load", function () {
    var element = document.querySelector("#boards")
    if (element !== undefined) {
        window.store.sections = JSON.parse(element.dataset.sections);

        const app = new Vue({
            el: element,
            data: {
                sections: window.store.sections,
                spin_id: element.dataset.spinId,
            },
            template: "<App :original_sections='sections' :spin_id='spin_id' />",
            components: {App}
        })
    }
})
