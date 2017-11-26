<% if @retrospect.errors.empty? %>
$(".modal").modal('hide')
$("#retrospect-<%= @retrospect.id %>").html("<%= j render @retrospect %>")
<% else %>

<% end %>