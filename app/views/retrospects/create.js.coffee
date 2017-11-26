<% if @retrospect.errors.any? %>
alert '글 등록이 되지 않았습니다.. 다시 시도해주세요.'
$(".modal").html '<%= j render partial: 'form', locals: {retrospect: @retrospect}  %>'
<% else %>
$(".modal").modal('hide')
$('.list-group > ul').prepend '<%= j render partial: 'retrospect', object: @retrospect %>'
<% end %>