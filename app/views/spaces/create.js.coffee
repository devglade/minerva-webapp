<% if @space.errors.empty? %>
$(".modal").modal('hide');
if $('#space-' + <%= @space.id %>).length == 0
  $('.space-list-group').prepend('<%= j render @space %>');
<% else %>
alert '글 등록이 되지 않았습니다.. 다시 시도해주세요.'
$(".modal").html '<%= j render partial: 'form', locals: {space: @space}  %>'
<% end %>