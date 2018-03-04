<% if @project.errors.empty? %>
$("#project-<%= @project.id %>").remove()
<% else %>

<% end %>