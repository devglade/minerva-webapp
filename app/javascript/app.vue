<template>
    <div id="app" class="row">
        <div v-for="section in original_sections" class="col-3">
            <h6> {{section.title}}</h6>
            <hr/>

            <div v-for="(post, index) in section.posts" class="card card-body">
                {{post.content}}
            </div>
        </div>

    </div>
</template>

<script>
    export default {
        props: ["original_sections"],
    }
</script>

<style scoped>
    p {
        font-size: 2em;
        text-align: center;
    }
</style>
