<template>
    <div>
        <div @click="editing=true" class="card card-body mb-3 card-text">
            {{post.content}}
            <div class="user-info">
                <div class="user-image">
                    <div v-if="post.user.image_id ==null">
                        <img class="profile-img" src="~images/img_profile_default.png">
                    </div>
                    <div v-else>
                        <img :src="getImgUrl(post.user.image_id)" class="profile-img">
                    </div>
                </div>
                {{post.user.name}}
            </div>
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
                    <div v-if="current_user.id === post.user.id">
                        <div class="modal-footer">
                            <button @click="save" type="button" class="btn btn-primary">저장</button>
                            <button @click="deletePost" type="button" class="btn btn-primary">삭제</button>
                        </div>
                    </div>
                    <div v-else>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary">닫기</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import * as Rails from "rails-ujs";
    import 'images/img_profile_default.png'

    export default {
        props: ["section", "post", "current_user"],
        data: function () {
            return {
                editing: false,
                content: this.post.content,
            }
        },

        methods: {
            getImgUrl(image_id) {
                if (image_id != null) {
                    return `http://res.cloudinary.com/minerva-webapp/image/upload/v1539405240/${image_id}`
                } else {
                    return '~images/img_profile_default.png'
                }
            },
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
                    success: () => {
                        this.editing = false
                    }
                })
            },

            deletePost: function () {
                console.log("deletePost")
                Rails.ajax({
                    beforeSend: () => true,
                    url: window.location.href + `/sections/${this.section.id}/posts/${this.post.id}`,
                    type: "DELETE",
                    dataType: "json",

                    success: () => {
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

    .user-info {
        width: 100%;
        display: flex;
        justify-content: flex-end;
        flex-direction: row;
        align-items: center;
    }

    .profile-img {
        height: 40px;
        width: 40px;
        border-radius: 50%;
        margin-right: 5px;
    }
</style>
