<template>
  <div class="section">
    <h4 class="section-title">{{section.title}}</h4>
    <div class="dropdown btn-dropdown">
      <a href="" id="dropdown_section" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
        <i class="material-icons">more_vert</i>
      </a>
      <div class="dropdown-menu dropdown-menu-right">
        <a class="dropdown-item" href="#">이름 수정</a>
        <a class="dropdown-item" href="" v-if="section.posts.length ===0" v-on:click="deleteSection" data-confirm="이 섹션을 제거할까요? ">섹션 제거</a>
      </div>
    </div>

    <draggable class="section-body"
               v-model="section.posts"
               :options="{group: 'posts'}"
               @change="postMoved">
      <post v-for="post in section.posts"
            :key="post.id"
            :post="post"
            :section="section"
            :current_user="current_user">
      </post>
      <div class="form-group form-post">
        <textarea class="form-control" rows="4" placeholder="포스트 내용 입력"
                  v-if="editing" ref="message" v-model="messages" v-on:keydown.meta.enter="createPost"></textarea>

        <div class="btn-wrap">
          <button class="btn btn-primary btn-add-post" v-if="editing" v-on:click="createPost">추가</button>
          <a class="btn btn-cancel" v-if="editing" v-on:click="editing=false">취소</a>
        </div>
      </div>
    </draggable>

    <button class="btn btn-primary btn-md btn-add" v-if="!editing" v-on:click="startEditing">
      포스트 작성
    </button>
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
            this.messages = ""
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
        data.append("post[id]", element.id);
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
        })
      }
    }
  }
</script>