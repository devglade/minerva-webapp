<template>
    <draggable v-model="sections" :options="{groups: 'sections'}" class="board dragArea" @end="sectionMoved">
        <div v-for="(section, index) in sections" class="section">
            <h6> {{section.title}}</h6>
            <draggable v-model="section.posts" :options="{group: 'posts'}" class="dragArea" @change="postMoved">
                <div v-for="(post, index) in section.posts" class="card card-body">
                    <div class="card-text">
                        {{post.content}}
                    </div>
                </div>
            </draggable>

            <textarea v-model="messages[section.id]" class="form-control mb-1"></textarea>
            <button v-on:click="submitMessages(section.id)" class="btn btn-secondary">Add</button>
        </div>
    </draggable>
</template>

<script>
    import draggable from 'vuedraggable'

    const Rails = require('rails-ujs');

    export default {
        components: {draggable},
        props: ["original_sections", "space_id", "project_id", "spin_id"],
        data: function () {
            return {
                messages: {},
                sections: this.original_sections,
            }
        },
        methods: {
            sectionMoved: function (event) {
                var data = new FormData
                data.append("section[position]", event.newIndex + 1)
                Rails.ajax({
                    beforeSend: () => true,
                    url: `/spaces/${this.space_id}/projects/${this.project_id}/spins/${this.spin_id}/sections/${this.sections[event.newIndex].id}/move`,
                    type: "PATCH",
                    data: data,
                    dataType: "json",
                })
            },
            postMoved: function (event) {
                const evt = event.added || event.moved
                if (evt == undefined) {
                    return
                }
                const element = evt.element

                const section_index = this.sections.findIndex((section) => {
                    return section.posts.find((post) => {
                        return post.id === element.id
                    })
                });

                var data = new FormData
                data.append("post[section_id]", this.sections[section_index].id)
                data.append("post[position]", evt.newIndex + 1)

                Rails.ajax({
                    beforeSend: () => true,
                    url: `/spaces/${this.space_id}/projects/${this.project_id}/spins/${this.spin_id}/sections/${this.sections[section_index].id}/posts/${element.id}/move`,
                    type: "PATCH",
                    data: data,
                    dataType: "json"
                })
            },
            submitMessages: function (section_id) {
                var data = new FormData;
                data.append("post[section_id]", section_id);
                data.append("post[content]", this.messages[section_id]);
                Rails.ajax({
                    beforeSend: () => true,
                    url: `/spaces/${this.space_id}/projects/${this.project_id}/spins/${this.spin_id}/sections/${section_id}/posts`,
                    type: "POST",
                    data: data,
                    dataType: "json",
                    success: (data) => {
                        const index = this.sections.findIndex(item => item.id === section_id);
                        this.sections[index].posts.push(data);
                        this.messages[section_id] = undefined;
                    }
                });
            }
        }
    }
</script>

<style scoped>
    .dragArea {
        min-height: 10px;
    }

    .board {
        white-space: nowrap;
        overflow-x: auto;
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