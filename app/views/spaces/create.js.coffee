<% if @space.errors.empty? %>
$(".modal").modal('hide');
if $('#space-' + <%= @space.id %>).length == 0
  $('.space-list-group').prepend('<%= j render @space %>');
<% else %>
alert("<%= j flash[:error].join('; ') %>")
<% end %>