<% if @post.errors.any? %>
  alert '글 등록이 되지 않았습니다.. 다시 시도해주세요.'
  $(".modal").html '<%= j render partial: 'form', locals: {post: @post}  %>'
<% else %>
  $(".modal").modal('hide')
  $('#board').append '<%= j render partial: 'post', object: @post %>'
<% end %>