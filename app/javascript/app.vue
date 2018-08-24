<template>
    <div id="app" class="row">
        <div v-for="section in original_sections" class="col-3">
            <h6> {{section.title}}</h6>
            <hr/>

            <div v-for="(post, index) in section.posts" class="card card-body">
                {{post.content}}
            </div>

            <div class="card card-body">
                <textarea v-model="messages[section.id]" class="form-control"></textarea>
                <button v-on:click="submitMessages(space_id, project_id, spin_id, section.id)"
                        class="btn btn-secondary">Add
                </button>
            </div>
        </div>
    </div>
</template>

<script>
    import * as Rails
        from "../../../../.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/actionview-5.1.6/lib/assets/compiled/rails-ujs";

    export default {
        props: ["original_sections", "space_id", "project_id", "spin_id"],
        data: function () {
            return {
                messages: {},
                sections: this.original_sections,
            }
        },
        methods: {
            submitMessages: function (space_id, project_id, spin_id, section_id) {
                var data = new FormData;
                data.append("post[section_id]", section_id);
                data.append("post[content]", this.messages[section_id]);
                Rails.ajax({
                    beforeSend: () => true,
                    url: '/spaces/' + space_id + '/projects/' + project_id + '/spins/' + spin_id + '/sections/' + section_id + '/posts',
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
    p {
        font-size: 2em;
        text-align: center;
    }
</style>
