<template>
  <draggable class="spin-board dragArea" v-model="sections" :options="{groups: 'sections'}" @end="sectionMoved">
    <sectionList v-for="(section, index) in sections" :section="section" :current_user="current_user"></sectionList>

    <div class="section create-section">
      <a v-if="!editing" v-on:click="startEditing">Add a list</a>
      <textarea v-if="editing" v-model="message" ref="message" class="form-control mb-1"></textarea>
      <button v-if="editing" v-on:click="createSection" class="btn btn-secondary">Add</button>
      <a v-if="editing" v-on:click="editable=false">Cancel</a>
    </div>
  </draggable>
</template>

<script>
  import draggable from 'vuedraggable'
  import sectionList from 'components/section_list'

  const Rails = require('rails-ujs');

  export default {
    props: ['current_user'],
    components: {draggable, sectionList},
    data: function () {
      return {
        editing: false,
        message: "",
      }
    },
    computed: {
      sections: {
        get() {
          return this.$store.state.sections
        },
        set(value) {
          this.$store.state.sections = value
        },
      },
    },

    methods: {
      startEditing: function () {
        this.editing = true
        this.$nextTick(() => {
          this.$refs.message.focus()
        })
      },

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

      createSection: function () {
        var data = new FormData
        data.append("section[title]", this.message)

        Rails.ajax({
          beforeSend: () => true,
          url: window.location.href + `/sections`,
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {
            this.message = ""
            this.editing = false
          }
        })
      },
    }
  }
</script>