<% if @post.errors.empty? %>
$(".modal").modal('hide')
$("#post-<%= @post.id %>").replaceWith("<%= j render @post %>")
<% else %>
alert("수정하지 못했습니다. 다시 시도해주세요.")
<% end %>