<% if @project.errors.empty? %>
$(".modal").modal('hide')
$("#project-<%= @project.id %>").replaceWith("<%= j render @project %>")
<% else %>
alert("수정하지 못했습니다. 다시 시도해주세요.")
<% end %>