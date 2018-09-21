/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import App from '../app.vue'
import TurbolinksAdapter from 'vue-turbolinks'

Vue.use(Vuex)
Vue.use(TurbolinksAdapter)

window.store = new Vuex.Store({
    state: {
        sections: []
    },

    mutations: {
        addSection(state, data) {
            state.sections.push(data)
        },
        addPost(state, data) {
            const index = state.sections.findIndex(item => item.id == data.section_id)
            state.sections[index].posts.push(data)
        },
    }
});
document.addEventListener("turbolinks:load", function () {
    var element = document.querySelector("#boards")
    if (element !== undefined) {
        window.store.state.sections = JSON.parse(element.dataset.sections)

        const app = new Vue({
            el: element,
            store: window.store,
            template: "<App />",
            components: {App}
        })
    }
})
