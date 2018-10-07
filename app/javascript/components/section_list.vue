<template>

    <div class="section-list">
        <span> {{section.title}}</span>
        <span class="float-right link" v-if="section.posts.length ===0" v-on:click="deleteSection">삭제</span>
        <draggable v-model="section.posts" :options="{group: 'posts'}" class="dragArea" @change="postMoved">
            <post v-for="post in section.posts" :key="post.id" :post="post" :section="section"></post>
        </draggable>

        <a v-if="!editing" v-on:click="startEditing">Add a post</a>
        <textarea v-if="editing" ref="message" v-model="messages" class="form-control mb-1"></textarea>
        <button v-if="editing" v-on:click="createPost" class="btn btn-secondary">Add</button>
        <a v-if="editing" v-on:click="editing=false">Cancel</a>
    </div>
</template>

<script>
    import draggable from 'vuedraggable'
    import post from 'components/post'
    import * as Rails from "rails-ujs";


    export default {
        components: {draggable, post},
        props: ["section", "current_user"],

        data: function () {
            return {
                editing: false,
                messages: "",
            }
        },

        methods: {
            startEditing: function () {
                this.editing = true
                this.$nextTick(() => {
                    this.$refs.message.focus();
                })
            },

            createPost: function () {
                var data = new FormData;
                data.append("post[section_id]", this.section.id);
                data.append("post[content]", this.messages);

                Rails.ajax({
                    beforeSend: () => true,
                    url: window.location.href + `/sections/${this.section.id}/posts`,
                    type: "POST",
                    data: data,
                    dataType: "json",
                    success: (data) => {
                        this.message = ""
                        this.$nextTick(() => {
                            this.$refs.message.focus()
                        })
                    }
                });
            },

            postMoved: function (event) {
                const evt = event.added || event.moved
                if (evt === undefined) {
                    return
                }
                const element = evt.element
                const section_index = window.store.state.sections.findIndex((section) => {
                    return section.posts.find((post) => {
                        return post.id === element.id
                    })
                });

                var data = new FormData;
                let sectionId = window.store.state.sections[section_index].id;
                data.append("post[section_id]", sectionId);
                data.append("post[position]", evt.newIndex + 1);

                Rails.ajax({
                    beforeSend: () => true,
                    url: window.location.href + `/sections/${sectionId}/posts/${element.id}/move`,
                    type: "PATCH",
                    data: data,
                    dataType: "json"
                })
            },

            deleteSection: function () {
                Rails.ajax({
                    beforeSend: () => true,
                    url: window.location.href + `/sections/${this.section.id}`,
                    type: "DELETE",
                    dataType: "json",
                    success: (data) => {

                    }
                })
            }
        }
    }
</script>
<style scoped>
    .dragArea {
        min-height: 10px;
    }

    .link {
        cursor: pointer;
    }

</style>