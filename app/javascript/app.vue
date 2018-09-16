<template>
    <draggable v-model="sections" :options="{groups: 'sections'}" class="board dragArea" @end="sectionMoved">
        <sectionList v-for="(section, index) in sections" :section="section"></sectionList>
    </draggable>
</template>

<script>
    import draggable from 'vuedraggable'
    import sectionList from 'components/section_list'

    const Rails = require('rails-ujs');

    export default {
        components: {draggable, sectionList},
        props: ["original_sections"],
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
                    url: window.location.href + `/sections/${this.sections[event.newIndex].id}/move`,
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