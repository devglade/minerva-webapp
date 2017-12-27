<% if @spin.errors.empty? %>
$(".modal").modal('hide')
$("#spin-<%= @spin.id %>").replaceWith("<%= j render @spin %>")
<% else %>
alert("수정하지 못했습니다. 다시 시도해주세요.")
<% end %>