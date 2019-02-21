<template>
  <draggable class="spin-board" v-model="sections" :options="{groups: 'sections'}" @end="sectionMoved">
    <sectionList v-for="(section, index) in sections" :section="section" :current_user="current_user"></sectionList>

    <div class="section create-section">
      <a class="btn btn-create"
         v-if="!editing" v-on:click="startEditing"
         data-toggle="tooltip" data-placement="right" title="Tooltip on right">
        <i class="material-icons">add</i>
      </a>

      <div class="section-header">
        <div class="form-group">
          <input class="form-control" type="text" placeholder="새로운 섹션 이름 입력"
                 v-if="editing" v-model="message" ref="message" v-on:keyup.enter="createSection">
          <button class="btn btn-primary" v-if="editing" v-on:click="createSection">추가</button>
          <a class="btn btn-cancel" v-if="editing" v-on:click="editable=false">취소</a>
        </div>
      </div>
    </div>
  </draggable>
</template>

<script>
  import draggable from 'vuedraggable'
  import sectionList from 'components/section_list'

  const Rails = require("@rails/ujs").start()

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