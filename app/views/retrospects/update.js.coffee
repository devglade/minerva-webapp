<% if @retrospect.errors.empty? %>
$(".modal").modal('hide')
$("#retrospect-<%= @retrospect.id %>").replaceWith("<%= j render @retrospect %>")
<% else %>
alert("수정하지 못했습니다. 다시 시도해주세요.")
<% end %>