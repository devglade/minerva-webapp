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
        moveSection(state, data) {
            const index = state.sections.findIndex(item => item.id === data.id)
            state.sections.splice(index, 1)
            state.sections.splice(data.position - 1, 0, data)
        },
        addPost(state, data) {
            const index = state.sections.findIndex(item => item.id === data.section_id)
            if (state.sections[index].posts === undefined) {
                state.sections[index].posts = [];
            }
            state.sections[index].posts.push(data)

        },
        editPost(state, data) {
            const section_index = state.sections.findIndex((item) => item.id === data.section_id)
            const post_index = state.sections[section_index].posts.findIndex((item) => item.id === data.id)
            state.sections[section_index].posts.splice(post_index, 1, data)
        },

        movePost(state, data) {
            const old_list_index = state.sections.findIndex((section) => {
                return section.posts.find((card) => {
                    return card.id === data.id
                })
            })
            const old_card_index = state.sections[old_list_index].posts.findIndex((item) => item.id === data.id)
            const new_list_index = state.sections.findIndex((item) => item.id === data.section_id)

            if (old_list_index !== new_list_index) {
                // Remove card from old list, add to new one
                state.sections[old_list_index].posts.splice(old_card_index, 1)
                state.sections[new_list_index].posts.splice(data.position - 1, 0, data)
            } else {
                state.sections[new_list_index].posts.splice(old_card_index, 1)
                state.sections[new_list_index].posts.splice(data.position - 1, 0, data)
            }
        }
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
