<% if @spin.errors.empty? %>
$(".modal").modal('hide')
$("#spin-<%= @spin.id %>").replaceWith("<%= j render @spin %>")
<% else %>

<% end %>