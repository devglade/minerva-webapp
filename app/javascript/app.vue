<template>
    <draggable v-model="sections" :options="{groups: 'sections'}" class="board dragArea" @end="sectionMoved">
        <sectionList v-for="(section, index) in sections" :section="section" :space_id="space_id"
                     :project_id="project_id"></sectionList>
    </draggable>
</template>

<script>
    import draggable from 'vuedraggable'
    import sectionList from 'componenets/section_list'

    const Rails = require('rails-ujs');

    export default {
        components: {draggable, sectionList},
        props: ["original_sections", "space_id", "project_id"],
        data: function () {
            return {
                sections: this.original_sections,
            }
        },
        methods: {
            sectionMoved: function (event) {
                var data = new FormData
                data.append("section[position]", event.newIndex + 1)
                Rails.ajax({
                    beforeSend: () => true,
                    url: `/spaces/${this.space_id}/projects/${this.project_id}/spins/${window.store.sections[event.newIndex].spin_id}/sections/${this.sections[event.newIndex].id}/move`,
                    type: "PATCH",
                    data: data,
                    dataType: "json",
                })
            },
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


</style>