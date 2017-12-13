<% if @retrospect.errors.empty? %>
$(".modal").modal('hide');
if $('#retrospect-' + <%= @retrospect.id %>).length == 0
  $('.retrospect-list-group').prepend('<%= j render @retrospect %>');
<% else %>
alert '글 등록이 되지 않았습니다.. 다시 시도해주세요.'
$(".modal").html '<%= j render partial: 'form', locals: {retrospect: @retrospect}  %>'
<% end %>