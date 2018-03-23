<% if @space.errors.empty? %>
$(".modal").modal('hide')
$("#space-<%= @space.id %>").replaceWith("<%= j render @space %>")
<% else %>
alert("수정하지 못했습니다. 다시 시도해주세요.")
<% end %>