<% if @project.errors.empty? %>
$(".modal").modal('hide');
if $('#project-' + <%= @project.id %>).length == 0
  $('.create-project').after("<%= j render @project %>");
<% else %>
alert '글 등록이 되지 않았습니다.. 다시 시도해주세요.'
$(".modal").html '<%= j render partial: 'form', locals: {retrospect: @project}  %>'
<% end %>