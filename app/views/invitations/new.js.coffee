<% if user_signed_in? %>
$(document).on 'hidden.bs.modal', '.modal', -> $(this).remove()

$('<%= j render 'form', locals: {invitation: @invitation, space: @space, sender_id: @sender_id} %>').on('submit', (e) ->
).modal('toggle')
<% else %>
alert '로그인하세요'
<% end %>
