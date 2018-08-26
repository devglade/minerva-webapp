<template>
    <div class="section">
        <h6> {{section.title}}</h6>
        <draggable v-model="section.posts" :options="{group: 'posts'}" class="dragArea" @change="postMoved">
            <div v-for="(post, index) in section.posts" class="card card-body mb-3">
                <div class="card-text">
                    {{post.content}}
                </div>
            </div>
        </draggable>

        <a v-if="!editing" v-on:click="startEditing">Add a post</a>
        <textarea v-if="editing" ref="message" v-model="messages" class="form-control mb-1"></textarea>
        <button v-if="editing" v-on:click="submitMessages" class="btn btn-secondary">Add</button>
        <a v-if="editing" v-on:click="editing=false">Cancel</a>
    </div>
</template>

<script>
    import draggable from 'vuedraggable'
    import * as Rails from "rails-ujs";

    export default {
        components: {draggable},
        props: ["section", "space_id", "project_id", "spin_id"],
        data: function () {
            return {
                editing: false,
                messages: ""
            }
        },
        methods: {
            startEditing: function () {
                this.editing = true
                this.$nextTick(() => {
                    this.$refs.message.focus();
                })
            },
            submitMessages: function () {
                var data = new FormData;
                data.append("post[section_id]", this.section.id);
                data.append("post[content]", this.messages);
                Rails.ajax({
                    beforeSend: () => true,
                    url: `/spaces/${this.space_id}/projects/${this.project_id}/spins/${this.section.spin_id}/sections/${this.section.id}/posts`,
                    type: "POST",
                    data: data,
                    dataType: "json",
                    success: (data) => {
                        const index = window.store.sections.findIndex(item => item.id === this.section.id);
                        window.store.sections[index].posts.push(data);
                        this.messages = "";
                    }
                });
                this.$nextTick(() => {
                    this.$refs.message.focus();
                })
            },
            postMoved: function (event) {
                const evt = event.added || event.moved
                if (evt == undefined) {
                    return
                }
                const element = evt.element

                const section_index = window.store.sections.findIndex((section) => {
                    return section.posts.find((post) => {
                        return post.id === element.id
                    })
                });

                var data = new FormData;
                let sectionId = window.store.sections[section_index].id;
                data.append("post[section_id]", sectionId);
                data.append("post[position]", evt.newIndex + 1);
                Rails.ajax({
                    beforeSend: () => true,
                    url: `/spaces/${this.space_id}/projects/${this.project_id}/spins/${element.spin_id}/sections/${sectionId}/posts/${element.id}/move`,
                    type: "PATCH",
                    data: data,
                    dataType: "json"
                })
            },
        }
    }
</script>
<style scoped>
    .dragArea {
        min-height: 10px;
    }

    .card-text {
        white-space: normal;
    }

    .section {
        display: inline-block;
        border-radius: 3px;
        padding: 20px;
        background: #E2E4E6;
        width: 270px;
        vertical-align: top;
        margin-right: 56px;
    }
</style>