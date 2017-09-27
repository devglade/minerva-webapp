<% if user_signed_in? %>
$('<%= j render 'form', locals: {post: @post} %>').on('hidden.bs.modal', (e) ->
  $(this).remove()
  $('.modal-backdrop').remove()
  return
).modal()
<% else %>
alert '로그인하세요'
<% end %>