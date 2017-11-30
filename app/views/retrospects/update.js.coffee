<% if @retrospect.errors.empty? %>
$(".modal").modal('hide')
$("#retrospect-<%= @retrospect.id %>").replaceWith("<%= j render @retrospect %>")
<% else %>

<% end %>