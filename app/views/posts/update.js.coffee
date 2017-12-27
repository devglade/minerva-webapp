<% if @post.errors.empty? %>
$(".modal").modal('hide')
$("#board").prepend("<%= j render @post %>")
<% else %>

<% end %>