<% if @retrospect.errors.any? %>
  alert '글 등록이 되지 않았습니다.. 다시 시도해주세요.'
  $(".modal").html '<%= j render partial: 'form', locals: {spin: @spin}  %>'
<% else %>
  $(".modal").modal('hide')
<% end %>