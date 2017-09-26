<% if user_signed_in? %>
$("#modal-dialog").html('<%= j render partial: 'form', locals: {post: @post} %>')
$("#modal-dialog").modal('show')
<% else %>
alert '로그인하세요'
<% end %>
