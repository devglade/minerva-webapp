<template>
    <div>
        <div @click="editing=true" class="card card-body mb-3 card-text">
            {{post.content}}
        </div>

        <div v-if='editing' class="modal-backdrop show"></div>

        <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{ post.content}}</h5>
                    </div>
                    <div class="modal-body">
                        <input v-model="content" class="form-control"/>
                    </div>
                    <div class="modal-footer">
                        <button @click="save" type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import * as Rails from "rails-ujs";

    export default {
        props: ["section", "post"],
        data: function () {
            return {
                editing: false,
                content: this.post.content,
            }
        },

        methods: {
            closeModal: function (event) {
                if (event.target.classList.contains("modal")) {
                    this.editing = false
                }
            },

            save: function () {
                var data = new FormData
                data.append("post[content]", this.content)

                Rails.ajax({
                    beforeSend: () => true,
                    url: window.location.href + `/sections/${this.section.id}/posts/${this.post.id}`,
                    type: "PATCH",
                    data: data,
                    dataType: "json",
                    success: (data) => {
                        const section_index = window.store.sections.findIndex((item) => item.id === data.section_id);
                        const post_index = window.store.sections[section_index].posts.findIndex((item) => item.id === this.post.id)
                        window.store.sections[section_index].posts.splice(post_index, 1, data)

                        this.editing = false
                    }
                })
            },
        }
    }
</script>

<style scoped>
    .card-text {
        white-space: normal;
    }
</style>
