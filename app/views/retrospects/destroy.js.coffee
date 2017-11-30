<% if @retrospect.errors.empty? %>
$("#retrospect-<%= @retrospect.id %>").remove()
<% else %>

<% end %>